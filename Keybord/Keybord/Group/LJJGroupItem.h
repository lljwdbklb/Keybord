//
//  LJJGroupItem.h
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJJGroup;

@interface LJJGroupItem : UIButton
/**
 *  构造方法
 *
 *  @param icon       图标
 *  @param selectIcon 高亮图标
 *
 *  @return 当前对象
 */
- (id)initWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon;

/**
 *  构造方法
 *
 *  @param title 标题文本
 *
 *  @return 当前对象
 */
- (id)initWithTitle:(NSString *)title;
/**
 *  设置方法
 *
 *  @param icon       图标
 *  @param selectIcon 高亮图标
 */
- (void)setIcon:(NSString *)icon selectIcon:(NSString *)selectIcon;
/**
 *  构造方法
 *
 *  @param group 模型
 *
 *  @return 当前对象
 */
- (id)initWithGroup:(LJJGroup *)group;
@property (nonatomic, strong)LJJGroup * group;
@end
