//
//  TabbedSlideView.h
//  42qu
//
//  Created by Alex Rezit on 12-6-23.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentedControl.h"

@interface TabbedSlideView : UIView <CustomSegmentedControlDelegate>

@property (nonatomic, strong) CustomSegmentedControl *customSegmentedControl;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGFloat contentViewHeight;

@property (nonatomic, assign) CGPoint touchInitialPoint;
@property (nonatomic, assign) CGFloat contentViewOriginX;

- (id)initWithCustomSegmentedControl:(CustomSegmentedControl *)customSegmentedControl andContentViewHeight:(CGFloat)contentViewHeight;

- (CGRect)rectForViewAtIndex:(NSUInteger)index;

@end
