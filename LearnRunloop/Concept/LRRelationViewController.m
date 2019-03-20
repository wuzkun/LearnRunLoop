//
//  LRRelationViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/16.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LRRelationViewController.h"
#import "LRDemoView.h"

typedef NS_ENUM(NSUInteger, BUTTON_IDS) {
    BUTTON_ID_TIMER,
    BUTTON_ID_DISPATCH_MAIN,
    BUTTON_ID_LAYOUT,
};


@interface LRRelationViewController ()
@property (nonatomic, strong) LRDemoView *demoView;
@end

@implementation LRRelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看调用堆栈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _demoView = [[LRDemoView alloc] init];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    [_demoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self initButtons];
    
}

#pragma mark - init
- (void)initButtons {
    NSArray *titles = @[@"Timer", @"Layout", @"Dispatch Main"];
    NSArray *buttonIds = @[@(BUTTON_ID_TIMER), @(BUTTON_ID_LAYOUT), @(BUTTON_ID_DISPATCH_MAIN)];
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - Actions
- (void)buttonClicked:(UIButton *)button {
    NSInteger tag = [button tag];
    switch (tag) {
        case BUTTON_ID_TIMER: {
            [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
                
            }];
        }
            break;
        case BUTTON_ID_LAYOUT: {
            [_demoView setNeedsLayout];
            break;
        }
        case BUTTON_ID_DISPATCH_MAIN: {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            break;
        }
        default:
            break;
    }
}

@end
