//
//  LJJTextView.m
//  Keybord
//
//  Created by Jun on 14-1-12.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJTextView.h"

@implementation LJJTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma mark 重写删除操作
- (void)deleteBackward {
    NSRange range = self.selectedRange;
    if (range.length == 0 && range.location != 0) {
        NSString * sub = [self.text substringWithRange:NSMakeRange(range.location - 1, 1)];
        if ([sub isEqualToString:@"]"]) {
            NSRange lastRange = [self.text rangeOfString:@"[" options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
            
            self.selectedRange = NSMakeRange(lastRange.location, range.location - lastRange.location);
        }
    }
    [super deleteBackward];
}

@end
