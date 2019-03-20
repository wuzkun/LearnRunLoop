//
//  LREntryModel.m
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/16.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import "LREntryModel.h"

@implementation LREntryCellModel

- (id)initWithCellid:(NSInteger)cellId andTitle:(NSString *)title andSubTitle:(NSString *)subTitle {
    self = [super init];
    if (self) {
        _cellId = cellId;
        _title = title;
        _subTitle = subTitle;
    }
    return self;
}

@end

@implementation LREntrySectionModel

- (id)initWithSectionId:(NSInteger)sectionId andTitle:(NSString *)title andCells:(NSArray <LREntryCellModel *> *)cells {
    self = [super init];
    if (self) {
        _title = title;
        _sectionId = sectionId;
        _cells = [NSArray arrayWithArray:cells];
    }
    return self;
}

@end
