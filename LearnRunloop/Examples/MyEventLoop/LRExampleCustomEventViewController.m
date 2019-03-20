//
//  LRExampleCustomEventViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/19.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRExampleCustomEventViewController.h"
#import "MyEventModel.h"

typedef NS_ENUM(NSUInteger, BUTTON_IDS) {
    BUTTON_ID_START,
    BUTTON_ID_SWITCH_TRACKINGMODE,
    BUTTON_ID_SWITCH_MYMODE,
    BUTTON_ID_END_MODE,
};

#define MY_MODE_NAME    @"MyMode"

@interface LRExampleCustomEventViewController ()

@property (nonatomic, assign) CFRunLoopRef subThreadRl;
@property (nonatomic, assign) CFRunLoopSourceRef subThreadSource0;

@property (nonatomic, strong) NSString *targetMode;

@end

@implementation LRExampleCustomEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initButtons];
}

#pragma mark - init views
- (void)initButtons {
    NSArray *titles = @[@"开启线程", @"切换到UITrackingMode", @"切换到MyMode", @"结束当前mode"];
    NSArray *buttonIds = @[@(BUTTON_ID_START), @(BUTTON_ID_SWITCH_TRACKINGMODE), @(BUTTON_ID_SWITCH_MYMODE), @(BUTTON_ID_END_MODE)];
    
    UIButton *tempButton = nil;
    for (NSInteger i=0; i<[titles count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = [[buttonIds objectAtIndex:i] integerValue];
        [self.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempButton) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(40);
            } else {
                make.top.equalTo(tempButton.mas_bottom).offset(30);
            }
            make.centerX.equalTo(self.view);
        }];
        tempButton = button;
    }
}

#pragma mark - Actions
- (void)buttonClicked:(UIButton *)button {
    switch (button.tag) {
        case BUTTON_ID_START: {
            button.enabled = NO;
            [self createSubThread];
            break;
        }
        case BUTTON_ID_SWITCH_TRACKINGMODE: {
            self.targetMode = UITrackingRunLoopMode;
            CFRunLoopSourceSignal(self.subThreadSource0);
            CFRunLoopWakeUp(self.subThreadRl);
            break;
        }
        case BUTTON_ID_SWITCH_MYMODE: {
            self.targetMode = MY_MODE_NAME;
            CFRunLoopSourceSignal(self.subThreadSource0);
            CFRunLoopWakeUp(self.subThreadRl);
            break;
        }
        case BUTTON_ID_END_MODE: {
            self.targetMode = nil;
            CFRunLoopSourceSignal(self.subThreadSource0);
            CFRunLoopWakeUp(self.subThreadRl);
            break;
        }
        default:
            break;
    }
}

#pragma mark - 开启线程
- (void)createSubThread {
    LRCustomThread *thread = [[LRCustomThread alloc] initWithTarget:self selector:@selector(threadFunc) object:nil];
    [thread start];
}

- (void)threadFunc {
    CFRunLoopSourceContext ctx = {0, (__bridge void *)self, NULL, NULL, NULL, NULL, NULL, myThreadSchedule, myThreadCancel, myThreadPerform};
    CFRunLoopSourceRef rls = CFRunLoopSourceCreate(NULL, 0, &ctx);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopCommonModes);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, (CFRunLoopMode)UITrackingRunLoopMode);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, (CFRunLoopMode)MY_MODE_NAME);
    CFRelease(rls);
    self.subThreadSource0 = rls;
    self.subThreadRl = CFRunLoopGetCurrent();
    
    CFRunLoopObserverContext rloContext = {0, NULL, NULL, NULL, NULL};
    CFRunLoopObserverRef rlo = CFRunLoopObserverCreate(NULL, kCFRunLoopAllActivities, true, 0, eventCFRunLoopObserverCallBack, &rloContext);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), rlo, kCFRunLoopCommonModes);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), rlo, (CFRunLoopMode)UITrackingRunLoopMode);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), rlo, (CFRunLoopMode)MY_MODE_NAME);
    
    myGSEventPushRunLoopMode(NSDefaultRunLoopMode);
    myGSEventRunModal();
}

void myThreadSchedule(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    
}

void myThreadCancel(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    
}

void myThreadPerform(void *info) {
    LRExampleCustomEventViewController *controller = (__bridge LRExampleCustomEventViewController *)info;
    
    if (controller.targetMode) {
        myGSEventPushRunLoopMode(controller.targetMode);
    } else {
        myGSEventPopRunLoopMode();
    }
}

void eventCFRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"Entry: %@", CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()));
            break;
        case kCFRunLoopExit:
            NSLog(@"Exit: %@", CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()));
            break;
        default:
            break;
    }
}

@end
