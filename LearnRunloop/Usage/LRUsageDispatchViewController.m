//
//  LRUsageDispatchViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRUsageDispatchViewController.h"

@interface LRUsageDispatchViewController ()

@end

@implementation LRUsageDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Dispatch block";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}
@end
