//
//  LJJBrowView.h
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJJBrowView : UIView

@property (strong, nonatomic) NSArray * groups;//分组数据

@property (weak, nonatomic)UITextView * textView;//与textField二选一
@property (weak, nonatomic)UITextField * textField;//与textView二选一

@end
