//
//  LJJEmotion.m
//  WBLJJ
//
//  Created by Jun on 14-1-9.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJEmotion.h"

@implementation LJJEmotion
- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _icon = dict[@"icon"];
        _phrase = dict[@"phrase"];
    }
    return self;
}

#pragma mark 归档设置
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.phrase = [aDecoder decodeObjectForKey:@"phrase"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.phrase forKey:@"phrase"];
}

- (id)copyWithZone:(NSZone *)zone {
    LJJEmotion * emotion = [[[self class] allocWithZone:zone]init];
    emotion.icon = [self.icon copyWithZone:zone];
    emotion.phrase = [self.phrase copyWithZone:zone];
    return emotion;
}

#pragma mark 表情读取
+ (NSArray *)emotionsWithFile:(NSString *)file {
    NSMutableArray * arrayM = [NSMutableArray array];
    
    NSArray * array = [NSArray arrayWithContentsOfFile:file];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LJJEmotion * emotion = [[LJJEmotion alloc]initWithDict:obj];
        [arrayM addObject:emotion];
    }];
    
    return arrayM;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<LJJEmotion: %p, icon: %@, phrase: %@>",self,self.icon,self.phrase];
}
@end
