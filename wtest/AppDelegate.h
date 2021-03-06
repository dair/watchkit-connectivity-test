//
//  AppDelegate.h
//  wtest
//
//  Created by Vladimir Lebedev-Shmidtgof on 27/02/2018.
//  Copyright © 2018 Transas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchBroadcaster.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) WatchBroadcaster* broadcaster;

@end
