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

#import "NSUbiquitousKeyValueStore+BBExtensions.h"

#import "NSUserDefaults+BBExtensions.h"



#pragma mark -

@implementation NSUbiquitousKeyValueStore (BBExtensions)


#pragma mark Writing with fallback to local user defaults

+ (BOOL)performChangeOnDefaultStoreAndSynchronizeWithFallback:(void (^)(id dataSource))change
{
    return [[NSUbiquitousKeyValueStore defaultStore] performChangeAndSynchronizeWithFallback:change];
}

- (BOOL)performChangeAndSynchronizeWithFallback:(void (^)(id dataSource))change
{
    // First, perform the change on iCloud
    change(self);

    // Now, synchronize....
    if ([self synchronize]) return YES;

    // If iCloud sync fails, we fallback to user defaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    change(defaults);

    return [defaults synchronize];
}


#pragma mark Reading with fallback to user defaults

- (NSDictionary*)dictionaryForKeyWithFallback:(NSString*)key
{
    NSDictionary* dictionary = [self dictionaryForKey:key];
    if (dictionary == nil) {
        dictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
    }

    return dictionary;
}

- (NSArray*)arrayForKeyWithFallback:(NSString*)key
{
    NSArray* array = [self arrayForKey:key];
    if (array == nil) {
        array = [[NSUserDefaults standardUserDefaults] arrayForKey:key];
    }

    return array;
}

- (NSString*)stringForKeyWithFallback:(NSString*)key
{
    NSString* string = [self stringForKey:key];
    if (string == nil) {
        string = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    }

    return string;
}

- (id)objectForKeyWithFallback:(NSString*)key
{
    id object = [self objectForKey:key];
    if (object == nil) {
        object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }

    return object;
}

@end
