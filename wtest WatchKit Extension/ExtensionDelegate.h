//
//  ExtensionDelegate.h
//  wtest WatchKit Extension
//
//  Created by Vladimir Lebedev-Shmidtgof on 27/02/2018.
//  Copyright © 2018 Transas. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import "WatchBroadcaster.h"

@interface ExtensionDelegate : NSObject <WKExtensionDelegate>

@property (nonatomic) WatchBroadcaster* broadcaster;

@end
