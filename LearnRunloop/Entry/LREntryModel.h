//
//  LREntryModel.h
//  LearnRunloop
//
//  Created by zhikun wu on 2019/3/16.
//  Copyright © 2019 zhikun wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LREntryCellModel : NSObject

@property (nonatomic, assign) NSInteger cellId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

- (id)initWithCellid:(NSInteger)cellId andTitle:(NSString *)title andSubTitle:(NSString *)subTitle;

@end

@interface LREntrySectionModel : NSObject

@property (nonatomic, assign) NSInteger sectionId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray <LREntryCellModel *> *cells;

- (id)initWithSectionId:(NSInteger)sectionId andTitle:(NSString *)title andCells:(NSArray <LREntryCellModel *> *)cells;

@end


NS_ASSUME_NONNULL_END
