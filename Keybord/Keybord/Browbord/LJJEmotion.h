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

/**
 *  构造方法
 *
 *  @param dict 数据字典
 *
 *  @return 当前对象
 */
- (id)initWithDict:(NSDictionary *)dict;
/**
 *  解析数据文件
 *
 *  @param file 文件名
 *
 *  @return 返回解析后的表情对象
 */
+ (NSArray *)emotionsWithFile:(NSString *)file;
/**
 *  解析数据文件
 *
 *  @param file 文件名
 *  @param clipCount 剪裁多少数据     0:返回全部数据
 *
 *  @return 返回解析后的表情对象
 */
+ (NSArray *)emotionsWithFile:(NSString *)file clipCount:(NSInteger)count;
@end
