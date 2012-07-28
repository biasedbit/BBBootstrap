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

#import "NSData+BBExtensions.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#if TARGET_OS_IPHONE
    #import <MobileCoreServices/UTType.h>
#endif



#pragma mark - Constants

const char kNSString_BBExtensionsBase62Alphabet[62] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";



#pragma mark -

@implementation NSString (BBExtensions)


#pragma mark Base encoding/decoding

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

- (NSString*)base64EncodedString
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];

    return [data base64EncodedString];
}

- (NSString*)base64DecodedString
{
    NSData* data = [NSData decodeBase64String:self];
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#if !__has_feature(objc_arc)
    [string autorelease];
#endif

    return string;
}

#pragma mark Hashing

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
    const char* str = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_LONG len = (CC_LONG)strlen(str);
    CC_MD5(str, len, digest);
    NSMutableString* hash = [NSMutableString string];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", digest[i]];
    }

    return [hash lowercaseString];
}

- (NSData*)hmacSha1WithKey:(NSString*)key
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];

    CCHmacContext context;
    CCHmacAlgorithm algorithm = kCCHmacAlgSHA1;
    NSUInteger digestLength = CC_SHA1_DIGEST_LENGTH;

    const char* keyCString = [key cStringUsingEncoding:NSASCIIStringEncoding];

    CCHmacInit(&context, algorithm, keyCString, strlen(keyCString));
    CCHmacUpdate(&context, [data bytes], [data length]);

    unsigned char digestRaw[CC_SHA1_DIGEST_LENGTH];

    CCHmacFinal(&context, digestRaw);

    NSData* digestData = [NSData dataWithBytes:digestRaw length:digestLength];

    return digestData;
}


#pragma mark File utilities

- (NSString*)filenameMimeType
{
    NSString* ext = [self pathExtension];
    if (ext == nil) {
        return @"application/octet-stream";
    }

    NSString* mimeType = nil;
#if __has_feature(objc_arc)
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                            (__bridge CFStringRef)ext, NULL);
#else
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                            (CFStringRef)ext, NULL);
#endif
    if (!UTI) {
        return nil;
    }

    CFStringRef registeredType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    if (!registeredType) {
        // check for edge case
        mimeType = @"application/octet-stream";
    } else {
#if __has_feature(objc_arc)
        mimeType = (__bridge_transfer NSString*)registeredType;
#else
        mimeType = NSMakeCollectable(registeredType);
#endif
    }
    CFRelease(UTI);

    return mimeType;
}

- (BOOL)endsWithExtension:(NSString*)extension
{
    return [self endsWithExtensionInSet:[NSSet setWithObject:extension]];
}

- (BOOL)endsWithExtensionInSet:(NSSet*)extensions
{
    NSString* ext = [self pathExtension];
    if ((ext == nil) || ([ext length] == 0)) {
        return NO;
    }

    for (NSString* extension in extensions) {
        if ([ext isEqualToString:extension]) {
            return YES;
        }
    }
    
    return NO;
}


#pragma mark Misc

+ (NSString*)randomString
{
    u_int32_t rand = arc4random();
    uint64_t now = [NSDate currentTimeMillis];

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

- (NSString*)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (__bridge_transfer NSString*)
           CFURLCreateStringByAddingPercentEscapes(NULL,
                                                   (__bridge CFStringRef)self,
                                                   NULL,
                                                   (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                   CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end
