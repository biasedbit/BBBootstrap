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

@interface NSObject (BBExtensions)


#pragma mark KVO

- (void)addObserver:(NSObject*)observer forKeyPaths:(NSArray*)keyPaths
            options:(NSKeyValueObservingOptions)options context:(void*)context;
- (void)removeObserver:(NSObject*)observer forKeyPaths:(NSArray*)keyPaths context:(void*)context;


#pragma mark Debug

///------------
/// @name Debug
///------------

/**
 Print out a human-friendly description for the instance.
 
 You should override this if your classes include more information that you'd like to use as an identifier for logging.
 Default implementation is simply `NSStringFromClass([self class])`.
 
 @return Identifier for the instance, to be used mostly in logging.
 */
- (NSString*)logId;

@end
