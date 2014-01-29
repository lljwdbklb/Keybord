//
//  LJJBrowButton.h
//  Keybord
//
//  Created by Jun on 14-1-29.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJJBrowButton : UIButton

- (void)setImageName:(NSString *)imageName forState:(UIControlState)state;
- (void)setImageUrl:(NSString *)imageUrl forState:(UIControlState)state;
@end
