//
//  LJJViewController.m
//  Keybord
//
//  Created by Jun on 14-1-9.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJViewController.h"
#import "LJJBrowView.h"


#import "LJJEmotion.h"

#import "LJJTextView.h"


@interface LJJViewController () <UITextViewDelegate>
{
    LJJTextView * _textView;
    UITextField * _textField;
    UIToolbar * _bar;
}
@end

@implementation LJJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    LJJTextView * textView = [[LJJTextView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
//    [textView setEditable:NO];
    [textView setDelegate:self];
    [self.view addSubview:textView];
    _textView = textView;
    
    UITextField * textField = [[UITextField alloc]init];
    [self.view addSubview:textField];
    _textField = textField;
    
    
    NSArray * array = [LJJEmotion emotionsWithFile:[[NSBundle mainBundle] pathForResource:@"emotions.plist" ofType:nil]];
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"换" style:UIBarButtonItemStyleDone target:self action:@selector(huan)];
    UIToolbar * bar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [bar setItems:@[item]];
    [textView setInputAccessoryView:bar];
    [textField setInputAccessoryView:bar];
    
    LJJBrowView * brow = [[LJJBrowView alloc]init];
    [brow setTextView:textView];
    [brow setEmotions:array];
//    [self.view addSubview:brow];
    [textField setInputView:brow];
    
    
}


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
