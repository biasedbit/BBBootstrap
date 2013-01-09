//
//  NSMutableDictionary+BBExtensions.m
//  RemotelyTouch
//
//  Created by Bruno de Carvalho on 12/24/12.
//  Copyright (c) 2013 Graceful, LLC. All rights reserved.
//

#import "NSMutableDictionary+BBExtensions.h"



#pragma mark -

@implementation NSMutableDictionary (BBExtensions)


#pragma mark Shortcuts

- (void)setObjectIfNotNil:(id)object forKey:(id<NSCopying>)key
{
    if (object == nil) return;

    [self setObject:object forKey:key];
}

- (void)setUnsignedInteger:(NSUInteger)value forKey:(id<NSCopying>)key
{
    [self setObject:[NSNumber numberWithUnsignedInteger:value] forKey:key];
}

@end
