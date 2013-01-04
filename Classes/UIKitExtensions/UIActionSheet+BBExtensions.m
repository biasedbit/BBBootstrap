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

#import "UIActionSheet+BBExtensions.h"

#import <objc/runtime.h>



#pragma mark -

@implementation UIActionSheet (BBExtensions)

static id kUIActionSheet_BBExtensionsCompletionBlockKey;


#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet*)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    void (^completion)(NSInteger buttonIndex);
    completion = objc_getAssociatedObject(self, &kUIActionSheet_BBExtensionsCompletionBlockKey);

    completion(buttonIndex);
}


#pragma mark Interface

- (void)setCompletion:(void (^)(NSInteger buttonIndex))completion
{
    if (completion == nil) return;

    self.delegate = self;
    objc_setAssociatedObject(self, &kUIActionSheet_BBExtensionsCompletionBlockKey,
                             completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
