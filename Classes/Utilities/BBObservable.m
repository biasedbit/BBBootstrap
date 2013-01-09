//
// Copyright 2012 BiasedBit
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
//  Copyright (c) 2012 BiasedBit. All rights reserved.
//

#import "BBObservable.h"

#import "BBWeakWrapper.h"



#pragma mark -

@implementation BBObservable
{
    dispatch_queue_t _observableQueue;

    NSMutableSet* _observers;
}


#pragma mark Creation

- (id)init
{
    self = [super init];
    if (self != nil) {
        NSString* queueName = [NSString stringWithFormat:@"com.biasedbit.Observable-%@-%p",
                               NSStringFromClass([self class]), self];
        _observableQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
        _observers = [NSMutableSet set];
    }

    return self;
}


#pragma mark Destruction

#if !OS_OBJECT_USE_OBJC
- (void)dealloc
{
    dispatch_release(_observableQueue);
}
#endif


#pragma mark Interface

- (void)addObserver:(id)observer
{
    dispatch_sync(_observableQueue, ^{
        BBWeakWrapper* wrapper = [BBWeakWrapper wrapperForObject:observer];
        [_observers addObject:wrapper];
    });
}

- (void)removeObserver:(id)observer
{
    dispatch_sync(_observableQueue, ^{
        // This wrapper will pass the isEqual: test so we're sure to remove the object from the set
        BBWeakWrapper* wrapper = [BBWeakWrapper wrapperForObject:observer];
        [_observers removeObject:wrapper];
    });
}

- (NSUInteger)observerCount
{
    return [_observers count];
}

- (void)notifyObserversAsynchronouslyInMainQueueWithBlock:(void (^)(id observer))block
{
    [self notifyObserversInAsynchronousQueue:dispatch_get_main_queue() withBlock:block];
}

- (void)notifyObserversWithBlock:(void (^)(id observer))block
{
    [self notifyObserversInAsynchronousQueue:NULL withBlock:block];
}

- (void)notifyObserversInAsynchronousQueue:(dispatch_queue_t)queue withBlock:(void (^)(id observer))block
{
    dispatch_sync(_observableQueue, ^{
        for (BBWeakWrapper* wrapper in _observers) {
            id observer = [wrapper object];

            // Cleanup dead observers
            if (observer == nil) {
                LogTrace(@"[%@] Found dead observer, cleaning...", [self logId]);
                [_observers removeObject:wrapper];
            } else if (queue == NULL) {
                block(observer);
            } else {
                dispatch_async(queue, ^{
                    block(observer);
                });
            }
        }
    });
}

@end
