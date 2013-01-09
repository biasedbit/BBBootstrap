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

@interface NSFileManager (BBExtensions)


#pragma mark Deletion shortcuts

///-------------------------
/// @name Deletion shortcuts
///-------------------------

/**
 Deletes all the files inside a given folder.

 @param pathToFolder folder to delete
 @return -1 if given folder does not exist or is not a folder.
         0 if either folder is already empty or all the files are successfully deleted.
         N > 0, where N is the number of files that could not be deleted.
 */
- (NSInteger)deleteAllFilesInFolder:(NSString*)pathToFolder;

@end
