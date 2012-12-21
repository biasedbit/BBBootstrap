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

#import "BBProfiler.h"

#import <mach/mach_time.h>



#pragma mark -

@implementation BBProfiler


#pragma mark Profiling

+ (uint64_t)profileBlock:(void (^)())block
{
    uint64_t startTime = 0;
    uint64_t endTime = 0;
    uint64_t elapsedTime = 0;
    uint64_t elapsedTimeNano = 0;

    mach_timebase_info_data_t timeBaseInfo;
    mach_timebase_info(&timeBaseInfo);

    startTime = mach_absolute_time();

    block();

    endTime = mach_absolute_time();
    elapsedTime = endTime - startTime;
    elapsedTimeNano = elapsedTime * timeBaseInfo.numer / timeBaseInfo.denom;

    return elapsedTimeNano;
}

+ (void)profileBlock:(void (^)())block withDescription:(NSString*)format, ...
{
    uint64_t nanos = [self profileBlock:block];

    va_list args;
	va_start(args, format);
    NSString* description = [[NSString alloc] initWithFormat:format arguments:args];
	va_end(args);

    LogDebug(@"[PROFILER] Took %.2fms to execute section '%@'", [self nanosToMilliseconds:nanos], description);

#if !__has_feature(objc_arc)
    [description release];
#endif
}


#pragma mark Unit conversion

+ (double)nanosToMilliseconds:(uint64_t)nanos
{
    return nanos / 1000000.0;
}

@end
