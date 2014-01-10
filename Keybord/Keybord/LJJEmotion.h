//
//  LJJEmotion.h
//  WBLJJ
//
//  Created by Jun on 14-1-9.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * category string  图片分类
 * common   bool    是否常见
 * hot      bool    是否热门
 * icon     string  图片地址
 * phrase   string  解析参数（文本替换参数）
 * picid    string  图片偏好
 * type     string  图片类型
 * url      string  图片地址
 * value    string  图片值
 */
@interface LJJEmotion : NSObject <NSCoding,NSCopying>

@property (copy, nonatomic) NSString * icon;
@property (copy, nonatomic) NSString * phrase;

- (id)initWithDict:(NSDictionary *)dict;

+ (NSArray *)emotionsWithFile:(NSString *)file;
@end
