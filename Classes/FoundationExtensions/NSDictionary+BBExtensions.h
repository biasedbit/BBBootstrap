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

@interface NSDictionary (BBExtensions)


///----------------
/// @name Shortcuts
///----------------

/**
 Returns `key`'s value as a `BOOL`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `BOOL` value for `key`
 */
- (BOOL)boolForKey:(id)key;

- (unsigned char)unsignedCharForKey:(id)key;

- (unsigned short)unsignedShortForKey:(id)key;

/**
 Returns `key`'s value as a `NSInteger`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `NSInteger` value for `key`
 */
- (NSInteger)integerForKey:(id)key;

/**
 Returns `key`'s value as a `NSUInteger`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `NSUInteger` value for `key`
 */
- (NSUInteger)unsignedIntegerForKey:(id)key;

/**
 Returns `key`'s value as a `long`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `long` value for `key`
 */
- (long)longForKey:(id)key;

/**
 Returns `key`'s value as a `unsigned long`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `unsigned long` value for `key`
 */
- (unsigned long)unsignedLongForKey:(id)key;

/**
 Returns `key`'s value as a `long long`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `long long` value for `key`
 */
- (long long)longLongForKey:(id)key;

/**
 Returns `key`'s value as a `unsigned long long`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `unsigned long long` value for `key`
 */
- (unsigned long long)unsignedLongLongForKey:(id)key;

/**
 Returns `key`'s value as a `float`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `float` value for `key`
 */
- (float)floatForKey:(id)key;

/**
 Returns `key`'s value as a `double`, if it exists.
 
 @param key Key of the property to retrieve.

 @return `double` value for `key`
 */
- (double)doubleForKey:(id)key;

@end
