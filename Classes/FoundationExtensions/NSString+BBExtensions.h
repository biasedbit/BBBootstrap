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

@interface NSString (BBExtensions)


///-----------------------------
/// @name Base encoding/decoding
///-----------------------------

/**
 Encode a number into a string, using the base 62 alphabet (`0-9A-Za-z`).
 
 @param number Number to encode.
 
 @return String representing a base 62 encoding for the input.
 */
+ (NSString*)base62EncodingForNumber:(unsigned long long)number;

/**
 Create a base 64 encoded string from the current instance.
 
 @return Base 64 encoded string.
 */
- (NSString*)base64EncodedString;

/**
 Create a base 64 decoded string from the current instance.
 
 @return Base 64 decoded string.
 */
- (NSString*)base64DecodedString;


///--------------
/// @name Hashing
///--------------

/**
 Return a SHA1 hash of this instance.

 @return SHA1 string.
 */
- (NSString*)sha1;

/**
 Return a MD5 hash of this instance.

 @return MD5 string.
 */
- (NSString*)md5;

/**
 Return an HMAC-SHA1 hash for this instance and an input key.
 
 @param key Key to use when generating the hash.
 
 @return `NSData` instance containing the bytes of the HMAC-SHA1 hash for this instance with the input key.
 */
- (NSData*)hmacSha1WithKey:(NSString*)key;


///---------------------
/// @name File utilities
///---------------------

/**
 Infer file mime-type based on its extension.
 
 @return File mime-type.
 */
- (NSString*)filenameMimeType;

/**
 Test whether a string representing a file path ends with a given extension.
 
 @param extension Extension to test.

 @return `YES` if file ends with input `extension`, `NO` otherwise.
 */
- (BOOL)endsWithExtension:(NSString*)extension;

/**
 Test whether a string representing a file path ends with any of the extensions in the input set.
 
 @param extensions Set of extensions to test.

 @return `YES` if file ends with one of the extensions in the input set, `NO` otherwise.
 */
- (BOOL)endsWithExtensionInSet:(NSSet*)extensions;


///-----------------
/// @name Comparison
///-----------------

/**
 Compares two strings, returning true if both are `nil` or if the result of sending `isEqualToString:` to `string` with
 `otherString` as argument returns `YES`.
 
 @param string the reference string
 @param otherString the string to compare
 
 @return `YES` if both strings are `nil` or identical, `NO` otherwise.
 */
+ (BOOL)string:(NSString*)string isEqualToString:(NSString*)otherString;


///-----------
/// @name Misc
///-----------

/**
 Produces a random 8 character string, using the base 62 alphabet (`0-9A-Za-z`).
 
 @return Random string.
 */
+ (NSString*)randomString;

/**
 URL encode a string.

 @param encoding The encoding to use.

 @return URL encoded string
 */
- (NSString*)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end
