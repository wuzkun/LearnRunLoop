//
//  LRExampleRunViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRExampleRunViewController.h"

@interface LRExampleRunViewController ()

@end

@implementation LRExampleRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Empty Run";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LRCustomThread *thread = [[LRCustomThread alloc] initWithBlock:^{
        NSLog(@"Before Run");
//        while (1) {
//            CFRunLoopRun();
//        }
        CFRunLoopRun();
        NSLog(@"After Run");
    }];
    [thread start];
}

//int64 GSEventPushRunLoopMode(CFStringRef mode) {
//
//    long count = CFArrayGetCount(__runLoopModeStack);
//    CFArrayAppendValue(__runLoopModeStack, count);
//    return CFRunLoopStop(__eventRunLoop);
//}
//
//
//void _GSEventPopRunLoopMode(int arg0) {
//    CFArrayRemoveValueAtIndex(__runLoopModeStack, CFArrayGetCount(__runLoopModeStack));
//    CFRunLoopStop(__eventRunLoop);
//    return;
//}
//
//
//__int64 __fastcall GSEventPushRunLoopMode(__int64 a1)
//{
//    __int64 v1; // rbx
//    __int64 v2; // rdi
//    __int64 v3; // rax
//
//    v1 = a1;
//    v2 = __runLoopModeStack;
//    if ( !__runLoopModeStack )
//    {
//        v2 = CFArrayCreateMutable(0LL, 0LL, &kCFTypeArrayCallBacks);
//        __runLoopModeStack = v2;
//    }
//    v3 = CFArrayGetCount(v2);
//    GSEventLogRunLoopEventStartTime(v1, v3);
//    CFArrayAppendValue(__runLoopModeStack, v1);
//    return CFRunLoopStop(__eventRunLoop);
//}

//char __fastcall GSEventRunModal(char a1)
//{
//    __int64 v1; // rax
//    __int64 v2; // rax
//    char result; // al
//    __int64 v4; // rbx
//    __int64 v5; // rax
//    __int64 v6; // rbx
//
//    while ( 1 )
//    {
//        if ( a1 )
//        {
//            result = __exitRunModal;
//            if ( __exitRunModal )
//                break;
//        }
//        if ( !__runLoopModeStack
//            || ((__int64 (*)(void))CFArrayGetCount)() <= 0
//            || (v4 = __runLoopModeStack,
//                v5 = CFArrayGetCount(__runLoopModeStack),
//                (v6 = CFArrayGetValueAtIndex(v4, v5 - 1)) == 0) )
//        {
//            result = fprintf(__stderrp, "%s: NULL run loop mode. Exiting loop\n", "GSEventRunModal");
//            break;
//        }
//        if ( __timeEventHandling )
//        {
//            v1 = CFRunLoopGetCurrent();
//            CFRunLoopAddObserver(v1, timingObserver, v6);
//        }
//        CFRunLoopRunInMode(v6, 0LL);
//        if ( __timeEventHandling )
//        {
//            v2 = CFRunLoopGetCurrent();
//            CFRunLoopRemoveObserver(v2, timingObserver, v6);
//        }
//    }
//    __exitRunModal = 0;
//    return result;
//}

@end
