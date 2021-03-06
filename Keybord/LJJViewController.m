//
//  LJJViewController.m
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
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
- (void)setupTextView {
    LJJTextView * textView = [[LJJTextView alloc]initWithFrame:CGRectMake(0, 20, 320, 100)];
    //    [textView setEditable:NO];
    [textView setBackgroundColor:[UIColor lightGrayColor]];
    [textView setDelegate:self];
    [self.view addSubview:textView];
    _textView = textView;
    
}

- (void)setupBrowView {
    UITextField * textField = [[UITextField alloc]init];
    [self.view addSubview:textField];
    _textField = textField;
    
    NSArray * array = [LJJEmotion emotionsWithFile:[[NSBundle mainBundle]pathForResource:@"emotions1.plist" ofType:nil]];
//    NSArray * array2 = [LJJEmotion emotionsWithFile:[[NSBundle mainBundle]pathForResource:@"emotions2.plist" ofType:nil]];
    NSArray * array3 = [LJJEmotion emotionsWithFile:[[NSBundle mainBundle]pathForResource:@"emotions3.plist" ofType:nil]];
    
    //第一组数据
    LJJGroup * group = [[LJJGroup alloc]init];
//    group.icon = @"tabbar_home";
    group.title = @"哈哈哈";
    group.emotions = array;
    
    //第二组数据
//    LJJGroup * group2 = [[LJJGroup alloc]init];
////    group2.icon = @"tabbar_discover";
//    group2.title = @"嘻嘻嘻";
//    group2.emotions = array2;
//    
    //第三组数据
    LJJGroup * group3 = [[LJJGroup alloc]init];
//    group3.icon = @"tabbar_more";
    group3.title = @"呵呵呵";
    group3.emotions = array3;
    
    //表情键盘
    LJJBrowView * brow = [[LJJBrowView alloc]init];
    [brow setGroups:@[group,group3]];
    [brow setTextView:_textView];
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
