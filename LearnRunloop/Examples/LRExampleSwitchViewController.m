//
//  LRExampleSwitchViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRExampleSwitchViewController.h"

@interface LRExampleSwitchViewController ()
<UITableViewDataSource, UITableViewDelegate>
@end

void myObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);

@implementation LRExampleSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Mode切换";
    [self initTableView];
    [self addRunLoopObserver];
}

#pragma mark - init
- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)addRunLoopObserver {
    CFRunLoopObserverContext ctx = {0, (__bridge void*)self, NULL, NULL, NULL};
    
    CFRunLoopObserverRef rlo = CFRunLoopObserverCreate(NULL, kCFRunLoopEntry | kCFRunLoopExit, true, 0, myObserverCallBack, &ctx);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), rlo, kCFRunLoopCommonModes);
    CFRelease(rlo);
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Observer
void myObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
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
