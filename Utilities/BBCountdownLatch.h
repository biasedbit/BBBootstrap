//
//  BBCountdownLatch.h
//  RemotelyTouch
//
//  Created by Bruno de Carvalho on 6/27/12.
//
//

#pragma mark - Custom types

typedef void (^BBCountDownLatchBlock)();



#pragma mark -

@interface BBCountDownLatch : NSObject


#pragma mark Public properties

@property(strong, nonatomic, readonly) NSString* name;
@property(assign, nonatomic, readonly) dispatch_queue_t queue;
@property(assign, nonatomic, readonly) NSUInteger counter;
@property(assign, nonatomic, readonly) BOOL cancelled;


#pragma mark Creation

- (id)initWithName:(NSString*)name queue:(dispatch_queue_t)queue counter:(NSUInteger)counter
          andBlock:(BBCountDownLatchBlock)block;


#pragma mark Public static methods

+ (BBCountDownLatch*)latchWithId:(NSString*)identifier counter:(NSUInteger)counter
                        andBlock:(BBCountDownLatchBlock)block;


#pragma mark Public methods

- (BOOL)cancel;
- (BOOL)executeBlock;
- (BOOL)executeBlockWithCallerId:(NSString*)callerId;
// Here be dragons; handle with care!
- (void)resetRequestCounter:(NSUInteger)newCounterValue;

@end
