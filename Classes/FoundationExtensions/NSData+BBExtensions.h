//
// Copyright 2013 BiasedBit
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
//  Copyright (c) 2013 BiasedBit. All rights reserved.
//

#pragma mark -

@interface NSData (BBExtensions)

///-------------------------------
/// @name Base64 encoding/decoding
///-------------------------------

/**
 Decode a base 64 `NSString` instance into a `NSData` instance.
 
 @param string Base 64 encoded string.

 @return Decoded byte array for the input base 64 string.
 */
+ (NSData*)decodeBase64String:(NSString*)string;

/**
 Encode this instance into a base 64 string.
 
 @return Base 64 encoded string.
 */
- (NSString*)base64EncodedString;


///--------------
/// @name Hashing
///--------------

/**
 Return a SHA1 hash of the bytes wrapped by this instance.
 
 @return SHA1 string.
 */
- (NSString*)sha1;

/**
 Return a MD5 hash of the bytes wrapped by this instance.

 @return MD5 string.
 */
- (NSString*)md5;

@end
