//
//  WatchBroadcaster.m
//  wtest
//
//  Created by Vladimir Lebedev-Shmidtgof on 28/02/2018.
//  Copyright © 2018 Transas. All rights reserved.
//

#import "WatchBroadcaster.h"

@interface WatchBroadcaster () {
    NSMutableSet* _delegates;
    WCSession* _session;
}

@end

@implementation WatchBroadcaster

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([WCSession isSupported])
        {
            _session = [WCSession defaultSession];
            _session.delegate = self;

            [_session activateSession];
        }

        _delegates = [NSMutableSet new];
    }
    return self;
}

- (void)addDelegate:(id<WatchBroadcasterDelegate>)delegate {
    [_delegates addObject:delegate];
}

- (void)removeDelegate:(id<WatchBroadcasterDelegate>)delegate {
    [_delegates removeObject:delegate];
}

#pragma mark - WCSessionDelegate
- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    // well, ...
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString*,id>*)message {
}

- (void)session:(WCSession*)session didReceiveMessage:(NSDictionary<NSString*, id>*)message replyHandler:(void(^)(NSDictionary<NSString*, id> *replyMessage))replyHandler {
    replyHandler(@{});
}

- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    for (id<WatchBroadcasterDelegate> delegate in _delegates) {
        [delegate didReceiveApplicationContext:applicationContext];
    }
}

- (void)sessionDidBecomeInactive:(nonnull WCSession *)session {
    //
}

- (void)sessionDidDeactivate:(nonnull WCSession *)session {
    //
}

- (void)sendApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    NSError* error = nil;
    [_session updateApplicationContext:applicationContext
                                 error:&error];
    if (error != nil) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
    }
}



@end
