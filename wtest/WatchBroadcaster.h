//
//  WatchBroadcaster.h
//  wtest
//
//  Created by Vladimir Lebedev-Shmidtgof on 28/02/2018.
//  Copyright © 2018 Transas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

@protocol WatchBroadcasterDelegate <NSObject>

- (void)didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext;

@end

@interface WatchBroadcaster : NSObject <WCSessionDelegate>

- (void)addDelegate:(id<WatchBroadcasterDelegate>)delegate;
- (void)removeDelegate:(id<WatchBroadcasterDelegate>)delegate;

- (void)sendApplicationContext:(NSDictionary<NSString *,id> *)applicationContext;

@end
