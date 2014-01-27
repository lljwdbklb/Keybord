//
//  LJJGroup.m
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJGroup.h"

@implementation LJJGroup
- (id)initWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon emotions:(NSArray *)emotions {
    if (self = [super init]) {
        self.icon = icon;
        self.selectIcon = selectIcon;
        self.emotions = emotions;
    }
    return self;
}
- (id)initWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon {
    return [self initWithIcon:icon selectIcon:selectIcon emotions:nil];
}
- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title emotions:nil];
}
- (id)initWithTitle:(NSString *)title emotions:(NSArray *)emotions {
    if (self = [super init]) {
        self.title = title;
        self.emotions = emotions;
    }
    return self;
}
@end
