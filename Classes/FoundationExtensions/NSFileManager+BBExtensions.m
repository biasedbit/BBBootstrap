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

#import "NSFileManager+BBExtensions.h"



#pragma mark -

@implementation NSFileManager (BBExtensions)


#pragma mark Deletion shortcuts

- (NSInteger)deleteAllFilesInFolder:(NSString*)pathToFolder
{
    NSArray* files = [self contentsOfDirectoryAtPath:pathToFolder error:nil];

    if (files == nil) return -1;

    NSInteger failed = 0;

    for(NSString* file in files) {
        NSString* fullPathToFile = [pathToFolder stringByAppendingPathComponent:file];
        if (![self removeItemAtPath:fullPathToFile error:nil]) failed++;
    }

    return failed;
}


#pragma mark Disk space queries

- (unsigned long long)freeDiskSpace:(NSError**)error
{
    NSNumber* freeFileSystemSizeInBytes = [self fileSystemPropertyWithName:NSFileSystemFreeSize error:error];
    if ((*error != nil) || (freeFileSystemSizeInBytes == nil)) return 0;

    return [freeFileSystemSizeInBytes unsignedLongLongValue];
}

- (unsigned long long)totalDiskSpace:(NSError**)error
{
    NSNumber* fileSystemSizeInBytes = [self fileSystemPropertyWithName:NSFileSystemSize error:error];
    if ((*error != nil) || (fileSystemSizeInBytes == nil)) return 0;

    return [fileSystemSizeInBytes unsignedLongLongValue];
}


#pragma mark File system attribute querying shortcuts

- (id)fileSystemPropertyWithName:(NSString*)property error:(NSError**)error
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* lastPath = [paths lastObject];
    NSDictionary* dictionary = [self attributesOfFileSystemForPath:lastPath error:error];

    if ((*error != nil) || (dictionary == nil)) return nil;

    return dictionary[property];
}

@end
