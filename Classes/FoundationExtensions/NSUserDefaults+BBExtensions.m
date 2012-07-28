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

#import "NSUserDefaults+BBExtensions.h"



#pragma mark -

@implementation NSUserDefaults (BBExtensions)


#pragma mark Shortcuts to store values

- (void)setString:(NSString*)string forKey:(NSString*)key
{
    [self setObject:string forKey:key];
}

- (void)setData:(NSData*)data forKey:(NSString*)key
{
    [self setObject:data forKey:key];
}

- (void)setArray:(NSArray*)array forKey:(NSString*)key
{
    [self setObject:array forKey:key];
}

- (void)setDictionary:(NSDictionary*)dictionary forKey:(NSString*)key
{
    [self setObject:dictionary forKey:key];
}

- (void)setLongLong:(long long)value forKey:(NSString*)key
{
    [self setObject:[NSNumber numberWithLongLong:value] forKey:key];
}

@end
