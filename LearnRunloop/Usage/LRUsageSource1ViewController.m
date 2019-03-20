//
//  LRUsageSource1ViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRUsageSource1ViewController.h"
#import <objc/message.h>

@interface LRUsageSource1ViewController ()
<NSPortDelegate>

@property (nonatomic, strong) LRCustomThread *subThread;

@property (nonatomic, strong) NSPort *mainThreadPort;

@property (nonatomic, strong) NSPort *subThreadPort;

@end

@implementation LRUsageSource1ViewController

- (void)dealloc {
    if (self.mainThreadPort) {
        [self.mainThreadPort removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    if (self.subThreadPort) {
        [self performSelector:@selector(removeSubPort:) onThread:self.subThread withObject:self.subThreadPort waitUntilDone:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Source1 To Thread";
    
    [self initButtons];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}

#pragma mark - init
- (void)initButtons {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"添加Port到主线程" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAddPortToMainThreadClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(40);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *subButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [subButton setTitle:@"创建子线程并添加Port" forState:UIControlStateNormal];
    [subButton addTarget:self action:@selector(buttonCreateChildThreadClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    
    [subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendButton setTitle:@"向子线程发送消息" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(buttonSendMessageToSubPortClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subButton.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - Actions
- (void)buttonAddPortToMainThreadClicked:(id)sender {
    if (self.mainThreadPort) {
        return;
    }
    NSPort *port = [NSPort port];
    port.delegate = self;
    self.mainThreadPort = port;
    
    [port scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)buttonCreateChildThreadClicked:(id)sender {
    if (self.subThread) {
        return;
    }
    self.subThread = [[LRCustomThread alloc] initWithTarget:self selector:@selector(createSubThead) object:nil];
    self.subThread.name = @"Sub Thread";
    [self.subThread start];
}

- (void)buttonSendMessageToSubPortClicked:(id)sender {
    NSMutableArray *components = [NSMutableArray array];
    [components addObject:[@"Hello" dataUsingEncoding:NSUTF8StringEncoding]];
    [self.subThreadPort sendBeforeDate:[NSDate distantFuture] components:components from:self.mainThreadPort reserved:0];
}

#pragma mark -
- (void)createSubThead {
    NSPort *port = [NSPort port];
    port.delegate = self;
    self.subThreadPort = port;
    
    [port scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    CFRunLoopRun();
}

- (void)removeSubPort:(NSPort *)port {
    [port removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
    [NSThread exit];
}

#pragma mark - NSPortDelegate
- (void)handlePortMessage:(id)message {
    NSLog(@"Thread: %@, %@", [NSThread currentThread], message);
    
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([message class], &count);
//    for (NSInteger i = 0; i < count; i++) {
//        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
//        NSLog(@"%@",name);
//    }
    NSArray *components = [message valueForKey:@"components"];
    if ([components isKindOfClass:[NSArray class]]) {
        for (NSData *data in components) {
            if ([data isKindOfClass:[NSData class]]) {
                NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            }
        }
    }
}

@end
