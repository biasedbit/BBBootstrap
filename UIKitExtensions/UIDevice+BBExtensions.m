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

#import "UIDevice+BBExtensions.h"

#include <sys/types.h>
#include <sys/sysctl.h>



#pragma mark - Constants

NSString* const kBBiPhone3GS = @"iPhone2,1";
NSString* const kBBiPhone4 = @"iPhone2,2";
NSString* const kBBiPhone4S = @"iPhone2,3";



#pragma mark -

@implementation UIDevice (BBExtensions)


#pragma mark Public methods

- (NSString*)platform
{
    /*
     Platforms
     iPhone1,1 -> iPhone 1G
     iPhone1,2 -> iPhone 3G
     iPod1,1 -> iPod touch 1G
     iPod2,1 -> iPod touch 2G
     */

    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString* platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);

    return platform;
}

- (BOOL)hasRetinaDisplay
{
    return [UIScreen mainScreen].scale == 2.0;
}

@end
