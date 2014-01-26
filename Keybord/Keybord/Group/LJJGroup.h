//
//  LJJGroup.h
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJJGroup : NSObject
/**
 *  构造方法
 *
 *  @param icon       图标
 *  @param selectIcon 选中图标
 *
 *  @return 当前对象
 */
- (id)initWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon;
/**
 *  构造方法
 *
 *  @param icon       图标
 *  @param selectIcon 选中图标
 *  @param emotions   图像数据
 *
 *  @return 当前对象
 */
- (id)initWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon emotions:(NSArray *)emotions;

//图片
@property (copy, nonatomic) NSString * icon;
@property (copy, nonatomic) NSString * selectIcon;
//图像数据
@property (strong, nonatomic) NSArray * emotions;

@end
