//
//  TabbedSlideView.h
//  42qu
//
//  Created by Alex Rezit on 12-6-23.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentedControl.h"

@interface TabbedSlideView : UIView <CustomSegmentedControlDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) CustomSegmentedControl *customSegmentedControl;
@property (nonatomic, strong) UIScrollView *contentView;

- (id)initWithCustomSegmentedControl:(CustomSegmentedControl *)customSegmentedControl andContentViewFrame:(CGRect)contentViewFrame;

- (CGRect)rectForViewAtIndex:(NSUInteger)index;
- (NSUInteger)indexForViewInRect:(CGRect)rect;

@end
