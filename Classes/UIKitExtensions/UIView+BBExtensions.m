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

#import "UIView+BBExtensions.h"



#pragma mark -

@implementation UIView (BBExtensions)


#pragma mark Animation shortcuts

+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration animations:(void (^)())animations
{
    if (animated) {
        [UIView animateWithDuration:duration animations:animations];
    } else {
        animations();
    }
}

+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration
      animations:(void (^)())animations completion:(void (^)(BOOL))completion
{
    if (animated) {
        [UIView animateWithDuration:duration animations:animations completion:completion];
    } else {
        animations();
        if (completion != nil) {
            completion(YES);
        }
    }
}

+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
        options:(UIViewAnimationOptions)options animations:(void (^)())animations completion:(void (^)(BOOL))completion
{
    if (animated) {
        [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:completion];
    } else {
        animations();
        if (completion != nil) {
            completion(YES);
        }
    }
}


#pragma mark Positioning, location and dimensions

+ (CGRect)center:(CGRect)rect inRect:(CGRect)outerRect
{
    CGRect r;
    r.size = rect.size;
    r.origin.x = floorf((outerRect.size.width - rect.size.width) / 2.0 + outerRect.origin.x);
    r.origin.y = floorf((outerRect.size.height - rect.size.height) / 2.0 + outerRect.origin.y);

    return r;
}

- (void)centerInRect:(CGRect)rect
{
    self.frame = [UIView center:self.frame inRect:rect];
}

- (CGRect)rectCenteredInRect:(CGRect)rect
{
    return [UIView center:self.frame inRect:rect];
}

- (void)move:(CGSize)movement
{
    CGRect targetFrame = self.frame;
    targetFrame.origin.x += movement.width;
    targetFrame.origin.y += movement.height;

    self.frame = targetFrame;
}

- (void)moveTo:(CGPoint)point
{
    CGRect targetFrame = self.frame;
    targetFrame.origin.x = point.x;
    targetFrame.origin.y = point.y;

    self.frame = targetFrame;
}

- (void)moveVertically:(CGFloat)verticalMovement withDuration:(NSTimeInterval)duration
       bounceAmount:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration
{
    CGRect targetFrame = self.frame;
    targetFrame.origin.y += verticalMovement;

    CGRect frameWithBounce = targetFrame;
    frameWithBounce.origin.y += bounce;

    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = frameWithBounce;
    } completion:^(BOOL finished) {
        if (!finished) {
            self.frame = targetFrame;
        }

        [UIView animateWithDuration:bounceDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = targetFrame;
        } completion:nil];
    }];
}

- (void)moveVerticallyTo:(CGFloat)originY withDuration:(NSTimeInterval)duration
            bounceAmount:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration
{
    CGFloat verticalDelta = originY - self.frame.origin.y;
    [self moveVertically:verticalDelta withDuration:duration bounceAmount:bounce andBounceDuration:bounceDuration];
}

@end
