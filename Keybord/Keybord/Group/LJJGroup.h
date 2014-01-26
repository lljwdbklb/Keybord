//
//  LJJGroup.h
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJJGroup : NSObject

//图片
@property (copy, nonatomic) NSString * icon;
@property (copy, nonatomic) NSString * selectIcon;
//图像数据
@property (strong, nonatomic) NSArray * emotions;

@end
