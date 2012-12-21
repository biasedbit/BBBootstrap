///
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
 Utility class to help profile code sections programmatically.
 */
@interface BBProfiler : NSObject


#pragma mark Profiling

///----------------
/// @name Profiling
///----------------

/**
 Profile a code section wrapped in `block` in nanoseconds.
 
 @param block Block of code to profile.

 @return Nanoseconds elapsed during the execution of `block`.
 */
+ (uint64_t)profileBlock:(void (^)())block;

/**
 Profile a code section wrapped in `block` and print the duration to the console in milliseconds.
 
 This is a utility method that combines `profileBlock:` and `nanosToMilliseconds:` and prints the output to the console
 using the `LogDebug()` macro.

 @param block Block of code to profile.
 @param description Description of of block section, to be printed out to console.
 */
+ (void)profileBlock:(void (^)())block withDescription:(NSString*)format, ... NS_FORMAT_FUNCTION(2,3);


#pragma mark Unit conversion

///----------------------
/// @name Unit conversion
///----------------------

+ (double)nanosToMilliseconds:(uint64_t)nanos;

@end
