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

#import "BBCancellable.h"



#pragma mark -

@implementation BBCancellable
{
    BOOL _cancelled;

    NSString* _name;
}


#pragma mark Creation

- (instancetype)init
{
    return [self initWithName:@"anonymous"];
}

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self != nil) _name = name;

    return self;
}

+ (instancetype)cancellableWithBlock:(void (^)())block
{
    BBCancellable* cancellable = [[BBCancellable alloc] init];
    cancellable.cancelBlock = block;

    return cancellable;
}

+ (instancetype)cancellableNamed:(NSString*)name withBlock:(void (^)())block
{
    BBCancellable* cancellable = [[BBCancellable alloc] initWithName:name];
    cancellable.cancelBlock = block;

    return cancellable;
}


#pragma mark Interface

- (BOOL)cancel
{
    if (_cancelled) return NO;
    _cancelled = YES;

    if (_cancelBlock != nil) _cancelBlock();

    return YES;
}

- (BOOL)wasCancelled
{
    return _cancelled;
}


#pragma mark Description

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@{name='%@', cancelled=%@}",
            NSStringFromClass([self class]), _name, _cancelled ? @"YES" : @"NO"];
}

@end

