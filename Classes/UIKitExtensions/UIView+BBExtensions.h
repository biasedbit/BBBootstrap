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

#pragma mark -

@interface UIView (BBExtensions)


///--------------------------
/// @name Animation shortcuts
///--------------------------

/**
 Shortcut for animate:withDuration:delay:options:animations:completion:

 @see animate:withDuration:delay:options:animations:completion:
 */
+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration animations:(void (^)())animations;

/**
 Shortcut for animate:withDuration:delay:options:animations:completion:

 @see animate:withDuration:delay:options:animations:completion:
 */
+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration
        animations:(void (^)())animations completion:(void (^)(BOOL))completion;

/**
 Shortcut for [UIView animateWithDuration:delay:options:animations:completion:], optionally performing the changes in
 `animations` block if `animated` is set to `YES`.

 Avoids the following common animation pattern:
 
     if (animate) {
         // Branch one
         [UIView animateWithDuration:... animations:animationBlock completion:completionBlock];
     } else {
         // Branch two
         changeBlock();
         completionBlock(YES);
     }

 @see [UIView animateWithDuration:delay:options:animations:completion:]
 */
+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
        options:(UIViewAnimationOptions)options animations:(void (^)())animations completion:(void (^)(BOOL))completion;


///-------------------------------------------
/// @name Positioning, location and dimensions
///-------------------------------------------

/**
 Calculate the rectangle resulting of centering `rect` in `outerRect`.
 
 @param rect Rectangle to center.
 @param outerRect Outter rectangle. `rect` will be centered relatively to this rectangle.

 @return A `CGRect` containing the result of the operation.
 */
+ (CGRect)center:(CGRect)rect inRect:(CGRect)outerRect;

/**
 Calculate the rectangle resulting of centering `rect`'s `x` axis in `outerRect`.

 @param rect Rectangle to center.
 @param outerRect Outer rectangle. `rect`'s `x` coordinates will be centered relatively to this rectangle.

 @return A `CGRect` containing the result of the operation.
 */
+ (CGRect)center:(CGRect)rect horizontallyInRect:(CGRect)outerRect;

/**
 Calculate the rectangle resulting of centering `rect`'s `y` axis in `outerRect`.

 @param rect Rectangle to center.
 @param outerRect Outer rectangle. `rect`'s `y` coordinates will be centered relatively to this rectangle.

 @return A `CGRect` containing the result of the operation.
 */
+ (CGRect)center:(CGRect)rect verticallyInRect:(CGRect)outerRect;

/**
 Center current view in `rect`.
 
 This method **will change** the current view's frame.
 
 @param rect Rectangle relative to which the current view's frame should be centered.
 */
- (void)centerInRect:(CGRect)rect;

/**
 Center current view's `x` coordinates in `rect`.

 This method **will change** the current view's frame.

 @param rect Rectangle relative to which the current view's `x` coordinates should be centered.
 */
- (void)centerHorizontallyInRect:(CGRect)rect;

/**
 Center current view's `y` coordinates in `rect`.

 This method **will change** the current view's frame.

 @param rect Rectangle relative to which the current view's `y` coordinates should be centered.
 */
- (void)centerVerticallyInRect:(CGRect)rect;


/**
 Calculate the result of centering the current view's frame in a given rectangle.
 
 This method does **not** modify the current view's frame.
 
 @param rect Rectangle relative to which the current view's frame should be centered.
 
 @return A `CGRect` containing the result of the operation.
 */
- (CGRect)rectCenteredInRect:(CGRect)rect;

/**
 Move the current view a given instance.
 
 This method changes the view's `frame.origin` by adding the input `movement` to the current `frame.origin`. You may
 use negative values to move the view up/left or positive values to move it down/right.
 
 @param movement Amount of movement in `x` and `y` coordinates.
 */
- (void)move:(CGSize)movement;

/**
 Move the current view to a given point.
 
 This method changes the view's `frame.origin` property.
 
 @param point Target point.
 */
- (void)moveTo:(CGPoint)point;

- (void)moveToX:(CGFloat)x;

- (void)moveToY:(CGFloat)y;

/**
 Move the current view on the `x` axis, optionally performing a small bounce animation at the end.

 @see moveTo:withDuration:bounce:andBounceDuration:
 */
- (void)moveVertically:(CGFloat)verticalMovement withDuration:(NSTimeInterval)duration
                bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

/**
 Move the current view to the target `y`, optionally performing a small bounce animation at the end.

 @see moveTo:withDuration:bounce:andBounceDuration:
 */
- (void)moveVerticallyTo:(CGFloat)targetY withDuration:(NSTimeInterval)duration
                  bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

/**
 Move the current view on the `x` axis, optionally performing a small bounce animation at the end.

 @see moveTo:withDuration:bounce:andBounceDuration:
 */
- (void)moveHorizontally:(CGFloat)horizontalMovement withDuration:(NSTimeInterval)duration
                  bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

/**
 Move the current view to the target `x` coordinate, optionally performing a small bounce animation at the end.

 @see moveTo:withDuration:bounce:andBounceDuration:
 */
- (void)moveHorizontallyTo:(CGFloat)targetX withDuration:(NSTimeInterval)duration
                    bounce:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

/**
 Move the current view, optionally performing a small bounce animation at the end.
 
 @see moveTo:withDuration:bounce:andBounceDuration:
 */
- (void)move:(CGSize)movement withDuration:(NSTimeInterval)duration
      bounce:(CGSize)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

/**
 Moves the current view to target point, optionally performing a small bounce animation at the end.

 If you're moving a frame from above and bounce is positive, it will appear as if the object bounced off of some
 surface. If you use a negative bounce, it will appear as if the object slightly passes the landing mark and then
 snaps back into place. Try variations on these for optimum results.

 @param target Target point, where the view's origin will be after the animation ends.
 @param duration Total duration of the animation. Use `0` to avoid animation.
 @param bounce Bounce displacement.
 @param bounceDuration Bounce animation duration.
 */
- (void)moveTo:(CGPoint)target withDuration:(NSTimeInterval)duration
        bounce:(CGSize)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

@end
