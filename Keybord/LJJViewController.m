//
//  LJJViewController.m
//  Keybord
//
//  Created by Jun on 14-1-9.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJViewController.h"
#import "LJJKeybord.h"

@interface LJJViewController () <UITextViewDelegate>
{
    LJJTextView * _textView;//输入方
    UIToolbar * _bar;//键盘工具
    
    UITextField * _textField;//用于间接切换键盘的调用方
}
@end

@implementation LJJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTextView]; //添加textView
    
    [self setupBrowView];//添加表情键盘
    
    [self setupToolBar];//添加键盘工具
}
#pragma mark 添加textView
- (void)setupTextView {
    LJJTextView * textView = [[LJJTextView alloc]initWithFrame:CGRectMake(0, 20, 320, 100)];
    //    [textView setEditable:NO];
    [textView setBackgroundColor:[UIColor lightGrayColor]];
    [textView setDelegate:self];
    [self.view addSubview:textView];
    _textView = textView;
    
}

#pragma mark 添加表情键盘
- (void)setupBrowView {
    UITextField * textField = [[UITextField alloc]init];
    [self.view addSubview:textField];
    _textField = textField;
    
    
    NSArray * array = [LJJEmotion emotionsWithFile:[[NSBundle mainBundle] pathForResource:@"emotions.plist" ofType:nil]];
    
    LJJBrowView * brow = [[LJJBrowView alloc]init];
    [brow setTextView:_textView];
    [brow setEmotions:array];
    //    [self.view addSubview:brow];
    [_textField setInputView:brow];
}
#pragma mark 添加键盘工具
- (void)setupToolBar {
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"换" style:UIBarButtonItemStyleDone target:self action:@selector(huan)];
    UIToolbar * bar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [bar setItems:@[item]];
    [_textView setInputAccessoryView:bar];
    [_textField setInputAccessoryView:bar];
}

#pragma mark 点击事件
- (void)huan {
    if (_textField.isFirstResponder) {
        [_textView becomeFirstResponder];
        [_textField resignFirstResponder];
    } else {
        [_textView resignFirstResponder];
        [_textField becomeFirstResponder];
    }
}

@end
