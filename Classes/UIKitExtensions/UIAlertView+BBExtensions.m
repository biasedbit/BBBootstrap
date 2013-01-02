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

#import "UIAlertView+BBExtensions.h"



#pragma mark - Macros

#ifndef L10n
    #define L10n(key) NSLocalizedString(key, nil)
#endif



#pragma mark -

@interface BBAlertView : UIAlertView <UIAlertViewDelegate>

@property(copy, nonatomic) void (^completion)(NSInteger buttonIndex);

@end




#pragma mark -

@implementation UIAlertView (BBExtensions)


#pragma mark Class interface

+ (void)showAlertWithTitle:(NSString*)title
{
    [[[UIAlertView alloc]
      initWithTitle:title message:nil delegate:nil
      cancelButtonTitle:L10n(@"Dismiss") otherButtonTitles:nil]
     show];
}

+ (void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    [[[UIAlertView alloc] 
      initWithTitle:title message:message delegate:nil 
      cancelButtonTitle:L10n(@"Dismiss") otherButtonTitles:nil]
     show];
}

+ (UIAlertView*)noticeWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle
                     completion:(void (^)())completion
{
    BBAlertView* alertView = [[BBAlertView alloc]
                              initWithTitle:title message:message delegate:nil
                              cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    alertView.delegate = alertView;
    alertView.completion = ^(NSInteger buttonIndex) {
        completion();
    };

    return alertView;
}

+ (UIAlertView*)inputWithTitle:(NSString*)title submission:(void (^)(NSString* text))submission
{
    BBAlertView* alertView = [[BBAlertView alloc]
                              initWithTitle:title message:nil delegate:nil
                              cancelButtonTitle:L10n(@"Cancel") otherButtonTitles:L10n(@"OK"), nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertView.delegate = alertView;

    __weak id weakRef = alertView;
    alertView.completion = ^(NSInteger buttonIndex) {
        if (buttonIndex == 1) submission([weakRef textFieldAtIndex:0].text);
    };

    return alertView;
}

+ (UIAlertView*)confirmationWithTitle:(NSString*)title confirmation:(void (^)())confirmation
{
    BBAlertView* alertView = [[BBAlertView alloc]
                              initWithTitle:title message:nil delegate:nil
                              cancelButtonTitle:L10n(@"Cancel") otherButtonTitles:L10n(@"OK"), nil];
    alertView.delegate = alertView;

    alertView.completion = ^(NSInteger buttonIndex) {
        if (buttonIndex == 1) confirmation();
    };

    return alertView;
}

- (id)initWithTitle:(NSString*)title message:(NSString*)message
  cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles
         completion:(void (^)(NSInteger buttonIndex))completion
{
    BBAlertView* alertView = [[BBAlertView alloc] init];
    alertView.title = title;
    alertView.message = message;

    for (NSString* buttonTitle in otherButtonTitles) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    [alertView addButtonWithTitle:cancelButtonTitle];
    [alertView setCancelButtonIndex:([alertView numberOfButtons] - 1)];

    alertView.delegate = alertView;
    alertView.completion = completion;

    return alertView;
}

@end



#pragma mark -

@implementation BBAlertView


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_completion == nil) return;
    _completion(buttonIndex);
}

@end

