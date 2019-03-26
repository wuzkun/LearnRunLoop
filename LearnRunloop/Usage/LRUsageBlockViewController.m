//
//  LRUsageBlockViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRUsageBlockViewController.h"

@interface LRUsageBlockViewController ()

@end

@implementation LRUsageBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加Block到Runloop";
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//        NSLog(@"");
//    });
    [self performSelectorOnMainThread:@selector(testSelector) withObject:nil waitUntilDone:NO];
}

- (void)testSelector {
    
}

@end
