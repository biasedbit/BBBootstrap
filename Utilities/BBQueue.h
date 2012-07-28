//
//  BBQueue.h
//  RemotelyTouch
//
//  Created by Bruno de Carvalho on 7/27/12.
//  Copyright (c) 2012 Graceful, LLC. All rights reserved.
//

#pragma mark - Protocols

@protocol BBQueueOperation <NSObject>

@required
- (void)beginQueueOperation;
- (BOOL)isQueueOperationCancelled;
- (BOOL)cancelQueueOperation;

@end



#pragma mark -

@interface BBQueue : NSObject


#pragma mark Creation

- (id)initWithName:(NSString*)name andSlots:(NSUInteger)slots;
- (id)initWithName:(NSString*)name slots:(NSUInteger)slots andMaxQueueSize:(NSUInteger)maxQueueSize;


#pragma mark Public methods

- (BOOL)enqueue:(id<BBQueueOperation>)queueOperation;
- (BOOL)enqueue:(id<BBQueueOperation>)queueOperation prioritize:(BOOL)prioritize;
- (void)queueOperationFinished:(id<BBQueueOperation>)queueOperation;

@end
