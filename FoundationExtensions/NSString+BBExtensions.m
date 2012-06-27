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

#import "NSString+BBExtensions.h"

#import "NSDate+RKExtensions.h"

#import <CommonCrypto/CommonDigest.h>



#pragma mark - Constants

const char kNSString_BBExtensionsBase62Alphabet[62] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";



#pragma mark -

@implementation NSString (RTExtensions)


#pragma mark Public static methods

+ (NSString*)randomString
{
    u_int32_t rand = arc4random();
    u_int64_t now = [NSDate currentTimeMillis];

    NSString* hashSource = [NSString stringWithFormat:@"%u:%lld", rand, now];
    NSString* hashed = [hashSource sha1];

    // If we use up all the 40 characters of the sha1 hash, we generate such a large number that strtoll will end up
    // returning the highest long long number possible and thus always generating the same password. Since 12 chars of
    // the sha1 hash are enough to produce such a large number that a base62 conversion of that number always returns
    // over 8 characters, we trim down the hash length to 12 before converting it into a number (base 16 conversion).
    hashed = [hashed substringToIndex:12];

    long long number = strtoll([hashed UTF8String], NULL, 16);
    NSString* randomString = [self base62EncodingForNumber:number];

    if ([randomString length] > 8) {
        return [randomString substringToIndex:8];
    }

    return randomString;
}

+ (NSString*)base62EncodingForNumber:(long long)number
{
    if (number == 0) {
        return @"0";
    }

    NSMutableString* result = [[NSMutableString alloc] init];
    while (number > 0) {
        NSUInteger remainder = number % 62;
        char charForRemainder = kNSString_BBExtensionsBase62Alphabet[remainder];
        NSString* toInsert = [NSString stringWithFormat:@"%c", charForRemainder];
        [result insertString:toInsert atIndex:0];
        number = (number - remainder) / 62;
    }

    return result;
}


#pragma mark Public methods

- (NSString*)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (__bridge_transfer NSString*)
           CFURLCreateStringByAddingPercentEscapes(NULL,
                                                   (__bridge CFStringRef)self,
                                                   NULL,
                                                   (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                   CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString*)sha1
{
    const char* str = [self UTF8String];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_LONG len = (CC_LONG)strlen(str);
    CC_SHA1(str, len, digest);
    NSMutableString* hash = [NSMutableString string];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", digest[i]];
    }

    return [hash lowercaseString];
}

- (NSString*)md5
{
    const char* cStr = [self UTF8String];
    unsigned char result[16];
    CC_LONG len = (CC_LONG)strlen(cStr);
    CC_MD5(cStr, len, result );
    NSMutableString* hash = [NSMutableString string];

    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }

    return [hash lowercaseString];
}

- (NSString*)base64Encoding
{
    return nil;
}

@end
