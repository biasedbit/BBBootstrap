//
//  NSMutableDictionary+BBExtensions.m
//  RemotelyTouch
//
//  Created by Bruno de Carvalho on 12/24/12.
//  Copyright (c) 2012 Graceful, LLC. All rights reserved.
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

@end
