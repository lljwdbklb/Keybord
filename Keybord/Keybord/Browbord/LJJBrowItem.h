//
//  LJJBrowItem.h
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>
extern const CGFloat LJJBrowItemHeight;
extern const NSInteger LJJBrowCount;

@interface LJJBrowItem : UIView

@property (strong, nonatomic)NSArray * emotions; //添加表情对象数据，必填

@property (weak, nonatomic)UITextView * textView;//与textField二选一
@property (weak, nonatomic)UITextField * textField;//与textView二选一

@end
