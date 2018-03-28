//
//  ViewController.m
//  wtest
//
//  Created by Vladimir Lebedev-Shmidtgof on 27/02/2018.
//  Copyright © 2018 Transas. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController () {
    NSInteger _count;
}

@property IBOutlet UILabel* label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[(AppDelegate*)UIApplication.sharedApplication.delegate broadcaster] addDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[(AppDelegate*)UIApplication.sharedApplication.delegate broadcaster] removeDelegate:self];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    [self changeNumber:_count+1];
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] broadcaster] sendApplicationContext:@{@"number": @(_count+1)}];
}

- (void)changeNumber:(NSInteger)n {
    dispatch_async(dispatch_get_main_queue(), ^{
        _count = n;
        [self.label setText:[NSString stringWithFormat:@"%ld", (unsigned long)_count]];
    });
}

- (void)didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    NSNumber* num = [applicationContext objectForKey:@"number"];
    if (num) {
        [self changeNumber:num.integerValue];
    }
}

@end
