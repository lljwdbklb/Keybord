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
 *
 * LJJGroup * group = [[LJJGroup alloc]init];
 * group.icon = @"tabbar_more";
 * group.emotions = [array subarrayWithRange:NSMakeRange(0, 100)];
 * ...
 *
 * //表情键盘
 * LJJBrowView * brow = [[LJJBrowView alloc]init];
 * [brow setGroups:@[group,...]];
 * [brow setTextView:_textView];
 * [_textField setInputView:brow];
 *
 */

#import "LJJTextView.h"
#import "LJJTextField.h"

//表情键盘
#import "LJJBrowView.h"

//表情模型
#import "LJJEmotion.h"
//分组模型
#import "LJJGroup.h"
