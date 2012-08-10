//
//  PullRefreshHeaderView.m
//  42qu
//
//  Created by Alex on 09/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import "PullRefreshHeaderView.h"

@implementation PullRefreshHeaderView

#pragma mark - Setters

- (void)setState:(PullRefreshState)state
{
#warning animations
    switch (state) {
        case PullRefreshStateNormal:
            self.backgroundColor = [UIColor lightGrayColor];
            break;
        case PullRefreshStateReady:
            self.backgroundColor = [UIColor greenColor];
            break;
        case PullRefreshStateLoading:
            self.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
    _state = state;
}

#pragma mark - For delegate

- (void)pullRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_state == PullRefreshStateLoading) {
        CGFloat offset = MAX(0 - scrollView.contentOffset.y, 0);
        offset = MIN(offset, 66);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
    } else if (scrollView.isDragging) {
        BOOL isRefreshing = [self.delegate pullRefreshHeaderViewIsRefreshing];
        if (!isRefreshing && _state == PullRefreshStateNormal && scrollView.contentOffset.y < - 66.0f) {
            self.state = PullRefreshStateReady;
        } else if (!isRefreshing && _state == PullRefreshStateReady && scrollView.contentOffset.y > - 66.0f && scrollView.contentOffset.y < 0) {
            self.state = PullRefreshStateNormal;
        }
    }
}

- (void)pullRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (![self.delegate pullRefreshHeaderViewIsRefreshing] && scrollView.contentOffset.y < - 66.0f) {
        [self.delegate pullRefreshHeaderViewDidTriggerRefresh:self];
        self.state = PullRefreshStateLoading;
        [UIView animateWithDuration:0.15f animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0, 0, 0);
        }];
    }
}

- (void)pullRefreshScrollViewDidFinishLoading:(UIScrollView *)scrollView
{
    self.state = PullRefreshStateNormal;
    [UIView animateWithDuration:0.15f animations:^{
        scrollView.contentInset = UIEdgeInsetsZero;
    }];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.state = PullRefreshStateNormal;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
