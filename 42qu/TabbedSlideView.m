//
//  TabbedSlideView.m
//  42qu
//
//  Created by Alex Rezit on 12-6-23.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "TabbedSlideView.h"

@implementation TabbedSlideView

@synthesize customSegmentedControl = _customSegmentedControl;
@synthesize contentView = _contentView;
@synthesize contentViewHeight = _contentViewHeight;

#pragma mark - External

- (CGRect)rectForViewAtIndex:(NSUInteger)index
{
    CGRect rect;
    rect.origin.x = index * self.frame.size.width;
    rect.origin.y = 0;
    rect.size.width = self.frame.size.width;
    rect.size.height = self.frame.size.height - _customSegmentedControl.frame.size.height;
    return rect;
}

- (NSUInteger)indexForViewInRect:(CGRect)rect
{
    NSUInteger index = rect.origin.x / self.frame.size.width;
    return index;
}

#pragma mark - Actions

- (void)slideToViewAtIndex:(NSUInteger)index
{
    CGRect rect = [self rectForViewAtIndex:index];
    [_contentView scrollRectToVisible:rect animated:YES];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView = [[[UIScrollView alloc] init] autorelease];
        self.contentViewHeight = 0;
    }
    return self;
}

- (id)initWithCustomSegmentedControl:(CustomSegmentedControl *)customSegmentedControl andContentViewHeight:(CGFloat)contentViewHeight
{
    CGRect frame = customSegmentedControl.frame;
    frame.size.height += contentViewHeight;
    self = [super initWithFrame:frame];
    if (self) {
        self.customSegmentedControl = customSegmentedControl;
        self.contentView = [[[UIScrollView alloc] init] autorelease];
        self.contentViewHeight = contentViewHeight;
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

- (void)dealloc
{
    [_customSegmentedControl release];
    [_contentView release];
    [super dealloc];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    _customSegmentedControl.delegate = self;
    _contentView.delegate = self;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.pagingEnabled = YES;
    [self addSubview:_customSegmentedControl];
    [self addSubview:_contentView];
    NSUInteger numberOfTabs = _customSegmentedControl.numberOfButtons;
    if (numberOfTabs > 0) {
        _contentView.frame = CGRectMake(0, _customSegmentedControl.frame.size.height, _customSegmentedControl.frame.size.width, _contentViewHeight);
        _contentView.contentSize = CGSizeMake(numberOfTabs * _customSegmentedControl.frame.size.width, _contentViewHeight);
    }
}

#pragma mark - Custom segmented control delegate

- (void)customSegmentedControl:(CustomSegmentedControl *)customSegmentedControl didSelectButtonAtIndex:(NSUInteger)index
{
    [self slideToViewAtIndex:index];
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_customSegmentedControl selectButtonAtIndex:scrollView.contentOffset.x / _customSegmentedControl.frame.size.width];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // I don't expect you to understand this very quickly, but please don't make any changes or it wouldn't be so perfect. - Alex
    if (_customSegmentedControl.animationType == SegmentedControlAnimationTypeMove) {
        [_customSegmentedControl moveSelectedBackgroundToOffset:scrollView.contentOffset.x * (_customSegmentedControl.frame.size.width + _customSegmentedControl.dividerImage.size.width) / _customSegmentedControl.frame.size.width / _customSegmentedControl.numberOfButtons];
    }
}

@end
