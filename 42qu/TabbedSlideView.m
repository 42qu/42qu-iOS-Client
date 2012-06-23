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
@synthesize touchInitialPoint = _touchInitialPoint;
@synthesize contentViewOriginX = _contentViewOriginX;

#pragma mark - External

- (CGRect)rectForViewAtIndex:(NSUInteger)index
{
    CGRect rect;
    rect.origin.x = index * self.frame.size.width;
    rect.origin.y = _customSegmentedControl.frame.size.height;
    rect.size.width = self.frame.size.width;
    rect.size.height = self.frame.size.height - _customSegmentedControl.frame.size.height;
    return rect;
}

#pragma mark - Actions

- (void)slideToViewAtIndex:(NSUInteger)index
{
    CGRect contentViewFrame = _contentView.frame;
    contentViewFrame.origin.x = self.frame.size.width * (0.0 - index);
    [UIView animateWithDuration:0.3f animations:^{
        _contentView.frame = contentViewFrame;
    }];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView = [[[UIView alloc] init] autorelease];
        self.contentViewHeight = 0;
        self.touchInitialPoint = CGPointZero;
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
        self.contentView = [[[UIView alloc] init] autorelease];
        self.contentViewHeight = contentViewHeight;
        self.touchInitialPoint = CGPointZero;
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
    [self addSubview:_customSegmentedControl];
    [self addSubview:_contentView];
    NSUInteger numberOfTabs = _customSegmentedControl.numberOfButtons;
    if (numberOfTabs > 0) {
        _contentView.frame = CGRectMake(0, _customSegmentedControl.frame.size.height, numberOfTabs * _customSegmentedControl.frame.size.width, _contentViewHeight);
    }
}

#pragma mark - Touch handle

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 1) {
        UITouch *touch = [[touches allObjects] objectAtIndex:0];
        if (CGRectContainsPoint(_contentView.frame, [touch locationInView:self])) {
            _touchInitialPoint = [touch locationInView:self];
            _contentViewOriginX = _contentView.frame.origin.x;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!CGPointEqualToPoint(_touchInitialPoint, CGPointZero) && touches.count == 1) {
        UITouch *touch = [[touches allObjects] objectAtIndex:0];
        CGPoint touchMovedPoint = [touch locationInView:self];
        CGFloat dx = touchMovedPoint.x - _touchInitialPoint.x;
        CGFloat dy = touchMovedPoint.y - _touchInitialPoint.y;
        CGFloat touchesDistance = sqrt(dx*dx+dy*dy);
        if ((dx > 0 && _customSegmentedControl.selectedIndex == 0) || (dx < 0 && _customSegmentedControl.selectedIndex == _customSegmentedControl.numberOfButtons - 1)) {
            return;
        }
        if (touchesDistance < 30.0f || ABS((touchMovedPoint.x - _touchInitialPoint.x) / (touchMovedPoint.y - _touchInitialPoint.y)) > 2) {
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.x = _contentViewOriginX + touchMovedPoint.x - _touchInitialPoint.x;
            _contentView.frame = contentViewFrame;
        } else {
            _touchInitialPoint = CGPointZero;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!CGPointEqualToPoint(_touchInitialPoint, CGPointZero) && touches.count == 1) {
        UITouch *touch = [[touches allObjects] objectAtIndex:0];
        CGPoint touchMovedPoint = [touch locationInView:self];
        CGFloat contentViewOriginXOffset = _touchInitialPoint.x - touchMovedPoint.x;
        NSUInteger newIndex = _customSegmentedControl.selectedIndex + (contentViewOriginXOffset + _customSegmentedControl.frame.size.width * (contentViewOriginXOffset > 0 ? 0.75 : 0.25)) / _customSegmentedControl.frame.size.width;
        if (newIndex >= _customSegmentedControl.numberOfButtons) {
            newIndex = _customSegmentedControl.numberOfButtons - 1;
        }
        [_customSegmentedControl selectButtonAtIndex:newIndex];
        [self slideToViewAtIndex:newIndex];
    }
    _touchInitialPoint = CGPointZero;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchInitialPoint = CGPointZero;
}

#pragma mark - Custom segmented control delegate

- (void)customSegmentedControl:(CustomSegmentedControl *)customSegmentedControl didSelectButtonAtIndex:(NSUInteger)index
{
    [self slideToViewAtIndex:index];
}

@end
