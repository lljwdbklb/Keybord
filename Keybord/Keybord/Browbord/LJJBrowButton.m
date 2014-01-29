//
//  LJJBrowButton.m
//  Keybord
//
//  Created by Jun on 14-1-29.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJBrowButton.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"


@implementation LJJBrowButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName forState:(UIControlState)state {
    NSString * ex = [imageName pathExtension];
    UIImage * image = nil;
    if (![ex isEqualToString:@"gif"]) {
        NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:nil]];
        image = [UIImage imageWithData:data	];
    } else {
        image = [UIImage sd_animatedGIFNamed:[imageName stringByDeletingPathExtension]];
    }
    
    
    [self setImage:image forState:state];
}

- (void)setImageUrl:(NSString *)imageUrl forState:(UIControlState)state {
    [self setImageWithURL:[NSURL URLWithString:imageUrl] forState:state];
}

@end
