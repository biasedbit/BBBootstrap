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


#pragma mark Public static methods

+ (CGRect)center:(CGRect)rect inRect:(CGRect)outerRect;
+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration animations:(void (^)())animations;
+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration
        animations:(void (^)())animations completion:(void (^)(BOOL))completion;
+ (void)animate:(BOOL)animated withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
        options:(UIViewAnimationOptions)options animations:(void (^)())animations completion:(void (^)(BOOL))completion;


#pragma mark Public methods

- (void)centerInRect:(CGRect)rect;
- (CGRect)rectCenteredInRect:(CGRect)rect;
- (void)move:(CGPoint)movement;
- (void)moveTo:(CGPoint)point;
- (void)moveToFrame:(CGRect)frame withDuration:(NSTimeInterval)duration
         bounceAmount:(CGFloat)bounce andBounceDuration:(NSTimeInterval)bounceDuration;

@end
