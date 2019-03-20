//
//  LRUsageTimerViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRUsageTimerViewController.h"

@interface LRUsageTimerViewController ()

@property (nonatomic, assign) CFRunLoopTimerRef rlt;

@end

void MyTimerCallBack(CFRunLoopTimerRef timer, void *info);

@implementation LRUsageTimerViewController

- (void)dealloc {
    if (self.rlt) {
        [self stopTheTimer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add Timer In Thread";
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"点击屏幕开始或停止"];
    label.textColor = [UIColor colorWithWhite:0.2 alpha:1];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.rlt) {
        [self stopTheTimer];
    } else {
        [self addTimer];
    }
}

- (void)addTimer {
    CFRunLoopTimerContext context = {0, (__bridge void*)self, NULL, NULL, NULL};

    CFRunLoopTimerRef rlt = CFRunLoopTimerCreate(NULL, 0, 1, 0, 0, MyTimerCallBack, &context);
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), rlt, kCFRunLoopDefaultMode);
    CFRelease(rlt);
    self.rlt = rlt;
}

void MyTimerCallBack(CFRunLoopTimerRef timer, void *info) {
    NSLog(@"%@ Timer", info);
}

- (void)stopTheTimer {
    CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), self.rlt, kCFRunLoopDefaultMode);
    self.rlt = NULL;
}

@end
