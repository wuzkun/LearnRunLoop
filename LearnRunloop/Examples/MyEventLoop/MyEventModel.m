//
//  MyEventModel.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/19.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "MyEventModel.h"

CFRunLoopRef staticRunLoop;

NSMutableArray <NSString *> *modeStack;


void myGSEventRunModal(void) {
    CFRunLoopRef rl = CFRunLoopGetCurrent();
    if (staticRunLoop == NULL) {
        staticRunLoop = rl;
        modeStack = [NSMutableArray array];
    } else if (staticRunLoop != rl) {
        return;
    }
    while (1) {
        if (modeStack.count == 0) {
            break;
        }
        NSString *mode = [modeStack lastObject];
        CFRunLoopRunInMode((CFRunLoopMode)mode, INT_MAX, NO);
    }
}

void myGSEventPushRunLoopMode(NSString *mode) {
    CFRunLoopRef rl = CFRunLoopGetCurrent();
    if (staticRunLoop == NULL) {
        staticRunLoop = rl;
        modeStack = [NSMutableArray array];
    } else if (staticRunLoop != rl) {
        return;
    }
    [modeStack addObject:mode];
    CFRunLoopStop(rl);
}

void myGSEventPopRunLoopMode(void) {
    CFRunLoopRef rl = CFRunLoopGetCurrent();
    if (staticRunLoop == NULL) {
        staticRunLoop = rl;
        modeStack = [NSMutableArray array];
    } else if (staticRunLoop != rl) {
        return;
    }
    [modeStack removeObjectAtIndex:[modeStack count] - 1];
    CFRunLoopStop(rl);
}
