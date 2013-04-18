//
// Copyright 2013 BiasedBit
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

//
//  Created by Bruno de Carvalho (@biasedbit, http://biasedbit.com)
//  Copyright (c) 2013 BiasedBit. All rights reserved.
//

#import "BBQueue.h"


#pragma mark - Constants

NSUInteger const kBBQueueMaxQueueSize = 10240;



#pragma mark -

@implementation BBQueue
{
    dispatch_queue_t _queue;
    NSUInteger _slots;
    NSUInteger _maxQueueSize;

    NSString* _name;
    NSMutableDictionary* _running;
    NSMutableArray* _queued;
}


#pragma mark Creation

- (instancetype)init
{
    NSAssert(NO, @"Call -initWithName:andSlots:");
    return nil;
}

- (instancetype)initWithName:(NSString*)name andSlots:(NSUInteger)slots
{
    return [self initWithName:name slots:slots andMaxQueueSize:kBBQueueMaxQueueSize];
}

- (instancetype)initWithName:(NSString*)name slots:(NSUInteger)slots andMaxQueueSize:(NSUInteger)maxQueueSize
{
    self = [super init];
    if (self != nil) {
        _name = name;
        _slots = slots;
        _maxQueueSize = maxQueueSize;

        NSString* queueName = [NSString stringWithFormat:@"com.biasedbit.BBQueue-%@", _name];
        _queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
        _running = [NSMutableDictionary dictionaryWithCapacity:_slots];
        _queued = [NSMutableArray arrayWithCapacity:_maxQueueSize];
    }

    return self;
}


#pragma mark Destruction

#if !OS_OBJECT_USE_OBJC
- (void)dealloc
{
    dispatch_release(_queue);
}
#endif


#pragma mark Interface

- (id<BBQueueOperation>)enqueueOperationWithId:(NSString*)identifier andParams:(NSDictionary*)params
{
    return [self enqueueOperationWithId:identifier andParams:params prioritize:NO];
}

- (id<BBQueueOperation>)enqueueOperationWithId:(NSString*)identifier andParams:(NSDictionary*)params
                                    prioritize:(BOOL)prioritize
{
    /*
     1. Look for a running operation to immediately return
     2. Look for an enqueued operation to immediately return (2b. and move to head of queue if prioritize is set to YES)
     3. Insert operation and:
        a. Immediately execute it if running slots are available
        b. Insert at head of queue if prioritize is set to YES
        c. Add to tail of queue if prioritize is set to NO
     */
    __block id<BBQueueOperation> operation = nil;
    dispatch_sync(_queue, ^{
        operation = [self runningOperationWithId:identifier];
        if (operation != nil) return; // 1.

        operation = [self queuedOperationWithId:identifier];
        if (operation != nil) {
            if (prioritize) [self prioritizeOperation:operation]; // 2b.
            return; // 2.
        }

        operation = [self createOperationWithId:identifier andParams:params];
        BOOL canBeginExecutingImmediately = [_running count] < _slots;

        if (canBeginExecutingImmediately) { // 3a.
            [self executeOperation:operation];
        } else {
            [self addToQueue:operation prioritize:YES];
        }
    });

    return operation;
}

- (void)operationFinished:(id<BBQueueOperation>)operation
{
    // Execute the synchronized block in other thread to keep the calling code from blocking while the queue is
    // launching the next task
    dispatch_async_default_priority(^{
        [self notifyDelegateOfFinishedOperation:operation];

        dispatch_sync(_queue, ^{
            [self deleteFinishedOperation:operation];
            
            while (true) {
                // Pop next one in line from the queue
                id<BBQueueOperation> nextOperation = [self popQueuedOperation];
                if (nextOperation == nil) return;
                
                // If the retrieval hasn't been cancelled yet, execute the request
                if (![nextOperation isQueueOperationCancelled]) {
                    [self executeOperation:nextOperation];
                    return;
                }
                
                // If the operation was cancelled, let it slide to the end of the loop; we'll keep at this until we find
                // a request we can begin or there are no more requests left
            }
        });
    });
}


#pragma mark Private helpers

- (id<BBQueueOperation>)runningOperationWithId:(NSString*)identifier
{
    return [_running objectForKey:identifier];
}

- (id<BBQueueOperation>)queuedOperationWithId:(NSString*)identifier
{
    // Just about the same as NSArray's contains: method, except we're comparing operationId
    for (id<BBQueueOperation> operation in _queued) {
        if ([[operation operationId] isEqualToString:identifier]) return operation;
    }
    
    return nil;
}

- (void)prioritizeOperation:(id<BBQueueOperation>)operation
{
    [_queued removeObject:operation];
    [_queued insertObject:operation atIndex:0];
}

- (void)addToQueue:(id<BBQueueOperation>)operation prioritize:(BOOL)prioritize
{
    if (prioritize) {
        [_queued insertObject:operation atIndex:0];
    } else {
        [_queued addObject:operation];
    }
}

- (id<BBQueueOperation>)createOperationWithId:(NSString*)identifier andParams:(NSDictionary*)params
{
    if (_delegate == nil) return nil;

    return [_delegate createOperationWithId:identifier andParams:params forQueue:self];
}

- (void)executeOperation:(id<BBQueueOperation>)operation
{
    [_running setObject:operation forKey:[operation operationId]];
    [operation beginQueueOperation];
}

- (void)deleteFinishedOperation:(id<BBQueueOperation>)operation
{
    [_running removeObjectForKey:[operation operationId]];
}

- (void)notifyDelegateOfFinishedOperation:(id<BBQueueOperation>)operation
{
    if ((_delegate != nil) && [_delegate respondsToSelector:@selector(queue:finishedOperation:)]) {
        dispatch_async_main(^{
            [_delegate queue:self finishedOperation:operation];
        });
    }
}

- (id<BBQueueOperation>)popQueuedOperation
{
    if ([_queued count] == 0) return nil;

    id<BBQueueOperation> nextInLine = [_queued objectAtIndex:0];
    [_queued removeObjectAtIndex:0];

    return nextInLine;
}

@end
