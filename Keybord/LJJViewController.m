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


@interface LJJViewController ()
{
    UITextView * _textView;
    UITextField * _textField;
    UIToolbar * _bar;
}
@end

@implementation LJJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
//    [textView setEditable:NO];
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
//    [brow show];

//    NSLog(@"%@",array);
    
    
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
