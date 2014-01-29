//
//  LJJBrowItem.m
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//
// 键盘模块
//

#import "LJJBrowItem.h"

#import "LJJEmotion.h"

#import "NSString+Html.h"

#import "LJJBrowButton.h"

const CGFloat LJJBrowItemHeight = 200;

const NSInteger LJJRows = 4;
const NSInteger LJJColumns = 5;
const NSInteger LJJBrowCount = 19;

NSString * const LJJDeleteImageName = @"DeleteEmoticonBtn.png";
NSString * const LJJDeleteImageNameHL = @"DeleteEmoticonBtnHL.png";

@interface LJJBrowItem()
{
    NSArray * _items;
}

@end

@implementation LJJBrowItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置默认按钮
        [self setupItems];
    }
    return self;
}

- (void)setItems {
    for (LJJBrowButton * btn in _items) {
        
        NSInteger row = btn.tag / LJJColumns;
        NSInteger coulmn = btn.tag % LJJColumns;
        
        CGFloat w = self.frame.size.width / LJJColumns -2;
        CGFloat h = self.frame.size.height / LJJRows - 2;
        CGFloat x = coulmn * w + coulmn * 2;
        CGFloat y = row * h + row * 2;
        CGRect frame = CGRectMake(x, y, w, h);
        [btn setFrame:frame];
        
        
        if (btn.tag == LJJBrowCount) {
            [btn setImage:[UIImage imageNamed:LJJDeleteImageName] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:LJJDeleteImageNameHL] forState:UIControlStateHighlighted];
        } else if(self.emotions.count > btn.tag) {
            LJJEmotion * emotion = self.emotions[btn.tag];
            
            NSAssert(emotion.icon != nil, @"模型地址为空");
            NSAssert(emotion.phrase != nil, @"模型解析参数为空");
            
            
            if ([emotion.icon isHttpPath]) {
                [btn setImageUrl:emotion.icon forState:UIControlStateNormal];
            } else {
                [btn setImageName:emotion.icon forState:UIControlStateNormal];
            }
            [btn setHidden:NO];
        } else {
            [btn setHidden:YES];
        }
    }
}

- (void)setupItems {
    int count = LJJRows * LJJColumns;
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:28];
    for (int i = 0; i < count; i++) {
        
        LJJBrowButton * btn = [[LJJBrowButton alloc]init];
        
        
        [btn addTarget:self action:@selector(clickBrow:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        [self addSubview:btn];
        [arrayM addObject:btn];
    }
    _items = arrayM;
}

#pragma mark - 重写私有方法
- (void)setFrame:(CGRect)frame {
    frame.size.height = LJJBrowItemHeight;
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    bounds.size.height = LJJBrowItemHeight;
    [super setBounds:bounds];
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    if (emotions == nil) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
        [self setItems];
    }
}

#pragma mark － 点击事件
- (void)clickBrow:(LJJBrowButton *)btn {
    if (btn.hidden || (_textField == nil && _textView == nil)) return;
    NSMutableString * str = nil;
    
    if (_textField) {
        str = [NSMutableString stringWithString:_textField.text];
    } else {
        str = [NSMutableString stringWithString:_textView.text];
    }
    
    if (btn.tag != 27) {
        LJJEmotion * emotion = self.emotions[btn.tag];
        [str appendFormat:@"%@",emotion.phrase];
    } else {//删除事件
        if (str.length) {
            NSRange range = NSMakeRange(str.length, 0);
            if (range.length == 0 && range.location != 0) {
                NSString * sub = [str substringWithRange:NSMakeRange(range.location - 1, 1)];
                if ([sub isEqualToString:@"]"]) {//是图片
                    NSRange lastRange = [str rangeOfString:@"[" options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
                    
                    range = NSMakeRange(lastRange.location, range.location - lastRange.location);
                    [str deleteCharactersInRange:range];
                } else {//是字符
                    [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
                }
            }
        }
    }
    
    if (_textField) {
        [_textField setText:str];
    } else {
        [_textView setText:str];
    }
    
}

@end
