//
//  ViewController.m
//  wtest
//
//  Created by Vladimir Lebedev-Shmidtgof on 27/02/2018.
//  Copyright © 2018 Transas. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onButtonClick:(id)sender {
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] broadcaster] sendMessage:@{@"number": @1}];
}

- (void)didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {

}

- (void)didReceiveMessage:(NSDictionary<NSString *,id> *)message {
    
}

@end
