//
//  ViewController.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/16.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "ViewController.h"

#import "LRRelationViewController.h"
#import "LRTimerViewController.h"

#import "LRUsageBlockViewController.h"
#import "LRUsageDispatchViewController.h"
#import "LRUsageObserverViewController.h"
#import "LRUsageTimerViewController.h"
#import "LRUsageSource0ViewController.h"
#import "LRUsageSource1ViewController.h"

#import "LRExampleRunViewController.h"
#import "LRExampleSwitchViewController.h"
#import "LRExampleRunInActionViewController.h"
#import "LRExampleCustomEventViewController.h"

#import "LREntryModel.h"

typedef NS_ENUM(NSUInteger, SECTIONSDS) {
    SECTION_CONCEPT,
    SECTION_USAGE,
    SECTION_EXAMPLE
};

typedef NS_ENUM(NSUInteger, CELL_IDS) {
    CELL_ID_RELATION,
    CELL_ID_RELATION_TIMER,
    CELL_ID_USAGE_DISPATCH_BLOCK,
    CELL_ID_USAGE_BLOCK,
    CELL_ID_USAGE_OBSERVER,
    CELL_ID_USAGE_TIMER,
    CELL_ID_USAGE_SOURCE0,
    CELL_ID_USAGE_SOURCE1,
    
    CELL_ID_EXAMPLE_RUN,
    CELL_ID_EXAMPLE_SWITCHMODE,
    CELL_ID_EXAMPLE_RUN_ACTION,
    CELL_ID_EXAMPLE_CUSTOM_SWITCH,
};

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<LREntrySectionModel *> *sections;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RunLoop";
    
    [self initTableView];
    [self initTableSection];
}

#pragma mark - init
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)initTableSection {
    NSMutableArray *tempSections = [NSMutableArray array];
    NSMutableArray *tempCells = [NSMutableArray array];
    
    [tempCells removeAllObjects];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_RELATION andTitle:@"Runloop关系" andSubTitle:@"UI相关代码大多由RunLoop发起调用"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_RELATION_TIMER andTitle:@"Timer关系" andSubTitle:@"Timer与RunLoop关系"]];
    
    LREntrySectionModel *sectionModel = [[LREntrySectionModel alloc] initWithSectionId:SECTION_CONCEPT andTitle:@"1. 概念" andCells:[NSArray arrayWithArray:tempCells]];
    [tempSections addObject:sectionModel];
    
    [tempCells removeAllObjects];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_USAGE_BLOCK andTitle:@"Block" andSubTitle:@"添加Block"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_USAGE_DISPATCH_BLOCK andTitle:@"DispatchBlock" andSubTitle:@"向主线程添加Block"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_USAGE_OBSERVER andTitle:@"Observer" andSubTitle:@"添加Observer"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_USAGE_TIMER andTitle:@"Timer" andSubTitle:@"添加Timer"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_USAGE_SOURCE0 andTitle:@"Source0" andSubTitle:@"添加Source0"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_USAGE_SOURCE1 andTitle:@"Source1" andSubTitle:@"添加Source1"]];
    sectionModel = [[LREntrySectionModel alloc] initWithSectionId:SECTION_USAGE andTitle:@"2. 使用" andCells:[NSArray arrayWithArray:tempCells]];
    [tempSections addObject:sectionModel];
    
    [tempCells removeAllObjects];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_EXAMPLE_RUN andTitle:@"CFRunLoopRun" andSubTitle:@"在子线程里面直接调用run方法"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_EXAMPLE_RUN_ACTION andTitle:@"Run in action" andSubTitle:@"在button的响应事件里，调用run方法"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_EXAMPLE_SWITCHMODE andTitle:@"Mode切换" andSubTitle:@"滑动时，Mode的切换过程"]];
    [tempCells addObject:[[LREntryCellModel alloc] initWithCellid:CELL_ID_EXAMPLE_CUSTOM_SWITCH andTitle:@"自定义Mode切换" andSubTitle:@"在自己线程中实现切换"]];
    sectionModel = [[LREntrySectionModel alloc] initWithSectionId:SECTION_USAGE andTitle:@"3. 案例分析" andCells:[NSArray arrayWithArray:tempCells]];
    [tempSections addObject:sectionModel];
    
    _sections = [NSArray arrayWithArray:tempSections];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LREntrySectionModel *s = [_sections objectAtIndex:section];
    return [s.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    LREntrySectionModel *s = [_sections objectAtIndex:indexPath.section];
    LREntryCellModel *c = [s.cells objectAtIndex:indexPath.row];
    
    cell.textLabel.text = c.title;
    cell.detailTextLabel.text = c.subTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LREntrySectionModel *s = [_sections objectAtIndex:indexPath.section];
    LREntryCellModel *c = [s.cells objectAtIndex:indexPath.row];
    
    switch (c.cellId) {
        case CELL_ID_RELATION: {
            LRRelationViewController *relation = [[LRRelationViewController alloc] init];
            [self.navigationController pushViewController:relation animated:YES];
            break;
        }
        case CELL_ID_RELATION_TIMER: {
            LRTimerViewController *timer = [[LRTimerViewController alloc] init];
            [self.navigationController pushViewController:timer animated:YES];
            break;
        }
        case CELL_ID_USAGE_BLOCK: {
            LRUsageBlockViewController *usage = [[LRUsageBlockViewController alloc] init];
            [self.navigationController pushViewController:usage animated:YES];
            break;
        }
        case CELL_ID_USAGE_DISPATCH_BLOCK: {
            LRUsageDispatchViewController *usage = [[LRUsageDispatchViewController alloc] init];
            [self.navigationController pushViewController:usage animated:YES];
            break;
        }
        case CELL_ID_USAGE_OBSERVER: {
            LRUsageObserverViewController *usage = [[LRUsageObserverViewController alloc] init];
            [self.navigationController pushViewController:usage animated:YES];
            break;
        }
        case CELL_ID_USAGE_TIMER: {
            LRUsageTimerViewController *usage = [[LRUsageTimerViewController alloc] init];
            [self.navigationController pushViewController:usage animated:YES];
            break;
        }
        case CELL_ID_USAGE_SOURCE0: {
            LRUsageSource0ViewController *usage = [[LRUsageSource0ViewController alloc] init];
            [self.navigationController pushViewController:usage animated:YES];
            break;
        }
        case CELL_ID_USAGE_SOURCE1: {
            LRUsageSource1ViewController *usage = [[LRUsageSource1ViewController alloc] init];
            [self.navigationController pushViewController:usage animated:YES];
            break;
        }
        case CELL_ID_EXAMPLE_RUN: {
            LRExampleRunViewController *example = [[LRExampleRunViewController alloc] init];
            [self.navigationController pushViewController:example animated:YES];
            break;
        }
        case CELL_ID_EXAMPLE_SWITCHMODE: {
            LRExampleSwitchViewController *example = [[LRExampleSwitchViewController alloc] init];
            [self.navigationController pushViewController:example animated:YES];
            break;
        }
        case CELL_ID_EXAMPLE_RUN_ACTION: {
            LRExampleRunInActionViewController *example = [[LRExampleRunInActionViewController alloc] init];
            [self.navigationController pushViewController:example animated:YES];
            break;
        }
        case CELL_ID_EXAMPLE_CUSTOM_SWITCH: {
            LRExampleCustomEventViewController *example = [[LRExampleCustomEventViewController alloc] init];
            [self.navigationController pushViewController:example animated:YES];
            break;
        }
        default:
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    LREntrySectionModel *s = [_sections objectAtIndex:section];
    return s.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == self.sections.count-1) {
        return @"由于创建线程会强引用target，所以viewController不会被释放";
    }
    return nil;
}

@end
