//
//  LJJBrowView.m
//  企信通
//
//  Created by Jun on 13-12-6.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "LJJBrowView.h"

#import "LJJEmotion.h"
#import "LJJBrowItem.h"

const CGFloat LJJAnimatedTimer = 0.25;

#define kBrowViewH  220

#define kMax 10

@interface LJJBrowView()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
}

@end

@implementation LJJBrowView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        [self setupScrollView];
        [self setupPageControl];
    }
    return self;
}

#pragma mark - 设置视图
- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc]init];
    [_scrollView setFrame:CGRectMake(0, 0, self.frame.size.width, LJJBrowItemHeight)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setDelegate:self];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:_scrollView];
}

- (void)setupPageControl {
    _pageControl = [[UIPageControl alloc]init];
    [_pageControl setFrame:CGRectMake(0, _scrollView.frame.size.height, self.frame.size.width, self.frame.size.height - _scrollView.frame.size.height)];
    [self addSubview:_pageControl];
}

- (void)setupItems {
    NSInteger page = _emotions.count % LJJBrowCount == 0 ? _emotions.count / LJJBrowCount : _emotions.count / LJJBrowCount + 1;
    page = page > kMax ?kMax:page;
    _pageControl.numberOfPages = page;
    
    for (NSInteger i = 0; i < page; i++) {
        LJJBrowItem * item = [[LJJBrowItem alloc]init];
        [item setTextView:_textView];
        [item setTextField:_textField];
        CGFloat x = i * self.frame.size.width;
        CGFloat y = 0;
        [item setFrame:(CGRect){{x,y},CGSizeZero}];
        
        //截取数据
        NSInteger loc = i * LJJBrowCount;
        NSInteger len = LJJBrowCount;
        if (loc + len >= _emotions.count) {
            len = _emotions.count - loc;
        }
        NSRange range = NSMakeRange(loc, len);
        NSArray * sub = [_emotions subarrayWithRange:range];
        [item setEmotions:sub];
        
        [_scrollView addSubview:item];
    }
    [_scrollView setContentSize:CGSizeMake(page * self.frame.size.width, 0)];
    
}

#pragma mark - 重写方法
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    [self setupItems];
}
- (void)setFrame:(CGRect)frame {
//    if (frame.origin.y == 0) {
//        frame.origin.y = [UIScreen mainScreen].applicationFrame.size.height + kBrowViewH;
//    }
    frame.size.width = [UIScreen mainScreen].applicationFrame.size.width;
    frame.size.height = kBrowViewH;
    frame.origin.x = 0;
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    bounds.size.width = [UIScreen mainScreen].applicationFrame.size.width;
    bounds.size.height = kBrowViewH;
    [super setBounds:bounds];
}

#pragma mark - 动作
- (void)show {
    _isShow = YES;
    CGRect frame = self.frame;
    frame.origin.y = self.superview.bounds.size.height - kBrowViewH;
    [UIView animateWithDuration:LJJAnimatedTimer animations:^{
        self.frame = frame;
    }completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(browChangeAtFrame:animatedTimer:)]) {
            [_delegate browChangeAtFrame:frame animatedTimer:LJJAnimatedTimer];
        }
    }];
    
}

- (void)hide {
    _isShow = NO;
    CGRect frame = self.frame;
    frame.origin.y = self.superview.bounds.size.height;
    
    [UIView animateWithDuration:LJJAnimatedTimer animations:^{
        self.frame = frame;
    }];
    if ([_delegate respondsToSelector:@selector(browChangeAtFrame:animatedTimer:)]) {
        [_delegate browChangeAtFrame:frame animatedTimer:LJJAnimatedTimer];
    }
}
#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = page;
}

@end
