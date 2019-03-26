//
//  LRTimerViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/25.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRTimerViewController.h"

@interface LRTimerViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger count1;
@property (nonatomic, assign) NSInteger count2;
@property (nonatomic, assign) NSInteger count3;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;

@end

@implementation LRTimerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.count1 ++;
        self.label1.text = [NSString stringWithFormat:@"DefaultMode: %d", (int)self.count1];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
    
    NSTimer *timer2 = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.count2 ++;
        self.label2.text = [NSString stringWithFormat:@"UITrackingMode: %d", (int)self.count2];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:UITrackingRunLoopMode];

    
    NSTimer *timer3 = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.count3 ++;
        self.label3.text = [NSString stringWithFormat:@"CommonModes: %d", (int)self.count3];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer3 forMode:NSRunLoopCommonModes];
}

#pragma mark - init
- (void)initViews {
    UILabel *label1 = [[UILabel alloc] init];
    [self.view addSubview:label1];
    self.label1 = label1;
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_topMargin);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    [self.view addSubview:label2];
    self.label2 = label2;
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label1);
        make.top.equalTo(self.label1.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    [self.view addSubview:label3];
    self.label3 = label3;
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label1);
        make.top.equalTo(self.label2.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(label3.mas_bottom).offset(10);
    }];
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


@end
