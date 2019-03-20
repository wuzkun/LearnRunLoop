//
//  LRCustomViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRCustomViewController.h"

@interface LRCustomViewController ()

@end

@implementation LRCustomViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
