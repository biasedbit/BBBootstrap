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

#pragma mark -

/**
 Implementation of the observer pattern.
 
 Cocoa lacks proper support for the observer pattern implementation and notification center is hardly an elegant
 alternative.
 
 This class uses a GCD serial queue and block-friendly API to ensure atomicity.
 

 ## Observers and weak references
 
 While it is always a good policy to unregister an observer from the observable when he is about to be `dealloc`'d,
 this class is safe-by-design by wrapping the observers in a weak reference holder and storing that weak reference.
 
 While this wrapper (an instance of `BBWeakWrapper`) is strongly retained, the observer within is not (a `__weak`
 modifier is used). This may lead to an incorrect report of the number of observers being returned by `observerCount`.
 
 ### Automatic purging of "dead" observers
 
 When a notification is triggered and the list of observers (actually, the list of observer weak reference wrappers) is
 traversed, all the empty weak references will be automatically purged.
 
 
 ## Triggering notifications
 
 Subclasses should use one of the three notification alternatives (`notifyObserversAsynchronouslyInMainQueueWithBlock:`,
 `notifyObserversWithBlock:` or `notifyObserversInAsynchronousQueue:withBlock:`) to trigger notifications to the
 observers. The reason why the observer set is not exposed os precisely to prevent subclasses to directly access it.
 
 Typically, you'll want to use `notifyObserversAsynchronouslyInMainQueueWithBlock:`. The other two are for very specific
 behavior and you should only use them if you know exactly what you're doing.
 

 ## Subclassing notes
 
 You should only override the `addObserver:` and `removeObserver:` methods in this class to ensure type safety.
 
 Example:
 
     - (void)addObserver:(SomeClass*)observer;
     - (void)removeObserver:(SomeClass*)observer;
 */
@interface BBObservable : NSObject


/// ------------------------
/// @name Managing observers
/// ------------------------

/**
 Registers an instance of any class as an observer.
 
 This method keeps a weak reference to the observer. Keeping a weak reference means that the object must be strongly
 retained elsewhere. This is a design decision to ensure that instances that are not properly unregistered as observers
 are not kept in memory.
 
 Override this method in your subclasses and add a type to the `observer` param in order to ensure type safety.

 @param observer Observer to register.
 */
- (void)addObserver:(id)observer;

/**
 Unregisters an observer.
 
 Override this method in your subclasses and add a type to the `observer` param in order to ensure type safety.

 @param observer Observer to unregister.
 */
- (void)removeObserver:(id)observer;

/**
 The number of observers currently registered.
 
 This may not be accurate given that it returns the number of weak reference wrappers to observers, and some of them may
 no longer contain observers.

 @return Number of observers currently registered.
 */
- (NSUInteger)observerCount;


/// ------------------------------
/// @name Triggering notifications
/// ------------------------------

/**
 Perform `block` asynchronously on the main queue, passing each observer as input param.
 
 This method is a shortcut for `notifyObserversInAsynchronousQueue:withBlock:`, passing in `dispatch_get_main_queue()`
 as parameter for `queue`.

 @param block Code block that will be called for each live (i.e. non-nil weak reference) observer.
 */
- (void)notifyObserversAsynchronouslyInMainQueueWithBlock:(void (^)(id observer))block;

/**
 Perform `block` on current thread, passing each observer as input param.
 
 This version executes `block` on the current thread. Since observer iteration is serialized, this block should be 
 CPU bound and should be as short as possible. For long running blocks, use the
 `notifyObserversAsynchronouslyInMainQueueWithBlock:` or `notifyObserversInAsynchronousQueue:withBlock:` versio
 
 @param block Code block that will be called for each live (i.e. non-nil weak reference) observer.
 
 @see notifyObserversAsynchronouslyInMainQueueWithBlock:
 */
- (void)notifyObserversWithBlock:(void (^)(id observer))block;

/**
 This method wraps the `block` execution in an asynchronous GCD queue call.
 
 The queue passed as parameter **should** be created with `DISPATCH_QUEUE_CONCURRENT` option.

     dispatch_async(queue, ^{
         block(observer);
     });

 There is no need to protect the `block` against a `nil` observer as this method ensures that a temporary strong reference
 is created for the observer (remember the observers are kept as weak references).
 
 @param queue The queue in which the asynchronous notification will be performed.
 @param block Code block that will be called for each live (i.e. non-nil weak reference) observer.
 */
- (void)notifyObserversInAsynchronousQueue:(dispatch_queue_t)queue withBlock:(void (^)(id observer))block;

@end
