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

#pragma mark -

/**
 Superclass for something that can be cancelled.
 
 Especially useful for long running asynchronous operations that have post-completion routines which need to be
 aborted at any time.
 

 ## Subclassing notes

 Subclasses should override method `cancel` and implement their own behavior:
 
     - (BOOL)cancel
     {
         if (![super cancel]) {
             return NO;
         }
         // Subclass cancelling logic here
         return YES;
     }
 */
@interface BBCancellable : NSObject


#pragma mark State information

///------------------------
/// @name State information
///------------------------

/**
 Name of the cancellable.
 
 The name of the cancellable is useful for logging purposes. It's a read-only property that can be set by creating
 instances with initWithName:.
 
 If a BBCancellable instance is created using init instead, its name will be "anonymous".
 */
@property(strong, nonatomic, readonly) NSString* name;

/**
 Check whether an instance has been cancelled.

 @return `YES` if instance is in cancelled state, `NO` otherwise.
 */
- (BOOL)isCancelled;


#pragma mark Creation

///---------------
/// @name Creation
///---------------

/**
 Creates a new instance and assigns a name to it.
 
 @param name Name of the cancellable, for identification purposes.
 */
- (id)initWithName:(NSString*)name;


#pragma mark State management

///-----------------------
/// @name State management
///-----------------------

/**
 Switches an instance to cancelled state.

 Subclasses that require additional steps to be performed when the instance is cancelled must override this method,
 provided that they maintain the interface contract:

 - it must return `YES` if cancellation was successful;
 - it must return `NO` if the instance was previously cancelled;
 - it must return `NO` if cancellation was not possible;
 - the return value of the method isCancelled must be consistent with return value from this method, i.e. after a
   call to `cancel` returns `YES`, isCancelled must also return `YES`.

 @return `YES` if cancellation succeeded, `NO` if cancellation wasn't possible or instance was already cancelled.
 */
- (BOOL)cancel;

@end
