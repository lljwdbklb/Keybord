/**
 *  用法
 *
 *
 *  可使用LJJTextView或LJJTextField，进行编辑
 *  用法与UITextView和UITextField一样
 *  多加删除表情操作
 *  若不需要删除表情操作也可以用UI的控件
 *
 *
 *  
 *  //添加表情数据
 *  NSArray * array = [LJJEmotion emotionsWithFile:[[NSBundle mainBundle] pathForResource:@"emotions.plist" ofType:nil]];
 *
 *
 *  LJJBrowView * brow = [[LJJBrowView alloc]init];
 *  //添加表情键盘输入时，输入到textView中
 *  [brow setTextView:_textView];
 *  //[brow setTextField:_textField];//两者不能同时设置
 *  //添加表情数据
 *  [brow setEmotions:array];
 *  
 *  //以textField打开键盘
 *  [_textField setInputView:brow];
 *
 */

#import "LJJTextView.h"
#import "LJJTextField.h"

//表情键盘
#import "LJJBrowView.h"

//表情模型
#import "LJJEmotion.h"
