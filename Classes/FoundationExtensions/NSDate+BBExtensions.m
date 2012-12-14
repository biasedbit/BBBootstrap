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

#import "NSDate+BBExtensions.h"

#import <sys/time.h>



#pragma mark -

@implementation NSDate (BBExtensions)


#pragma mark Public static methods

+ (int64_t)currentTimeMillis
{
    struct timeval t;
    gettimeofday(&t, NULL);

    return (((int64_t) t.tv_sec) * 1000) + (((int64_t) t.tv_usec) / 1000);
}

+ (NSString*)currentTimeMillisAsString
{
    return [NSString stringWithFormat:@"%lld", [self currentTimeMillis]];
}

+ (NSDate*)dateFromMillis:(int64_t)millis
{
    return [NSDate dateWithTimeIntervalSince1970:(millis / 1000)];
}


#pragma mark Interface

- (NSString*)prettyDate
{
    static NSDateFormatter* formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }

    NSString* date = [formatter stringFromDate:self];

    return date;
}

@end
