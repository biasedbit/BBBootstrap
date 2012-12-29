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

@interface NSUserDefaults (BBExtensions)


///-----------------------------------------------
/// @name Perform multiple changes and synchronize
///-----------------------------------------------

+ (BOOL)performChangesOnDefaultStoreAndSynchronize:(void (^)(NSUserDefaults* defaults))changes;

- (BOOL)performChangesAndSynchronize:(void (^)(NSUserDefaults* defaults))changes;


///-------------------------------
/// @name Shortcuts to read values
///-------------------------------

- (NSUInteger)unsignedIntegerForKey:(NSString*)key;


///--------------------------------
/// @name Shortcuts to store values
///--------------------------------

/**
 Store an `NSString` instance under a given key.
 
 @param string String to store.
 @param key Key under which the string will be stored.
 */
- (void)setString:(NSString*)string forKey:(NSString*)key;

/**
 Store an `NSData` instance under a given key.

 @param data Data to store.
 @param key Key under which the data will be stored.
 */
- (void)setData:(NSData*)data forKey:(NSString*)key;

/**
 Store an `NSArray` instance under a given key.

 @param array Array to store.
 @param key Key under which the array will be stored.
 */
- (void)setArray:(NSArray*)array forKey:(NSString*)key;

/**
 Store an `NSDictionary` instance under a given key.

 @param dictionary Dictionary to store.
 @param key Key under which the dictionary will be stored.
 */
- (void)setDictionary:(NSDictionary*)dictionary forKey:(NSString*)key;

/**
 Store an `long long` under a given key.

 @param value Value to store
 @param key Key under which the value will be stored.
 */
- (void)setLongLong:(long long)value forKey:(NSString*)key;

@end
