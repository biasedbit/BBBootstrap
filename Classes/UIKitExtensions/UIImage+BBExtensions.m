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

    NSInteger halfWidth = (NSInteger) (image.size.width / 2);
    NSInteger halfHeight = (NSInteger) (image.size.height / 2);

    return [image stretchableImageWithLeftCapWidth:halfWidth topCapHeight:halfHeight];
}

+ (UIImage*)horizontallyStretchableImageNamed:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger halfWidth = (NSInteger) (image.size.width / 2);

    return [image stretchableImageWithLeftCapWidth:halfWidth topCapHeight:0];
}

+ (UIImage*)verticallyStretchableImageNamed:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];

    NSInteger halfHeight = (NSInteger) (image.size.height / 2);

    return [image stretchableImageWithLeftCapWidth:0 topCapHeight:halfHeight];
}

+ (UIImage*)stretchableImageNamed:(NSString*)imageName withLeftCapWidth:(NSInteger)leftCapWidth
{
    return [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0];
}

+ (UIImage*)stretchableImageNamed:(NSString*)imageName withTopCapHeight:(NSInteger)topCapHeight
{
    return [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:0 topCapHeight:topCapHeight];
}

@end
