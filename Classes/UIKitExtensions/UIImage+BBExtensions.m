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

#import "UIImage+BBExtensions.h"



#pragma mark -

@implementation UIImage (BBExtensions)


#pragma mark Shortcuts to load stretchable images

+ (UIImage*)stretchableImageNamed:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger leftCap = (NSInteger) roundf(image.size.width / 2);
    NSInteger rightCap = image.size.width - leftCap;
    NSInteger topCap = (NSInteger) roundf(image.size.height / 2);
    NSInteger bottomCap = image.size.height - topCap;

    // Ensure that we have a 1x1 untouched pixel at the center of the image
    // by reducing right and bottom caps by 1px if necessary
    if ((leftCap - rightCap) == 0) rightCap--;
    if ((topCap - bottomCap) == 0) bottomCap--;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap)];
}

+ (UIImage*)horizontallyStretchableImageNamed:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger leftCap = (NSInteger) roundf(image.size.width / 2);
    NSInteger rightCap = image.size.width - leftCap;

    if ((leftCap - rightCap) == 0) rightCap--;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, leftCap, 0, rightCap)];
}

+ (UIImage*)verticallyStretchableImageNamed:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger topCap = (NSInteger) roundf(image.size.height / 2);
    NSInteger bottomCap = image.size.height - topCap;

    if ((topCap - bottomCap) == 0) bottomCap--;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, 0, bottomCap, 0)];
}

+ (UIImage*)stretchableImageNamed:(NSString*)imageName withCommonCapInset:(CGFloat)capInset
{
    if (BBSystemVersion() >= 6.0) {
        UIImage* image = [UIImage imageNamed:imageName];
        UIEdgeInsets insets = UIEdgeInsetsMake(capInset, capInset, capInset, capInset);

        return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    } else {
        // Fallback to a less horrible version
        return [self stretchableImageNamed:imageName];
    }
}

+ (UIImage*)stretchableImageNamed:(NSString*)imageName withLeftCap:(NSInteger)leftCap
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger rightCap = image.size.width - leftCap;
    NSInteger topCap = (NSInteger) roundf(image.size.height / 2);
    NSInteger bottomCap = image.size.height - topCap;

    if (rightCap < 0) rightCap = 0;
    if ((topCap - bottomCap) == 0) bottomCap--;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap)];
}

+ (UIImage*)stretchableImageNamed:(NSString*)imageName withRightCap:(NSInteger)rightCap
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger leftCap = image.size.width - rightCap;
    NSInteger topCap = (NSInteger) roundf(image.size.height / 2);
    NSInteger bottomCap = image.size.height - topCap;

    if (leftCap < 0) leftCap = 0;
    if ((topCap - bottomCap) == 0) bottomCap--;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap)];
}

+ (UIImage*)stretchableImageNamed:(NSString*)imageName withTopCap:(NSInteger)topCap
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger leftCap = (NSInteger) roundf(image.size.width / 2);
    NSInteger rightCap = image.size.width - leftCap;
    NSInteger bottomCap = image.size.height - topCap;

    if ((leftCap - rightCap) == 0) rightCap--;
    if (bottomCap < 0) bottomCap = 0;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap)];
}

+ (UIImage*)stretchableImageNamed:(NSString*)imageName withBottomCap:(NSInteger)bottomCap
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger leftCap = (NSInteger) roundf(image.size.width / 2);
    NSInteger rightCap = image.size.width - leftCap;
    NSInteger topCap = image.size.height - bottomCap;

    if ((leftCap - rightCap) == 0) rightCap--;
    if (topCap < 0) topCap = 0;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap)];
}

@end
