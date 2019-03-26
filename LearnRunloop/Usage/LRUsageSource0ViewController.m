//
//  LRUsageSource0ViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRUsageSource0ViewController.h"

@interface LRUsageSource0ViewController ()

@property (nonatomic, assign) CFRunLoopSourceRef source0;

@end

void source0Scheduled(void *info, CFRunLoopRef rl, CFRunLoopMode mode);
void source0Cancelled(void *info, CFRunLoopRef rl, CFRunLoopMode mode);
void source0Performed(void *info);

@implementation LRUsageSource0ViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add Source0 To Main Thread";
    
    [self initButtons];
}

#pragma mark - init
- (void)initButtons {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"添加Source0到主线程" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAddSource0Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(40);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *signalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [signalButton setTitle:@"通过Source0发消息" forState:UIControlStateNormal];
    [signalButton addTarget:self action:@selector(buttonSignalSource0Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signalButton];
    
    [signalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - Actions
- (void)buttonAddSource0Clicked:(id)sender {
    if (self.source0) {
        [self removeSource0];
    } else {
        [self addSource0ToMainThread];
    }
}

- (void)buttonSignalSource0Clicked:(id)sender {
    if (self.source0) {
        CFRunLoopSourceSignal(self.source0);
        CFRunLoopWakeUp(CFRunLoopGetCurrent());
    }
}

#pragma mark - Source0
- (void)addSource0ToMainThread {
    CFRunLoopSourceContext context = {
        0,
        (__bridge void *)self,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        source0Scheduled,
        source0Cancelled,
        source0Performed
    };
    CFRunLoopSourceRef rls = CFRunLoopSourceCreate(NULL, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);
    CFRelease(rls);
    self.source0 = rls;
}

- (void)removeSource0 {
    if (self.source0) {
        CFRunLoopRemoveSource(CFRunLoopGetCurrent(), self.source0, kCFRunLoopDefaultMode);
        self.source0 = NULL;
    }
}

void source0Scheduled(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"%@ scheduled", info);
}

void source0Cancelled(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"%@ cancelled", info);
}

void source0Performed(void *info) {
    NSLog(@"%@ Performed", info);
}

@end
