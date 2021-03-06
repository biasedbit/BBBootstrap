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

@interface NSUserDefaults (BBExtensions)


#pragma mark Perform multiple changes and synchronize

///-----------------------------------------------
/// @name Perform multiple changes and synchronize
///-----------------------------------------------

+ (BOOL)performChangesOnDefaultStoreAndSynchronize:(void (^)(NSUserDefaults* defaults))changes;

- (BOOL)performChangesAndSynchronize:(void (^)(NSUserDefaults* defaults))changes;


#pragma mark Shortcuts to read values

///-------------------------------
/// @name Shortcuts to read values
///-------------------------------

- (NSUInteger)unsignedIntegerForKey:(NSString*)key;


#pragma mark Shortcuts to store values

///--------------------------------
/// @name Shortcuts to store values
///--------------------------------

- (void)setUnsignedInteger:(NSUInteger)value forKey:(NSString*)key;

/**
 Store an `long long` under a given key.

 @param value Value to store
 @param key Key under which the value will be stored.
 */
- (void)setLongLong:(long long)value forKey:(NSString*)key;


#pragma mark Subscript operators

///--------------------------
/// @name Subscript operators
///--------------------------

- (id)objectForKeyedSubscript:(NSString*)key;
- (void)setObject:(id)object forKeyedSubscript:(NSString*)key;

@end
