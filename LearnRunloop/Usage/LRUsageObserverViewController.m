//
//  LRUsageObserverViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRUsageObserverViewController.h"

@interface LRUsageObserverViewController ()
@property (nonatomic, assign) CFRunLoopObserverRef rlo;
@end

void MyCFRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);

@implementation LRUsageObserverViewController

- (void)dealloc {
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.rlo, kCFRunLoopDefaultMode);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加观察";
    
    CFRunLoopObserverContext context = {0, (__bridge void *)self, NULL, NULL, NULL};
    CFRunLoopObserverRef rlo = CFRunLoopObserverCreate(NULL, kCFRunLoopAllActivities, true, 0, MyCFRunLoopObserverCallBack, &context);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), rlo, kCFRunLoopDefaultMode);
    CFRelease(rlo);
    self.rlo = rlo;
}

void MyCFRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}

@end
