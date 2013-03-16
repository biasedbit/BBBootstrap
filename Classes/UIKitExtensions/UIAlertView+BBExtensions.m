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

#import "UIAlertView+BBExtensions.h"

#import <objc/runtime.h>



#pragma mark - Macros

#ifndef L10n
    #define L10n(key) NSLocalizedString(key, nil)
#endif



#pragma mark -

@implementation UIAlertView (BBExtensions)

static id kUIAlertView_BBExtensionsCompletionBlockKey;


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    void (^completion)(NSInteger buttonIndex);
    completion = objc_getAssociatedObject(self, &kUIAlertView_BBExtensionsCompletionBlockKey);

    if (completion != nil) completion(buttonIndex);
}


#pragma mark Class interface

+ (void)showAlertWithTitle:(NSString*)title
{
    [[[[self class] alloc]
      initWithTitle:title message:nil delegate:nil
      cancelButtonTitle:L10n(@"Dismiss") otherButtonTitles:nil]
     show];
}

+ (void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    [[[[self class] alloc]
      initWithTitle:title message:message delegate:nil 
      cancelButtonTitle:L10n(@"Dismiss") otherButtonTitles:nil]
     show];
}

+ (instancetype)noticeWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle
                     completion:(void (^)())completion
{
    UIAlertView* alertView = [[[self class] alloc]
                              initWithTitle:title message:message delegate:nil
                              cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    alertView.delegate = alertView;
    [alertView setCompletion:^(NSInteger buttonIndex) {
        completion();
    }];

    return alertView;
}

+ (instancetype)inputWithTitle:(NSString*)title submission:(void (^)(NSString* text))submission
{
    UIAlertView* alertView = [[[self class] alloc]
                              initWithTitle:title message:nil delegate:nil
                              cancelButtonTitle:L10n(@"Cancel") otherButtonTitles:L10n(@"OK"), nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    __weak id weakRef = alertView;
    [alertView setCompletion:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) submission([weakRef textFieldAtIndex:0].text);
    }];

    return alertView;
}

+ (instancetype)confirmationWithTitle:(NSString*)title confirmation:(void (^)())confirmation
{
    UIAlertView* alertView = [[[self class] alloc]
                              initWithTitle:title message:nil delegate:nil
                              cancelButtonTitle:L10n(@"Cancel") otherButtonTitles:L10n(@"OK"), nil];

    [alertView setCompletion:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) confirmation();
    }];

    return alertView;
}

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message
            cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles
                   completion:(void (^)(NSInteger buttonIndex))completion
{
    self = [super init];
    if (self != nil) {
        self.title = title;
        self.message = message;

        for (NSString* buttonTitle in otherButtonTitles) {
            [self addButtonWithTitle:buttonTitle];
        }
        [self addButtonWithTitle:cancelButtonTitle];
        [self setCancelButtonIndex:([self numberOfButtons] - 1)];

        self.delegate = self;
        [self setCompletion:completion];
    }

    return self;
}


#pragma mark Interface

- (void)setCompletion:(void (^)(NSInteger buttonIndex))completion
{
    if (completion == nil) return;

    self.delegate = self;
    objc_setAssociatedObject(self, &kUIAlertView_BBExtensionsCompletionBlockKey,
                             completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
