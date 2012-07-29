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
 Instance that holds a weak reference for another instance.
 
 You can use these to store weak references on arrays, dictionaries, sets, etc.
 */
@interface BBWeakWrapper : NSObject


#pragma mark Creation

///---------------
/// @name Creation
///---------------

/**
 Create a new instance keeping a weak reference for the input `object`.
 
 @param object Instance to wrap.

 @return A newly initialized `BBWeakWrapper`.
 */
- (id)initWithObject:(id)object;

/**
 Create a new instance keeping a weak reference for the input `object`.
 
 @param object Instance to wrap.

 @return A newly initialized `BBWeakWrapper`.
 */
+ (id)wrapperForObject:(id)object;


#pragma mark Querying

///---------------
/// @name Querying
///---------------

/**
 Object wrapped by this instance.
 
 This is a weak reference, which means that at any time it may become `nil`.
 */
@property(weak, nonatomic) id object;

/**
 Query the wrapper to figure whether the weak reference is still valid (not `nil`).
 
 @return `YES` if the weak reference no longer points to a an object (i.e. `object` is `nil`), `NO` otherwise.
 */
- (BOOL)isEmpty;


#pragma mark Comparing with other wrappers

///------------------------------------
/// @name Comparing with other wrappers
///------------------------------------

/**
 Compare this instance against another `BBWeakWrapper`.
 
 Comparison is based on the hash of the wrapped object (which is stored when the wrapper is initially created).
 
 @param wrapper `BBWeakWrapper` instance against which this one will be compared.
 
 @return `YES` if wrappers are equal (i.e. wrapped object hashes are the same), `NO` otherwise.
 */
- (BOOL)isEqualToWrapper:(BBWeakWrapper*)wrapper;

@end
