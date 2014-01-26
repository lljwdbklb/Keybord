//
//  LJJGroupDock.m
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJGroupDock.h"

#import "LJJGroupItem.h"

const CGFloat LJJGroupDockWidth = 30;

@interface LJJGroupDock()
{
    LJJGroupItem * _selectedItem;
    
    NSMutableArray * _items;
}

@end

@implementation LJJGroupDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setBackgroundColor:[UIColor redColor]];
        _items = [NSMutableArray array];
    }
    return self;
}

#pragma mark 重写方法
- (void)setFrame:(CGRect)frame {
    frame.size.width = LJJGroupDockWidth;
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    bounds.size.width = LJJGroupDockWidth;
    [super setBounds:bounds];
}

#pragma mark 添加一个GroupItem
- (void)addGroupItemWithIcon:(NSString *)icon {
    LJJGroupItem * item = [[LJJGroupItem alloc]init];
    
    //设置
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //设置颜色
    [item setBackgroundColor:[UIColor grayColor]];
    
    NSInteger count = self.subviews.count;
    [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchDown];
    [item setTag:count];
    [self addSubview:item];
    [_items addObject:item];
    
    if (count == 0) { //默认第一个按钮进行点击
        [self clickItem:item];
    }
    
    for (LJJGroupItem * view in _items) {
        //设置尺寸
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height / self.subviews.count;
        CGFloat x = 0;
        CGFloat y = view.tag * h;
        [view setFrame:CGRectMake(x, y, w, h)];
    }
    [self setNeedsDisplay];
}

#pragma mark 点击事件
- (void)clickItem:(LJJGroupItem *)item {
    //代理调用点击事件
    if ([self.delegate respondsToSelector:@selector(dock:didSeletedItemFrom:to:)]) {
        [self.delegate dock:self didSeletedItemFrom:_selectedItem.tag to:item.tag];
    }
    
    //更换背景颜色
    [_selectedItem setBackgroundColor:[UIColor grayColor]];
    [item setBackgroundColor:[UIColor clearColor]];
    
    
    //三件套
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
}
@end
