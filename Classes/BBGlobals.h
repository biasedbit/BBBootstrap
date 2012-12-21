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

#pragma mark - Utility functions

/**
 Grabs the app's current version from the main bundle.
 
 In the highly unlikely event that it fails, fallback reads value from a constant named `kBBFallbackAppVersion`.
 If you wish to override the value in this constant (`1.0.0`), make sure you define it on your project's prefix file.
 
 @return Application version as defined in the main bundle.
 */
extern NSString* BBAppVersion(void);

/**
 Creates a unique string.

 @return Unique string
 */
extern NSString* BBGetUUID(void);

/**
 Converts an input value in bytes into a human readable string.

 @param sizeInBytes value in bytes to convert to human readable string.

 @return Human readable string, like 32.1MB
 */
extern NSString* BBPrettySize(double sizeInBytes);

/**
 Converts an input value in bytes per second into a human readable string.

 @param sizeInBytes value in bytes to convert to human readable string.

 @return Human readable string, like 32.1MB/s
 */
extern NSString* BBPrettyTransferRate(double transferRateInBytesPerSecond);


extern void dispatch_async_on_main(dispatch_block_t block);
extern void dispatch_after_seconds(NSTimeInterval seconds, dispatch_block_t block);
extern void dispatch_after_millis(int64_t milliseconds, dispatch_block_t block);
