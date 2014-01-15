//
//  LJJBrowView.h
//  企信通
//
//  Created by Jun on 13-12-6.
//  Copyright (c) 2013年 Jun. All rights reserved.
//
//  表情键盘
//

#import <UIKit/UIKit.h>

@interface LJJBrowView : UIView

@property (strong, nonatomic)NSArray * emotions; //添加表情对象数据，必填

@property (weak, nonatomic)UITextView * textView;//与textField二选一
@property (weak, nonatomic)UITextField * textField;//与textView二选一

@end
