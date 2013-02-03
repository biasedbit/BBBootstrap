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

#import "UIView+BBExtensions.h"



#pragma mark - Constants

NSUInteger const UIViewAutoresizingFlexibleMargins = UIViewAutoresizingFlexibleLeftMargin |
                                                        UIViewAutoresizingFlexibleTopMargin |
                                                        UIViewAutoresizingFlexibleRightMargin |
                                                        UIViewAutoresizingFlexibleBottomMargin;
NSUInteger const UIViewAutoresizingFlexibleDimensions = UIViewAutoresizingFlexibleWidth |
                                                        UIViewAutoresizingFlexibleHeight;


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

+ (CGRect)center:(CGRect)rect horizontallyInRect:(CGRect)outerRect
{
    CGRect r;
    r.size = rect.size;
    r.origin.x = floorf((outerRect.size.width - rect.size.width) / 2.0 + outerRect.origin.x);
    r.origin.y = rect.origin.y;

    return r;
}

+ (CGRect)center:(CGRect)rect verticallyInRect:(CGRect)outerRect
{
    CGRect r;
    r.size = rect.size;
    r.origin.x = rect.origin.x;
    r.origin.y = floorf((outerRect.size.height - rect.size.height) / 2.0 + outerRect.origin.y);

    return r;
}

- (id)centerInRect:(CGRect)rect
{
    self.frame = [UIView center:self.frame inRect:rect];
    return self;
}

- (id)centerHorizontallyInRect:(CGRect)rect
{
    self.frame = [UIView center:self.frame horizontallyInRect:rect];
    return self;
}

- (id)centerVerticallyInRect:(CGRect)rect
{
    self.frame = [UIView center:self.frame verticallyInRect:rect];
    return self;
}

- (CGRect)rectCenteredInRect:(CGRect)rect
{
    return [UIView center:self.frame inRect:rect];
}

- (id)move:(CGSize)movement
{
    CGRect targetFrame = self.frame;
    targetFrame.origin.x += movement.width;
    targetFrame.origin.y += movement.height;

    self.frame = targetFrame;

    return self;
}

- (id)moveTo:(CGPoint)point
{
    CGRect targetFrame = self.frame;
    targetFrame.origin.x = point.x;
    targetFrame.origin.y = point.y;

    self.frame = targetFrame;

    return self;
}

- (id)moveToX:(CGFloat)x
{
    [self moveTo:CGPointMake(x, self.frame.origin.y)];
    return self;
}

- (id)moveToY:(CGFloat)y
{
    [self moveTo:CGPointMake(self.frame.origin.x, y)];
    return self;
}

- (void)moveVertically:(CGFloat)verticalMovement withDuration:(NSTimeInterval)duration
       bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration
            completion:(void (^)(BOOL finished))completion
{
    CGSize targetMovement = CGSizeMake(0, verticalMovement);
    CGSize targetBounce = CGSizeMake(0, bounce);

    [self move:targetMovement withDuration:duration
        bounce:targetBounce andBounceDuration:bounceDuration
    completion:completion];
}

- (void)moveVerticallyTo:(CGFloat)targetY withDuration:(NSTimeInterval)duration
                  bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration
              completion:(void (^)(BOOL finished))completion
{
    CGPoint target = self.frame.origin;
    target.y = targetY;

    CGSize targetBounce = CGSizeMake(0, bounce);

    [self moveTo:target withDuration:duration
          bounce:targetBounce andBounceDuration:bounceDuration
      completion:completion];
}

- (void)moveHorizontally:(CGFloat)horizontalMovement withDuration:(NSTimeInterval)duration
                  bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration
              completion:(void (^)(BOOL finished))completion
{
    CGSize targetMovement = CGSizeMake(horizontalMovement, 0);
    CGSize targetBounce = CGSizeMake(bounce, 0);

    [self move:targetMovement withDuration:duration
        bounce:targetBounce andBounceDuration:bounceDuration
    completion:completion];
}

- (void)moveHorizontallyTo:(CGFloat)targetX withDuration:(NSTimeInterval)duration
                    bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration
                completion:(void (^)(BOOL finished))completion
{
    CGPoint target = self.frame.origin;
    target.x = targetX;

    CGSize targetBounce = CGSizeMake(bounce, 0);

    [self moveTo:target withDuration:duration
          bounce:targetBounce andBounceDuration:bounceDuration
      completion:completion];
}

- (void)move:(CGSize)movement withDuration:(NSTimeInterval)duration
      bounce:(CGSize)bounce andBounceDuration:(NSTimeInterval)bounceDuration
  completion:(void (^)(BOOL finished))completion
{
    CGPoint currentOrigin = self.frame.origin;
    CGPoint target = CGPointMake(currentOrigin.x + movement.width, currentOrigin.y + movement.height);

    [self moveTo:target withDuration:duration
          bounce:bounce andBounceDuration:bounceDuration
      completion:completion];
}

- (void)moveTo:(CGPoint)target withDuration:(NSTimeInterval)duration
        bounce:(CGSize)bounce andBounceDuration:(NSTimeInterval)bounceDuration
    completion:(void (^)(BOOL finished))completion
{
    CGRect targetFrame = self.frame;
    targetFrame.origin = target;

    CGRect frameWithBounce = targetFrame;
    frameWithBounce.origin = CGPointMake(target.x + bounce.width, target.y + bounce.height);

    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = frameWithBounce;
    } completion:^(BOOL finished) {
        if (!finished) {
            self.frame = targetFrame;
            if (completion != nil) completion(NO);
            return;
        }

        [UIView animateWithDuration:bounceDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = targetFrame;
        } completion:completion];
    }];
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
