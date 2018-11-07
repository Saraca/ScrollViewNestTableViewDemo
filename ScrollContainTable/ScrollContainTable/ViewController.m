//
//  ViewController.m
//  ScrollContainTable
//
//  Created by RLY on 2018/11/6.
//  Copyright © 2018年 RLY. All rights reserved.
//

#import "ViewController.h"

/// 这三个值根据实际情况设置。
static const CGFloat kSectionHeaderViewHeight = 70;
static const CGFloat kTableOriginY = 191;
CGFloat kTableHeaderHeight = kTableOriginY - kSectionHeaderViewHeight;

@interface ViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) EGOTableHeaderView *tableHeaderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableHeaderView = [[EGOTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, _scroll.frame.size.width, kTableHeaderHeight)];
    [_scroll insertSubview:_tableHeaderView atIndex:0];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _layoutContainerScrollViewHeight.constant = _scroll.frame.size.height - kSectionHeaderViewHeight;
    NSAssert(kTableHeaderHeight >= 0,  @"kHeaderViewHeight必须小于等于kTableOriginY");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scroll) {
        if (_table.contentOffset.y > 0) {
            // header已经消失，开始滚动下面的_table，并让_scroll不动
            _scroll.contentOffset = CGPointMake(0, kTableHeaderHeight);
        }
        if (_scroll.contentOffset.y < kTableHeaderHeight) {
            // header已经显示出来，重置_table.contentOffset为0
            _table.contentOffset = CGPointZero;
        }
        [_tableHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
    }
    else if (scrollView == _table) {
        if (_scroll.contentOffset.y < kTableHeaderHeight) {
            // header还没有消失，那么_table.contentOffset一直为0
            _table.contentOffset = CGPointZero;
            _table.showsVerticalScrollIndicator = NO;
        }
        else {
            // header已经消失
            _scroll.contentOffset = CGPointMake(0, kTableHeaderHeight);
            _table.showsVerticalScrollIndicator = YES;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end


@implementation EGOScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end


@implementation EGOTableHeaderView {
    UIImageView *_imageView;
    CGRect _imageViewFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"风景图.jpg"]];
        _imageView.frame = _imageViewFrame;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = _imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    _imageView.frame = frame;
}

@end


