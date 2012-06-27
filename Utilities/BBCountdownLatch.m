//
//  BBCountdownLatch.m
//  RemotelyTouch
//
//  Created by Bruno de Carvalho on 6/27/12.
//
//

#import "BBCountDownLatch.h"



#pragma mark -

@implementation BBCountDownLatch
{
    BBCountDownLatchBlock _block;
    dispatch_queue_t _queue;
    NSUInteger _counter;
    BOOL _cancelled;

    __strong NSString* _name;
}


#pragma mark Property synthesizers

@synthesize name = _name;
@synthesize queue = _queue;
@synthesize counter = _counter;
@synthesize cancelled = _cancelled;


#pragma mark Creation

- (id)initWithName:(NSString*)name queue:(dispatch_queue_t)queue counter:(NSUInteger)counter
          andBlock:(BBCountDownLatchBlock)block
{
    self = [super init];
    if (self != nil) {
        _name = name;
        _queue = queue;
        _counter = counter;
        _cancelled = NO;
        _block = block;
    }

    return self;
}


#pragma mark Public static methods

+ (BBCountDownLatch*)latchWithId:(NSString*)identifier counter:(NSUInteger)counter
                      andBlock:(BBCountDownLatchBlock)block
{
    NSString* queueName = [NSString stringWithFormat:@"com.biasedbit.CDLQueue-%@", identifier];
    dispatch_queue_t queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);

    BBCountDownLatch* latch = [[BBCountDownLatch alloc]
                               initWithName:identifier queue:queue counter:counter andBlock:block];

    return latch;
}


#pragma mark Public methods

- (BOOL)cancel
{
    if (_cancelled) {
        return NO;
    }

    _cancelled = YES;

    return YES;
}

- (BOOL)executeBlock
{
    return [self executeBlockWithCallerId:@"anonymous"];
}

- (BOOL)executeBlockWithCallerId:(NSString*)callerId
{
    __block BOOL output;
    dispatch_sync(_queue, ^{
        if (_counter == 0) {
            LogDebug(@"[LATCH-%@] '%@' tried to execute block but counter was already at 0; ignoring...",
                     _name, callerId);
            output = NO;
            return;
        }

        if (_cancelled) {
            LogDebug(@"[LATCH-%@] '%@' tried to execute block but latch has been cancelled; ignoring...",
                     _name, callerId);
            output = NO;
            return;
        }

        _counter -= 1;
        if (_counter == 0) {
            LogTrace(@"[LATCH-%@] Triggered and released by '%@'.", _name, callerId);
            _block();
        } else {
            LogTrace(@"[LATCH-%@] Triggered by '%@'; current count: %d.", _name, callerId, _counter);
        }
        output = YES;
    });

    return output;
}

// Here be dragons; handle with care!
- (void)resetRequestCounter:(NSUInteger)newCounterValue
{
    _counter = newCounterValue;
}


#pragma mark Debug

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@{name='%@', counter=%u, queue='%s', cancelled=%@}",
            NSStringFromClass([self class]), _name, _counter, dispatch_queue_get_label(_queue),
            _cancelled ? @"YES" : @"NO"];
}

@end
