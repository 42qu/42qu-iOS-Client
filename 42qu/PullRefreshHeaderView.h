//
//  PullRefreshHeaderView.h
//  42qu
//
//  Created by Alex on 09/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PullRefreshHeaderView;

@protocol PullRefreshHeaderViewDelegate <NSObject>

- (void)pullRefreshHeaderViewDidTriggerRefresh:(PullRefreshHeaderView *)pullRefreshHeaderView;
- (BOOL)pullRefreshHeaderViewIsRefreshing;

@end

typedef enum {
    PullRefreshStateNormal = 0,
    PullRefreshStateReady,
    PullRefreshStateLoading
} PullRefreshState;

@interface PullRefreshHeaderView : UIView

@property (nonatomic, assign) id<PullRefreshHeaderViewDelegate> delegate;

@property (nonatomic, assign) PullRefreshState state;

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) CALayer *statusImage;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)pullRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)pullRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)pullRefreshScrollViewDidFinishLoading:(UIScrollView *)scrollView;

@end
