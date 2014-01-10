//
//  LJJBrowView.h
//  企信通
//
//  Created by Jun on 13-12-6.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJJBrowViewDelegate <NSObject>

- (void)browChangeAtFrame:(CGRect)frame animatedTimer:(NSTimeInterval)animatedTimer;

@end

@interface LJJBrowView : UIView

@property (weak, nonatomic)id <LJJBrowViewDelegate>delegate;

@property (assign, nonatomic, readonly) BOOL isShow;

//- (id)initWithInputText:(UIView<UITextInput> *)textView;

@property (strong, nonatomic)NSArray * emotions;

@property (weak, nonatomic)UITextView * textView;
@property (weak, nonatomic)UITextField * textField;

- (void)show;
- (void)hide;


@end
