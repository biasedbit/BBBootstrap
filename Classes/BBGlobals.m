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

#include "BBGlobals.h"



#pragma mark - Constants

// You can define your own kBBFallbackAppVersion on the Prefix header, before importing BBGlobals.h
#ifndef kBBFallbackAppVersion
    #define kBBFallbackAppVersion @"1.0.0"
#endif



#pragma mark - Utility functions

NSString* BBAppVersion()
{
    static NSString* appVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        if (appVersion == nil) appVersion = kBBFallbackAppVersion;
    });

    return appVersion;
}

NSString* BBGetUUID()
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);

    return CFBridgingRelease(string);
}

NSString* BBPrettySize(double sizeInBytes)
{
    if (sizeInBytes < 0) return @"n/a";

    NSString* unit;
    double sizeInUnits;
    if (sizeInBytes < 1024.0) {
        unit = @"B";
        sizeInUnits = sizeInBytes;
    } else if ((sizeInBytes >= 1024.0) && (sizeInBytes < 1048576.0)) {
        unit = @"KB";
        sizeInUnits = sizeInBytes / 1024.0;
    } else if ((sizeInBytes >= 1048576.0) && (sizeInBytes < 1073741824.0)) {
        unit = @"MB";
        sizeInUnits = sizeInBytes / 1048576.0;
    } else {
        unit = @"GB";
        sizeInUnits = sizeInBytes / 1073741824.0;
    }

    return [NSString stringWithFormat:@"%.1f%@", sizeInUnits, unit];
}

NSString* BBPrettyTransferRate(double transferRateInBytesPerSecond)
{
    if (transferRateInBytesPerSecond < 0) return @"n/a";

    NSString* unit;
    double sizeInUnits;
    if (transferRateInBytesPerSecond < 1024.0) {
        unit = @"B";
        sizeInUnits = transferRateInBytesPerSecond;
    } else if ((transferRateInBytesPerSecond >= 1024.0) && (transferRateInBytesPerSecond < 1048576.0)) {
        unit = @"KB";
        sizeInUnits = transferRateInBytesPerSecond / 1024.0;
    } else if ((transferRateInBytesPerSecond >= 1048576.0) && (transferRateInBytesPerSecond < 1073741824.0)) {
        unit = @"MB";
        sizeInUnits = transferRateInBytesPerSecond / 1048576.0;
    } else {
        unit = @"GB"; // jesus, that's fast!
        sizeInUnits = transferRateInBytesPerSecond / 1073741824.0;
    }

    return [NSString stringWithFormat:@"%.1f%@/s", sizeInUnits, unit];
}

void dispatch_after_seconds(int64_t seconds, dispatch_block_t block) {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

void dispatch_after_millis(int64_t milliseconds, dispatch_block_t block) {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(milliseconds * NSEC_PER_MSEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

