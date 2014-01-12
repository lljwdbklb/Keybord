//
//  LJJBrowItem.h
//  Keybord
//
//  Created by Jun on 14-1-9.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat LJJBrowItemHeight;

extern const NSInteger LJJBrowCount;

@interface LJJBrowItem : UIView
@property (strong, nonatomic)NSArray * emotions;

@property (weak, nonatomic)UITextView * textView;
@property (weak, nonatomic)UITextField * textField;
@end
