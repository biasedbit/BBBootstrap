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

#pragma mark - Constants

extern NSUInteger const kBBQueueMaxQueueSize;



#pragma mark - Protocols

@protocol BBQueueOperation <NSObject>

@required
/**
 Used to look for identical queue operations in the queue (to avoid duplicate operation submissions)
 */
- (NSString*)operationId;
- (void)beginQueueOperation;
- (BOOL)isQueueOperationCancelled;
- (BOOL)cancelQueueOperation;

@end



@class BBQueue;

@protocol BBQueueDelegate <NSObject>

@required
- (id<BBQueueOperation>)createOperationWithId:(NSString*)identifier andParams:(NSDictionary*)params
                                     forQueue:(BBQueue*)queue;

@optional
- (void)queue:(BBQueue*)queue finishedOperation:(id<BBQueueOperation>)operation;

@end



#pragma mark -

/**
 Component similar to a dispatch queue with support for detection of duplicate tasks and configuration of how many
 tasks can run in parallel. If only one task is allowed to run at a time, it is just about the same as a serial dispatch
 queue except it detects duplicate task submissions.
 
 The main (and only) advantage this component offers over a `NSOperationQueue` is duplicate task submission detection.
 
 
 ## Detecting duplicates
 
 Suppose you're going through a list of records that contain references to url that represents their image. You want to
 download those images to populate a `UITableView`. If some of those images are duplicates, you'll end up downloading
 unnecessary images.
 
 If your consider the image url a unique identifier for a download operation, submitting operations via
 `enqueueOperationWithId:andParams:` passing the url as `id`, you'll have the guarantee that no duplicate requests for
 the same url will be performed.

 
 ## Usage notes
 
 A `BBQueue` on its own contains only the main logic behind management of the queue. You must provide a delegate and
 that delegate must return a non-nil value when its `createOperationWithId:andParams:forQueue:` method is called.
 
 Returning `nil` will result in nothing actually being done &mdash; which may eventually be a desirable action, e.g. if
 you detected that you've already have the image cached locally.
 
 When an operation finishes, you **must** call `operationFinished:` and pass the operation. If you fail to do this, the
 queue will never be aware that the operation has finished and, consequently, won't execute other queued operations.

 This class is **not** intended to be subclassed.
 */
@interface BBQueue : NSObject


#pragma mark Properties

@property(weak, nonatomic) id<BBQueueDelegate> delegate;


#pragma mark Creation

- (instancetype)initWithName:(NSString*)name andSlots:(NSUInteger)slots;
- (instancetype)initWithName:(NSString*)name slots:(NSUInteger)slots andMaxQueueSize:(NSUInteger)maxQueueSize;


#pragma mark Interface

- (id<BBQueueOperation>)enqueueOperationWithId:(NSString*)identifier andParams:(NSDictionary*)params;
- (id<BBQueueOperation>)enqueueOperationWithId:(NSString*)identifier andParams:(NSDictionary*)params
                                    prioritize:(BOOL)prioritize;
- (void)operationFinished:(id<BBQueueOperation>)operation;

@end
