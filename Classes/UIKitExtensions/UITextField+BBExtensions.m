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

#import "UITextField+BBExtensions.h"



#pragma mark -

@implementation UITextField (BBExtensions)


#pragma mark Selection helpers

- (void)selectAllText
{
    UITextRange* range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range
{
	UITextPosition* beginning = self.beginningOfDocument;
	UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
	UITextPosition* endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
	UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];

	[self setSelectedTextRange:selectionRange];
}

@end
