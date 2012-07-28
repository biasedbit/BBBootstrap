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
 Center current view in `rect`.
 
 This method **will change** the current view's frame.
 
 @param rect Rectangle relative to which the current view's frame should be centered.
 */
- (void)centerInRect:(CGRect)rect;

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

/**
 Performs a vertical movement on the current view, optionally performing a small bounce animation at the end.
 
 If you're moving a frame from above and bounce is positive, it will appear as if the object bounced off of some
 surface. If you use a negative bounce, it will appear as if the object slightly passes the landing mark and then
 snaps back into place. Try variations on these for optimum results.
 
 @param verticalMovement Vertical displacement.
 @param duration Total duration of the animation. Use `0` to avoid animation.
 @param bounce Bounce displacement.
 @param bounceDuration Bounce animation duration.
 */
- (void)moveVertically:(CGFloat)verticalMovement withDuration:(NSTimeInterval)duration
         bounceAmount:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

/**
 Performs a vertical movement on the current view, positioning it at the target `y` coordinate, optionally performing a
 small bounce animation at the end.


 @param originY Target `y` coordinate for the frame.
 @param duration Total duration of the animation. Use `0` to avoid animation.
 @param bounce Bounce displacement.
 @param bounceDuration Bounce animation duration.
 
 @see moveVertically:withDuration:bounceAmount:andBounceDuration:
 */
- (void)moveVerticallyTo:(CGFloat)originY withDuration:(NSTimeInterval)duration
          bounceAmount:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

@end
