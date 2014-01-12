//
//  LJJBrowItem.m
//  Keybord
//
//  Created by Jun on 14-1-9.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJBrowItem.h"

#import "LJJEmotion.h"

#import "NSString+Html.h"

const CGFloat LJJBrowItemHeight = 200;
const NSInteger LJJBrowCount = 27;

NSString * const LJJDeleteImageName = @"DeleteEmoticonBtn";
NSString * const LJJDeleteImageNameHL = @"DeleteEmoticonBtnHL";
#define kAnimatedTimer  0.25
#define kRows           4
#define kColumns        7

#define kPointStart     CGPointMake(10, 10)

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
        [self setupBtns];
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    [self setItems];
}

- (void)setItems {
    for (UIButton * btn in _items) {
        if (btn.tag == LJJBrowCount) {
            [btn setImage:[UIImage imageNamed:LJJDeleteImageName] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:LJJDeleteImageNameHL] forState:UIControlStateHighlighted];
        } else {
            LJJEmotion * emotion = self.emotions[btn.tag];
            NSAssert(emotion.icon != nil, @"模型地址为空");
            NSAssert(emotion.phrase != nil, @"模型解析参数为空");
            UIImage * image = nil;
            if ([emotion.icon isHttpPath]) {
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:emotion.icon]];
                image = [UIImage imageWithData:data];
            } else {
                image = [UIImage imageNamed:emotion.icon];
            }
            [btn setImage:image forState:UIControlStateNormal];
        }
    }
}

- (void)setupBtns {
    int count = kRows * kColumns;
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:28];
    for (int i = 0; i < count; i++) {
        NSInteger row = i % kRows;
        NSInteger coulmn = i % kColumns;
        
        CGFloat w = (self.frame.size.width - kPointStart.x * 2) / kColumns;
        CGFloat h = (self.frame.size.height - kPointStart.y * 2) / kRows;
        CGFloat x = kPointStart.x + coulmn * w;
        CGFloat y = kPointStart.y + row * h;
        CGRect frame = CGRectMake(x, y, w, h);
        
        UIButton * btn = [[UIButton alloc]initWithFrame:frame];
        [btn addTarget:self action:@selector(clickBrow:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        [self addSubview:btn];
        [arrayM addObject:btn];
    }
    _items = arrayM;
}

- (void)setFrame:(CGRect)frame {
    frame.size.width = [UIScreen mainScreen].applicationFrame.size.width;
    frame.size.height = LJJBrowItemHeight;
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    bounds.size.width = [UIScreen mainScreen].applicationFrame.size.width;
    bounds.size.height = LJJBrowItemHeight;
    [super setBounds:bounds];
}
//NSParagraphStyle
#pragma mark 点击事件
- (void)clickBrow:(UIButton *)btn {
//    if (_textField == nil || _textView == nil) return;
//    NSLog(@"%d",btn.tag);
    if (btn.tag != LJJBrowCount && btn.tag > _emotions.count) return;
    NSMutableString * str = nil;
    
    if (_textField) {
        str = [NSMutableString stringWithString:_textField.text];
    } else {
        str = [NSMutableString stringWithString:_textView.text];
    }
    
    if (btn.tag != 27) {
        LJJEmotion * emotion = self.emotions[btn.tag];
        [str appendFormat:@"%@",emotion.phrase];
    } else {
        if (str.length) {
            NSRange range = NSMakeRange(str.length, 0);
            if (range.length == 0 && range.location != 0) {
                NSString * sub = [str substringWithRange:NSMakeRange(range.location - 1, 1)];
                if ([sub isEqualToString:@"]"]) {
                    NSRange lastRange = [str rangeOfString:@"[" options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
                    
                    range = NSMakeRange(lastRange.location, range.location - lastRange.location);
                    [str deleteCharactersInRange:range];
                }else {
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

/*
 if (_textView) {
 NSMutableString * str = [NSMutableString stringWithString:[_textView text]];
 if (btn.tag != LJJBrowCount) {
 LJJEmotion * emotion = self.emotions[btn.tag];
 [str appendFormat:@"%@",emotion.phrase];
 } else {
 if (str.length) {
 
 NSRange range = NSMakeRange(str.length, 0);
 if (range.length == 0 && range.location != 0) {
 NSString * sub = [str substringWithRange:NSMakeRange(range.location - 1, 1)];
 if ([sub isEqualToString:@"]"]) {
 NSRange lastRange = [str rangeOfString:@"[" options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
 
 range = NSMakeRange(lastRange.location, range.location - lastRange.location);
 [str deleteCharactersInRange:range];
 }else {
 [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
 }
 }
 
 }
 }
 [_textView setText:str];
 } else {
 NSMutableString * str = [NSMutableString stringWithString:[_textField text]];
 if (btn.tag != 27) {
 LJJEmotion * emotion = self.emotions[btn.tag];
 [str appendFormat:@"%@",emotion.phrase];
 } else {
 if (str.length) {
 NSRange range = NSMakeRange(str.length, 0);
 if (range.length == 0 && range.location != 0) {
 NSString * sub = [str substringWithRange:NSMakeRange(range.location - 1, 1)];
 if ([sub isEqualToString:@"]"]) {
 NSRange lastRange = [str rangeOfString:@"[" options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
 
 range = NSMakeRange(lastRange.location, range.location - lastRange.location);
 [str deleteCharactersInRange:range];
 }else {
 [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
 }
 }
 }
 }
 [_textField setText:str];
 }
 */
@end
