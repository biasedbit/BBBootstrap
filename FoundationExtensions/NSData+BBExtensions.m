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

#import "NSData+BBExtensions.h"



#pragma mark - Constants

static const char kNSData_BBExtensionsBase64EncodingTable[64] =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short kNSData_BBExtensionsBase64DecodingTable[256] = {
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
	-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
	-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};



#pragma mark -

@implementation NSData (BBExtensions)


#pragma mark Public static methods

/*
 Ported from PHP Core, originally written by Jim Winstead <jimw@php.net>, under version 3.01 of the PHP license
 */
+ (NSData*)decodeBase64String:(NSString*)string
{
    const char* objPointer = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (objPointer == NULL) {
        return nil;
    }

    size_t intLength = strlen(objPointer);
    NSInteger intCurrent;
    NSUInteger i = 0, j = 0, k;

    unsigned char* objResult;
    objResult = calloc(intLength, sizeof(unsigned char));

    // Run through the whole string, converting as we go
    while (((intCurrent = *objPointer++) != '\0') && (intLength-- > 0)) {
        if (intCurrent == '=') {
            if ((*objPointer != '=') && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }

        intCurrent = kNSData_BBExtensionsBase64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }

        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;

            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;

            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;

            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }

    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;

            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }

    // Cleanup and setup the return NSData
    NSData* data = [[NSData alloc] initWithBytesNoCopy:objResult length:j freeWhenDone:YES];
#if !__has_feature(objc_arc)
    [data autorelease];
#endif

    return data;
}


#pragma mark Public methods

/*
 Ported from PHP Core, originally written by Jim Winstead <jimw@php.net>, under version 3.01 of the PHP license
 */
- (NSString*)base64EncodedString
{
    const unsigned char* objRawData = [self bytes];
	char* objPointer;
	char* strResult;

	// Get the Raw Data length and ensure we actually have data
	size_t intLength = [self length];
	if (intLength == 0) {
        return nil;
    }

	// Setup the String-based Result placeholder and pointer within that placeholder
	strResult = (char*)calloc(((intLength + 2) / 3) * 4, sizeof(char));
	objPointer = strResult;

	// Iterate through everything
	while (intLength > 2) { // keep going until we have less than 24 bits
		*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[objRawData[0] >> 2];
		*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
		*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
		*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[objRawData[2] & 0x3f];

		// we just handled 3 octets (24 bits) of data
		objRawData += 3;
		intLength -= 3;
	}

	// now deal with the tail end of things
	if (intLength != 0) {
		*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[objRawData[0] >> 2];
		if (intLength > 1) {
			*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
			*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[(objRawData[1] & 0x0f) << 2];
			*objPointer++ = '=';
		} else {
			*objPointer++ = kNSData_BBExtensionsBase64EncodingTable[(objRawData[0] & 0x03) << 4];
			*objPointer++ = '=';
			*objPointer++ = '=';
		}
	}

	NSString* string = [[NSString alloc]
                        initWithBytesNoCopy:strResult length:(objPointer - strResult)
                        encoding:NSASCIIStringEncoding freeWhenDone:YES];
#if !__has_feature(objc_arc)
    [string autorelease];
#endif

	return string;
}

@end
