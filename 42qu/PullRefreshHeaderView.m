//
//  PullRefreshHeaderView.m
//  42qu
//
//  Created by Alex on 09/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "PullRefreshHeaderView.h"

@implementation PullRefreshHeaderView

#pragma mark - Setters

- (void)setState:(PullRefreshState)state
{
    switch (state) {
        case PullRefreshStateNormal:
            _statusLabel.text = NSLocalizedString(@"Pull to refresh.", nil);
            _arrowImage.hidden = NO;
            if (_state == PullRefreshStateReady) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.15f];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            _arrowImage.transform = CATransform3DIdentity;
            _successImage.hidden = YES;
            _activityIndicator.hidden = YES;
            break;
        case PullRefreshStateReady:
            _statusLabel.text = NSLocalizedString(@"Release to refresh.", nil);
            _arrowImage.hidden = NO;
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.15f];
            _arrowImage.transform = CATransform3DMakeRotation(M_PI * 1.0f, 0, 0, 1.0f);
            [CATransaction commit];
            _successImage.hidden = YES;
            _activityIndicator.hidden = YES;
            break;
        case PullRefreshStateLoading:
            _statusLabel.text = NSLocalizedString(@"Refreshing...", nil);
            _arrowImage.hidden = YES;
            _arrowImage.transform = CATransform3DIdentity;
            _successImage.hidden = YES;
            [_activityIndicator startAnimating];
            _activityIndicator.hidden = NO;
            break;
        case PullRefreshStateLoaded:
            _statusLabel.text = NSLocalizedString(@"Refresh success.", nil);
            _arrowImage.hidden = YES;
            _arrowImage.transform = CATransform3DIdentity;
            _successImage.hidden = NO;
            [_activityIndicator stopAnimating];
            _activityIndicator.hidden = YES;
        default:
            break;
    }
    _state = state;
}

#pragma mark - Animations

- (void)addInsetToScrollView:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.15f animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0, 0, 0);
    }];
}

- (void)removeInsetOfScrollView:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.15f animations:^{
        scrollView.contentInset = UIEdgeInsetsZero;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.15f animations:^{
                self.state = PullRefreshStateNormal;
            }];
        }
    }];
}

#pragma mark - For delegate

- (void)pullRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_state == PullRefreshStateLoading) {
        CGFloat offset = MAX(0 - scrollView.contentOffset.y, 0);
        offset = MIN(offset, 66);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
    } else if (scrollView.isDragging && ![self.delegate pullRefreshHeaderViewIsRefreshing]) {
        if (_state == PullRefreshStateNormal && scrollView.contentOffset.y < - 66.0f) {
            self.state = PullRefreshStateReady;
        } else if ((_state == PullRefreshStateReady || _state == PullRefreshStateLoaded) && scrollView.contentOffset.y > - 66.0f && scrollView.contentOffset.y < 0) {
            self.state = PullRefreshStateNormal;
        }
    }
}

- (void)pullRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (![self.delegate pullRefreshHeaderViewIsRefreshing] && scrollView.contentOffset.y < - 66.0f) {
        [self.delegate pullRefreshHeaderViewDidTriggerRefresh:self];
        self.state = PullRefreshStateLoading;
        [self addInsetToScrollView:scrollView];
    }
}

- (void)pullRefreshScrollViewDidFinishLoading:(UIScrollView *)scrollView
{
    self.state = PullRefreshStateLoaded;
    [self performSelector:@selector(removeInsetOfScrollView:) withObject:scrollView afterDelay:0.4f];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.statusLabel = [[[UILabel alloc] initWithFrame:CGRectMake(60.0f, frame.size.height - 43.0f, self.frame.size.width - 90.0f, 20.0f)] autorelease];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textColor = [UIColor darkGrayColor];
        _statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        _statusLabel.shadowOffset = CGSizeMake(0, 1.0f);
        _statusLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_statusLabel];
        
        self.arrowImage = [CALayer layer];
        _arrowImage.frame = CGRectMake(30.0f, frame.size.height - 66.0f, 30.0f, 66.0f);
        _arrowImage.contents = (id)[UIImage imageNamed:@"pullrefresh-arrow"].CGImage;
        [self.layer addSublayer:_arrowImage];
        
        self.successImage = [CALayer layer];
        _successImage.frame = CGRectMake(35.0f, frame.size.height - 43.0f, 20.0f, 20.0f);
        _successImage.contents = (id)[UIImage imageNamed:@"pullrefresh-success"].CGImage;
        [self.layer addSublayer:_successImage];
        
        self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        _activityIndicator.frame = CGRectMake(35.0f, frame.size.height - 43.0f, 20.0f, 20.0f);
        [self addSubview:_activityIndicator];
        
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
