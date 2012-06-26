//
//  PeopleDetailViewController.h
//  42qu
//
//  Created by Alex Rezit on 12-6-16.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSegmentedControl, TabbedSlideView;

@interface PeopleDetailViewController : UIViewController

@property (nonatomic, strong) CustomSegmentedControl *segmentedControl;
@property (nonatomic, strong) TabbedSlideView *tabbedSlideView;
@property (nonatomic, strong) UIButton *exchangeCardButton;

@end
