//
//  InterfaceController.m
//  wtest WatchKit Extension
//
//  Created by Vladimir Lebedev-Shmidtgof on 27/02/2018.
//  Copyright © 2018 Transas. All rights reserved.
//

#import "InterfaceController.h"
#import "ExtensionDelegate.h"
#import "WatchBroadcaster.h"

@interface InterfaceController () {
    NSInteger _count;
}

@property IBOutlet WKInterfaceLabel* label;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    _count = 0;

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];

    [self.label setText:[NSString stringWithFormat:@"%lu", (unsigned long)_count]];

    [((ExtensionDelegate*)WKExtension.sharedExtension.delegate).broadcaster addDelegate:self];
}

- (void)changeNumber:(NSInteger)n {
    dispatch_async(dispatch_get_main_queue(), ^{
        _count = n;
        [self.label setText:[NSString stringWithFormat:@"%ld", (unsigned long)_count]];
    });
}

- (void)didDeactivate {
    [((ExtensionDelegate*)WKExtension.sharedExtension.delegate).broadcaster removeDelegate:self];
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)onButtonClick:(id)sender {
    [self changeNumber:_count-1];
    [((ExtensionDelegate*)WKExtension.sharedExtension.delegate).broadcaster sendApplicationContext:@{@"number": @(_count-1)}];
}

# pragma mark - DataReceiver
- (void)didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    NSNumber* num = [applicationContext objectForKey:@"number"];
    if (num != nil) {
        [self changeNumber:num.integerValue];
    }
}

@end
