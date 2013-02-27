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

@interface NSUbiquitousKeyValueStore (BBExtensions)


///---------------------------------------------------
/// @name Writing with fallback to local user defaults
///---------------------------------------------------

/**
 Performs changes in `change` block and makes a call to `synchronize` after the block completes, using the default
 `NSUbiquitousKeyValueStore`.

 @param change Block of changes to perform. This block receives `dataSource` as input parameter, which will be either
 `[NSUbiquitousKeyValueStore defaultStore]` or `[NSUserDefaults standardUserDefaults]`.

 @return `YES` if change was successfully synchronized either to iCloud or local settings, `NO` otherwise.
 
 @see performChangeAndSynchronizeWithFallback:
 */
+ (BOOL)performChangeOnDefaultStoreAndSynchronizeWithFallback:(void (^)(id dataSource))change;

/**
 Performs changes in `change` block and makes a call to `synchronize` after the block completes.

 If iCloud is not available (i.e. not possible to write values to the `NSUbiquitousKeyValueStore`),

 Example:

 [NSUbiquitousKeyValueStore performChangeOnDefaultStoreAndSynchronizeWithFallback:^(id dataSource) {
 [dataSource setObject:objectOne forKey:keyOne];
 [dataSource setObject:objectTwo forKey:keyTwo];
 }];

 @param change Block of changes to perform. This block receives `dataSource` as input parameter, which will be either
 this instance or `[NSUserDefaults standardUserDefaults]`.

 @return `YES` if change was successfully synchronized either to iCloud or local settings, `NO` otherwise.
 */
- (BOOL)performChangeAndSynchronizeWithFallback:(void (^)(id dataSource))change;


///---------------------------------------------
/// @name Reading with fallback to user defaults
///---------------------------------------------

/**
 Retrieve a dictionary from iCloud (if available) or from user defaults.
 
 @param key Key for the object to read.
 
 @return `NSDictionary` for input `key`.
 */
- (NSDictionary*)dictionaryForKeyWithFallback:(NSString*)key;

/**
 Retrieve an array from iCloud (if available) or from user defaults.

 @param key Key for the object to read.

 @return `NSDictionary` for input `key`.
 */
- (NSArray*)arrayForKeyWithFallback:(NSString*)key;

/**
 Retrieve a string from iCloud (if available) or from user defaults.

 @param key Key for the object to read.

 @return `NSString` for input `key`.
 */
- (NSString*)stringForKeyWithFallback:(NSString*)key;

/**
 Retrieve an object from iCloud (if available) or from user defaults.

 @param key Key for the object to read.

 @return object for input `key`.
 */
- (id)objectForKeyWithFallback:(NSString*)key;

@end
