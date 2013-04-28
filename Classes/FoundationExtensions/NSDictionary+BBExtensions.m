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

#import "NSDictionary+BBExtensions.h"



#pragma mark -

@implementation NSDictionary (BBExtensions)


#pragma mark Shortcuts

- (BOOL)boolForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return NO;

    return [number boolValue];
}

- (unsigned char)unsignedCharForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number unsignedCharValue];
}

- (unsigned short)unsignedShortForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number unsignedShortValue];
}

- (NSInteger)integerForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number integerValue];
}

- (NSUInteger)unsignedIntegerForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number unsignedIntegerValue];
}

- (long)longForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return NO;

    return [number longValue];
}

- (unsigned long)unsignedLongForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number unsignedLongValue];
}

- (long long)longLongForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number longLongValue];
}

- (unsigned long long)unsignedLongLongForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number unsignedLongLongValue];
}

- (float)floatForKey:(id)key
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number floatValue];
}

- (double)doubleForKey:(id)key;
{
    id number = [self objectForKey:key];
    if (number == nil) return 0;

    return [number doubleValue];
}

- (CGFloat)CGFloatForKey:(id)key
{
    return [self floatForKey:key];
}

- (CGRect)CGRectForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil) return CGRectZero;

    return [value CGRectValue];
}

@end
