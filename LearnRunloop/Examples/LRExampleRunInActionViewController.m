//
//  LRExampleRunInActionViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/17.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRExampleRunInActionViewController.h"

@interface LRExampleRunInActionViewController ()
<UITableViewDataSource, UITableViewDelegate>
@end

void myObserverCallBack2(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);

@implementation LRExampleRunInActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Run in Action";
    [self initTableView];
    [self addRunLoopObserver];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Item" style:UIBarButtonItemStyleDone target:self action:@selector(barItemClicked:)];
}

#pragma mark - init
- (void)initTableView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Run" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonRunClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(button.mas_bottom);
    }];
}

- (void)addRunLoopObserver {
    CFRunLoopObserverContext ctx = {0, (__bridge void*)self, NULL, NULL, NULL};
    
    CFRunLoopObserverRef rlo = CFRunLoopObserverCreate(NULL, kCFRunLoopEntry | kCFRunLoopExit, true, 0, myObserverCallBack2, &ctx);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), rlo, kCFRunLoopCommonModes);
    CFRelease(rlo);
}

#pragma mark - Actions
- (void)buttonRunClicked:(id)sender {
    NSLog(@"Before run");
    CFRunLoopRun();
//    CFRunLoopRunInMode((CFRunLoopMode)UITrackingRunLoopMode, 0, NO);
    NSLog(@"After run");
}

- (void)barItemClicked:(id)sender {
    NSLog(@"BarItemClicked");
    NSLog(@"%@", [NSThread callStackSymbols]);
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
void myObserverCallBack2(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
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
