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

#import "BBWeakWrapper.h"



#pragma mark -

@implementation BBWeakWrapper
{
    NSUInteger _hash;
}


#pragma mark Creation

- (id)init
{
    NSAssert(NO, @"Call -initWithObject:");
    return nil;
}

- (id)initWithObject:(id)object
{
    NSAssert(object != nil, @"Cannot create a weak reference to a nil object");
    self = [super init];
    if (self != nil) {
        _hash = [object hash];
    }

    return self;
}


#pragma mark Public static methods

+ (id)wrapperForObject:(id)object
{
    return [[BBWeakWrapper alloc] initWithObject:object];
}


#pragma mark Public methods

- (BOOL)isEqualToWrapper:(BBWeakWrapper*)wrapper
{
    return [wrapper hash] == [self hash];
}


#pragma mark NSObject

- (BOOL)isEqual:(id)object
{
    if (object == nil) {
        return NO;
    }

    if (object == self) {
        return YES;
    }

    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    return [self isEqualToWrapper:object];
}

@end
