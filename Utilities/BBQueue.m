//
//  BBQueue.m
//  RemotelyTouch
//
//  Created by Bruno de Carvalho on 7/27/12.
//  Copyright (c) 2012 Graceful, LLC. All rights reserved.
//

#import "BBQueue.h"



#pragma mark -

@implementation BBQueue
{
    dispatch_queue_t _queue;
    NSUInteger _slots;
    NSUInteger _maxQueueSize;

    __strong NSString* _name;
    __strong NSMutableArray* _running;
    __strong NSMutableArray* _queued;
}


#pragma mark Creation

- (id)init
{
    NSAssert(NO, @"Call -initWithName:andSlots:");
    return nil;
}

- (id)initWithName:(NSString*)name andSlots:(NSUInteger)slots
{
    return [self initWithName:name slots:slots andMaxQueueSize:NSUIntegerMax];
}

- (id)initWithName:(NSString*)name slots:(NSUInteger)slots andMaxQueueSize:(NSUInteger)maxQueueSize
{
    self = [super init];
    if (self != nil) {
        _name = name;
        _slots = slots;
        _maxQueueSize = maxQueueSize;

        NSString* queueName = [NSString stringWithFormat:@"com.biasedbit.BBQueue-%@", _name];
        _queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
        _running = [NSMutableArray arrayWithCapacity:_slots];
        _queued = [NSMutableArray arrayWithCapacity:_maxQueueSize];
    }

    return self;
}


#pragma mark Destruction

- (void)dealloc
{
    dispatch_release(_queue);
}


#pragma mark Public methods

- (BOOL)enqueue:(id<BBQueueOperation>)queueOperation
{
    return [self enqueue:queueOperation prioritize:NO];
}

- (BOOL)enqueue:(id<BBQueueOperation>)queueOperation prioritize:(BOOL)prioritize
{
    __block BOOL enqueued = YES;
    dispatch_sync(_queue, ^{
        if ([_running count] > _slots) {
            if ([_queued count] > _maxQueueSize) {
                enqueued = NO;
                return;
            }

            if (prioritize) {
                [_queued insertObject:queueOperation atIndex:0];
            } else {
                [_queued addObject:queueOperation];
            }
        } else {
            [_running addObject:queueOperation];
            [queueOperation beginQueueOperation];
        }
    });

    return enqueued;
}

- (void)queueOperationFinished:(id<BBQueueOperation>)queueOperation
{
    dispatch_sync(_queue, ^{
        [_running removeObject:queueOperation];

        while (true) {
            // Nothing to execute, bail out...
            if ([_queued count] == 0) {
                return;
            }

            // Pop next one in line from the queue
            id<BBQueueOperation> queueOperation = [_queued objectAtIndex:0];
            [_queued removeObjectAtIndex:0];

            // If the retrieval hasn't been cancelled yet, execute the request
            if (![queueOperation isQueueOperationCancelled]) {
                [queueOperation beginQueueOperation];
                return;
            }

            // If the operation was cancelled, let it slide to the end of the loop; we'll keep at this until we find
            // a request we can begin or there are no more requests left
        }
    });
}

@end
