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

//@protocol LJJBrowViewDelegate <NSObject>
//
//- (void)browChangeAtFrame:(CGRect)frame animatedTimer:(NSTimeInterval)animatedTimer;
//
//@end

@interface LJJBrowView : UIView

//@property (weak, nonatomic)id <LJJBrowViewDelegate>delegate;

//@property (assign, nonatomic, readonly) BOOL isShow;

//- (id)initWithInputText:(UIView<UITextInput> *)textView;

@property (strong, nonatomic)NSArray * emotions; //添加表情对象数据，必填

@property (weak, nonatomic)UITextView * textView;//与textField二选一
@property (weak, nonatomic)UITextField * textField;//与textView二选一


//- (void)show;
//- (void)hide;


@end
