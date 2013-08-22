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

#pragma mark - Custom types

/**
 Countdown latch execution block, alias for `(void (^)())`.
 */
typedef void (^BBCountDownLatchBlock)();



#pragma mark -

/**
 A synchronization aid that allows one or more threads to wait until a set of operations being performed in other
 threads completes.
 
 This class was largely inspired by
 [Java's CountDownLatch](http://docs.oracle.com/javase/7/docs/api/java/util/concurrent/CountDownLatch.html),
 built using GCD and a block-friendly API.
 
 It is an extremely useful class when you have multiple things happening at the same time and you need to make sure a
 piece of code doesn't run until all of them are finished. It can either be waiting for multiple worker threads to
 finish off some parallel computation or multiple UI animations that have arbitrary durations and need to properly
 finish before starting some other animation (synchronized chaining).
 
 ## Using a count down latch
 
     BBCountDownLatch* latch = [BBCountDownLatch autoCleanupLatchWithName:@"test" counter:2 andCompletionBlock:^{
         NSLog(@"Released!");
     }];
 
     // On worker thread #1
     [latch countDownWithCalledId:@"worker #1"];
 
     // On worker thread #2
     [latch countDownWithCalledId:@"worker #2"];
 
 The above code will always result in a log statement being printed out to the console after both workers perform the
 countdown, no matter the order in which they call it or how long each of them takes.

 */
@interface BBCountDownLatch : NSObject


#pragma mark State information

///------------------------
/// @name State information
///------------------------

/**
 Name of the latch.
 
 For debugging purposes (and we all know how hard multithreaded debugging is…) no two latch that coexist at the same
 time should share the same name. This doesn't need to be absolutely unique but a good policy is to name this latch
 after the UIViewController where it is used.
 */
@property(strong, nonatomic, readonly) NSString* name;

/** GCD queue used by the instance */
@property(strong, nonatomic, readonly) dispatch_queue_t queue;

/** Number of count downs required to trigger the completion block */
@property(assign, nonatomic, readonly) NSUInteger counter;

/**
 Cancel flag for this instance.
 
 If a latch has been cancelled by calling cancel, this will return `YES`.
 */
@property(assign, nonatomic, readonly) BOOL cancelled;


#pragma mark Creating latches

///-----------------------
/// @name Creating latches
///-----------------------

/**
 Creates a new latch.
 
 @warning By using this method you are responsible for providing a GCD queue and releasing that queue **only after**
 this latch has been properly terminated (cancelled or released by count down).
 
 @param name Name of the latch. Make sure this is a somewhat unique string.
 @param queue The CGD queue to use. This queue **MUST** have been created with `DISPATCH_QUEUE_SERIAL` option.
 @param counter Number of count downs required to trigger the completion block.
 @param block The completion block, to execute when counter count downs have been performed.
 
 @return A newly initialized `BBCountDownLatch`
 */
- (instancetype)initWithName:(NSString*)name queue:(dispatch_queue_t)queue counter:(NSUInteger)counter
          andCompletionBlock:(BBCountDownLatchBlock)block;

/**
 Creates a new latch that will create an internal GCD queue and manage its lifecycle.
 
 When the instance created with this method is deallocated, the underlying GCD queue will be released.
 
 @param name Name of the latch. Make sure this is a somewhat unique string.
 @param counter Number of count downs required to trigger the completion block.
 @param block The completion block, to execute when counter count downs have been performed.
 
 @see initWithName:queue:counter:andCompletionBlock:
 */
+ (BBCountDownLatch*)latchWithName:(NSString*)name counter:(NSUInteger)counter
                           completion:(BBCountDownLatchBlock)block;


#pragma mark Managing state

///---------------------
/// @name Managing state
///---------------------

/**
 Cancel a latch and prevent the execution of the completion block.
 
 Calling this method prior to the completion block trigger will cause the completion block to never be called.

 @return `YES` if latch switched to cancelled state, `NO` otherwise (already cancelled).
 */
- (BOOL)cancel;

/**
 Perform an anonymous count down.

 Produces the same side effects as calling countDownWithCallerId: passing "anonymous" as caller id.
 
 @see countDownWithCallerId:
 */
- (BOOL)countDown;

/**
 Perform a named count down.
 
 When counter count downs are performed, the completion block passed to the instance during creation is executed **on
 the main queue**.
 
 This execution is thread safe and serialized, i.e. a single thread will be able to perform the logic in this method at
 once. This guarantees that exactly counter count downs are required to trigger the completion block.
 
 If logging macros are set and enabled, passing a `callerId` when performing a count down will log the id of the caller.
 This is especially useful for debugging, to figure out which workers have (or have not) performed the count down.
 
 @param callerId Identifier for the worker that triggered a count down.

 @return `YES` if count down was successful, `NO` if completion block was already triggered or latch was cancelled.
 */
- (BOOL)countDownWithCallerId:(NSString*)callerId;

/**
 Change the number of calls required to release the latch and call the completion block.
 
 Useful if the number of block executions is not known at the time of creation of the latch, such as when you need to 
 pass the latch to an arbitrary number of workers.

 @warning Caution, here be dragons.
 
 Resetting a latch after operations with it have already begun will likely lead to
 inconsistent behavior, causing the block to be released earlier than expected or not released at all! Make sure you
 **know exactly what you're doing** when calling this method.
 
 @param newCounterValue Number of count downs required to trigger the completion block, will override value of counter.
 */
- (void)resetRequestCounter:(NSUInteger)newCounterValue;

@end
