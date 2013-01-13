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

#import "BBCountDownLatch.h"

#import "BBGlobals.h"



#pragma mark -

@implementation BBCountDownLatch
{
    BBCountDownLatchBlock _block;

    // Whether the queue should be released when the latch finishes; for internally created queues.
    // No effect if OS_OBJECT_USE_OBJC is enabled (default on iOS 6+ and OSX 10.8+)
    BOOL _releaseQueueWhenDone;
}


#pragma mark Destruction

- (void)dealloc
{
#if !OS_OBJECT_USE_OBJC
    if (_releaseQueueWhenDone && (_queue != NULL)) {
        // If we were created with autoCleanup...
        dispatch_release(_queue);
    }
#endif
}


#pragma mark Creating latches

- (id)initWithName:(NSString*)name queue:(dispatch_queue_t)queue counter:(NSUInteger)counter
          andCompletionBlock:(BBCountDownLatchBlock)block
{
    self = [super init];
    if (self != nil) {
        _name = name;
        _queue = queue;
        _counter = counter;
        _cancelled = NO;
        _block = block;
    }

    return self;
}

+ (BBCountDownLatch*)autoCleanupLatchWithName:(NSString*)name counter:(NSUInteger)counter
                                     andCompletionBlock:(BBCountDownLatchBlock)block
{
    NSString* queueName = [NSString stringWithFormat:@"com.biasedbit.CDLQueue-%@", name];
    dispatch_queue_t queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);

    BBCountDownLatch* latch = [[BBCountDownLatch alloc]
                               initWithName:name queue:queue counter:counter andCompletionBlock:block];
    [latch releaseQueueWhenDone];

    return latch;
}


#pragma mark Managing state

- (BOOL)cancel
{
    if (_cancelled) return NO;

    _cancelled = YES;

    return YES;
}

- (BOOL)countDown
{
    return [self countDownWithCallerId:@"anonymous"];
}

- (BOOL)countDownWithCallerId:(NSString*)callerId
{
    __block BOOL output;
    dispatch_sync(_queue, ^{
        if (_counter == 0) {
            LogDebug(@"[LATCH-%@] '%@' tried to execute block but counter was already at 0; ignoring...",
                     _name, callerId);
            output = NO;
            return;
        }

        if (_cancelled) {
            LogDebug(@"[LATCH-%@] '%@' tried to execute block but latch has been cancelled; ignoring...",
                     _name, callerId);
            output = NO;
            return;
        }

        _counter -= 1;
        if (_counter == 0) {
            LogDebug(@"[LATCH-%@] Triggered and released by '%@'.", _name, callerId);
            dispatch_async_main(_block);
        } else {
            LogDebug(@"[LATCH-%@] Triggered by '%@'; current count: %d.", _name, callerId, _counter);
        }
        output = YES;
    });

    return output;
}

- (void)resetRequestCounter:(NSUInteger)newCounterValue
{
    _counter = newCounterValue;
}


#pragma mark Private helpers

- (void)releaseQueueWhenDone
{
    _releaseQueueWhenDone = YES;
}


#pragma mark Debug

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@{name='%@', counter=%u, queue='%s', cancelled=%@}",
            NSStringFromClass([self class]), _name, _counter, dispatch_queue_get_label(_queue),
            _cancelled ? @"YES" : @"NO"];
}

@end
