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

#pragma mark - Constants

/** iPhone3GS device identifier */
extern NSString* const kBBiPhone3GS;
/** iPhone4 device identifier */
extern NSString* const kBBiPhone4;
/** iPhone4S device identifier */
extern NSString* const kBBiPhone4S;



#pragma mark -

@interface UIDevice (BBExtensions)

///--------------------------
/// @name Device capabilities
///--------------------------

/**
 Query the device for its platform identifier.
 
 Platform identifiers should be compared against these constants:
 - `kBBiPhone3GS`
 - `kBBiPhone4`
 - `kBBiPhone4S`

 @return String identifying this platform.
 */
- (NSString*)platform;

/**
 Test if the device has a retina display.

 @return `YES` if the current device has a retina display, `NO` otherwise.
 */
- (BOOL)hasRetinaDisplay;

@end