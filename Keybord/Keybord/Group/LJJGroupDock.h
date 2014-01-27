//
//  LJJGroupDock.h
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJJGroupDock;
@class LJJGroup;

@protocol LJJGroupDockDelegate <NSObject>
@optional
/**
 *  dock点击代理
 *
 *  @param dock 当前dock
 *  @param from 选择前dockItem的选择
 *  @param to   当前选中dockItem的选择
 */
- (void)dock:(LJJGroupDock *)dock didSeletedItemFrom:(NSInteger)from to:(NSInteger)to;
@end

extern const CGFloat LJJGroupDockWidth;

@interface LJJGroupDock : UIView

@property (weak, nonatomic) id<LJJGroupDockDelegate> delegate;
/**
 *  添加一个GroupItem
 *
 *  @param icon item图片
 */
- (void)addGroupItemWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon;
/**
 *  添加一个GroupItem
 *
 *  @param title item文本
 */
- (void)addGroupItemWithTitle:(NSString *)title;

- (void)addGroupItemWithGroup:(LJJGroup *)group;

@end
