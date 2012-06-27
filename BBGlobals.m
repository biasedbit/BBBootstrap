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

#ifndef kFallbackAppVersion
    #define kFallbackAppVersion @"1.0.0";
#endif



#pragma mark - Utility functions

NSString* AppVersion()
{
    static NSString* appVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        if (appVersion == nil) {
            appVersion = kFallbackAppVersion;
        }
    });

    return appVersion;
}

NSString* GetUUID()
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);

    return CFBridgingRelease(string);
}