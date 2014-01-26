//
//  LJJBrowView.m
//  KeybordGroup
//
//  Created by Jun on 14-1-15.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import "LJJBrowView.h"

#import "LJJGroupDock.h"
#import "LJJBrowItem.h"

#import "LJJGroup.h"

const CGFloat LJJBrowViewHeight = 220;

@interface LJJBrowView()<UIScrollViewDelegate,LJJGroupDockDelegate>
{
    LJJGroupDock * _dock;//组导航
    UIScrollView * _scrollView;//滑动模块
    UIPageControl * _pageControl;//分页展示
    
    //再屏幕中的item
    NSMutableSet        * _reusableItemSetM;//可重用
    NSMutableDictionary * _screenItemDictM;//scrollView上
    NSMutableSet        * _items;
}

@property (strong, nonatomic)NSMutableArray * pageItemFrames;
@property (weak, nonatomic)LJJGroup * selectedGroup;//选择的组

@end

@implementation LJJBrowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        //设置UI
        [self setupGroupDock];
        [self setupScrollView];
        [self setupPageControl];
        //设置缓存
        [self setupCache];
    }
    return self;
}
#pragma mark - 设置UI私有方法
#pragma mark 设置缓存
- (void)setupCache {
    _screenItemDictM = [NSMutableDictionary dictionary];
    
    _reusableItemSetM = [NSMutableSet set];
    
    _items = [NSMutableSet set];
}
#pragma mark 设置分页
- (void)setupPageControl {
    _pageControl = [[UIPageControl alloc]init];
//    [_pageControl setBackgroundColor:[UIColor orangeColor]];
    
    CGFloat x = _scrollView.frame.origin.x;
    CGFloat y = CGRectGetMaxY(_scrollView.frame);
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = self.frame.size.height - y;
    [_pageControl setFrame:CGRectMake(x, y, w, h)];
    
    [self addSubview:_pageControl];
}

#pragma mark 设置滚动范围
- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc]init];

    [_scrollView setPagingEnabled:YES];
    [_scrollView setDelegate:self];
    
    CGFloat x = _dock.frame.size.width;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width - x;
    CGFloat h = LJJBrowItemHeight;
    [_scrollView setFrame:CGRectMake(x, y, w, h)];
    
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:_scrollView];
}

#pragma mark 设置导航条
- (void)setupGroupDock {
    _dock = [[LJJGroupDock alloc]init];

    [_dock setDelegate:self];
    [_dock setFrame:CGRectMake(0, 0, 0,self.frame.size.height)];
    
    [self addSubview:_dock];
}

#pragma mark - 重写方法
- (void)setFrame:(CGRect)frame {
    frame.size.width = [UIScreen mainScreen].applicationFrame.size.width;
    frame.size.height = LJJBrowViewHeight;
    frame.origin.x = 0;
    
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    bounds.size.width = [UIScreen mainScreen].applicationFrame.size.width;
    bounds.size.height = LJJBrowViewHeight;
    [super setBounds:bounds];
}

#pragma mark 设置分组数据
- (void)setGroups:(NSArray *)groups {
    _groups = groups;
    
    [groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LJJGroup * group = obj;
        [_dock addGroupItemWithIcon:group.icon];
    }];
}

- (void)setSelectedGroup:(LJJGroup *)selectedGroup {
    _selectedGroup = selectedGroup;
    //设置当前的分组item 的 Frame
    if (_pageItemFrames == nil) {
        NSMutableArray * frames = [NSMutableArray array];
        _pageItemFrames = frames;
    }
    NSInteger count = [self currentPageCount];
    for (NSInteger i = _pageItemFrames.count; i < count; i++) {
        CGFloat x = i*_scrollView.frame.size.width;
        CGFloat y = 0;
        CGRect frame = (CGRect){{x,y},_scrollView.frame.size};
        [_pageItemFrames addObject:[NSValue valueWithCGRect:frame]];
    }
//    for (NSInteger i = 0; i < count; i++) {
//        CGFloat x = i*_sïcrollView.frame.size.width;
//        CGFloat y = 0;
//        CGRect frame = (CGRect){{x,y},_scrollView.frame.size};
//        [_pageItemFrames addObject:[NSValue valueWithCGRect:frame]];
//    }
}
- (void)setTextView:(UITextView *)textView {
    _textView = textView;
    
    [_items enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        LJJBrowItem * item = obj;
        [item setTextView:textView];
    }];
}
- (void)setTextField:(UITextField *)textField {
    _textField = textField;
    [_items enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        LJJBrowItem * item = obj;
        [item setTextField:textField];
    }];
}

#pragma mark - dock代理
- (void)dock:(LJJGroupDock *)dock didSeletedItemFrom:(NSInteger)from to:(NSInteger)to {
    
    self.selectedGroup = _groups[to];
    
    //设置展示范围
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [_scrollView setContentSize:CGSizeMake(self.currentPageCount * _scrollView.frame.size.width, 0)];
    //设置页数
    [_pageControl setNumberOfPages:[self currentPageCount]];
    [_pageControl setCurrentPage:0];
    //重设数据
    [self scrollViewDidScroll:_scrollView];
}
#pragma mark - 当前页数
- (NSInteger)currentPageCount {
    NSInteger count = _selectedGroup.emotions.count % LJJBrowCount ? _selectedGroup.emotions.count / LJJBrowCount + 1 : _selectedGroup.emotions.count / LJJBrowCount;
    return count;
}
#pragma mark 当前那页的数据
- (NSArray *)pageDataWithCurrentIndex:(NSInteger)index {
    NSArray * emotions = self.selectedGroup.emotions;
    NSInteger loc = index*LJJBrowCount;
    NSInteger len = LJJBrowCount;
    if (loc >= emotions.count) {
        return nil;
    }
    if (loc + len >= emotions.count) {
        len = emotions.count - loc;
    }
    return [emotions subarrayWithRange:NSMakeRange(loc, len)];
}
#pragma mark 是否显示在屏幕中
- (BOOL)isExistScreenWithFrame:(CGRect)frame {
    CGRect currentFrame = CGRectMake(_scrollView.contentOffset.x, 0, _scrollView.frame.size.width, 0);
    
    return CGRectIntersectsRect(currentFrame, frame);
}

#pragma mark - scrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_pageItemFrames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGRect frame = [obj CGRectValue];

        LJJBrowItem * item = _screenItemDictM[obj];

        //判断当前范围的视图是否存在
        if (item == nil) {
            //判断当前范围在屏幕中
            if ([self isExistScreenWithFrame:frame]) {//在屏幕中
                item = [self dequeueReusableItem];
                if (item == nil) {//缓存池中没有，创建一个新的
                    item = [[LJJBrowItem alloc]init];
                    [item setTextField:_textField];
                    [item setTextView:_textView];
                    [_items addObject:item];
                }
                [item setFrame:frame];
                [item setEmotions:[self pageDataWithCurrentIndex:idx]];
                
                [_scrollView addSubview:item];
                [_screenItemDictM setObject:item forKey:obj];
            }
        } else {//有这个视图
            if (![self isExistScreenWithFrame:frame]) {//不在屏幕中
                [item removeFromSuperview];
                [_reusableItemSetM addObject:item];
                [_screenItemDictM removeObjectForKey:obj];
            } else {
                [item setEmotions:[self pageDataWithCurrentIndex:idx]];
            }
        }
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

#pragma mark 在缓存池中获取可重用Item
- (id)dequeueReusableItem {
    LJJBrowItem * imageView = [_reusableItemSetM anyObject];
    if (imageView) {
        //删除缓存
        [_reusableItemSetM removeObject:imageView];
    }
    return imageView;
}
@end
