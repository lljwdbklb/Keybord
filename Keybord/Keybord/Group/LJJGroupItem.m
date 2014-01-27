//
//  LJJGroupItem.m
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJGroupItem.h"
#import "LJJGroup.h"

const CGFloat scale = 0.3;

@implementation LJJGroupItem

#pragma mark - 构造方法
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return self;
}

- (id)initWithIcon:(NSString *)icon selectIcon:(NSString *)selectIcon {
    if (self = [self init]) {
        [self setIcon:icon selectIcon:selectIcon];
    }
    return self;
}
- (id)initWithTitle:(NSString *)title {
    if (self = [self init]) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithGroup:(LJJGroup *)group {
    if (self = [self init]) {
        [self setGroup:group];
    }
    return self;
}

#pragma mark - 重写方法
- (void)setGroup:(LJJGroup *)group {
    _group = group;
    
    [self setIcon:group.icon selectIcon:group.selectIcon];
    [self setTitle:group.title forState:UIControlStateNormal];
    [self setNeedsDisplay];
}
- (void)setIcon:(NSString *)icon selectIcon:(NSString *)selectIcon {
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
}
- (void)setHighlighted:(BOOL)highlighted { }

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.group.icon == nil) {
        return CGRectZero;
    } else if (self.group.title != nil && ![self.group.title isEqualToString:@""]) {
        return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * scale);
    }
    return contentRect;
}	

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (self.group.title == nil || [self.group.title isEqualToString:@""]) {
        return CGRectZero;
    } else if (self.group.icon != nil) {
        CGFloat y = contentRect.size.height * scale;
        CGFloat h = contentRect.size.height - y;
        return CGRectMake(0, y, contentRect.size.width, h);
    }
    return contentRect;
}

@end
