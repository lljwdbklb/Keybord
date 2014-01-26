//
//  LJJGroupItem.m
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJGroupItem.h"

@implementation LJJGroupItem

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (id)initWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon {
    if (self = [self init]) {
        [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted { }

@end