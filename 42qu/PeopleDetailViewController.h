//
//  PeopleDetailViewController.h
//  42qu
//
//  Created by Alex Rezit on 12-6-16.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSegmentedControl, TabbedSlideView;
@class PeopleDetailIntroView, PeopleDetailDetailView, PeopleDetailGalleryView;

@interface PeopleDetailViewController : UIViewController

@property (nonatomic, strong) CustomSegmentedControl *segmentedControl;
@property (nonatomic, strong) TabbedSlideView *tabbedSlideView;
@property (nonatomic, strong) UIButton *exchangeCardButton;

@property (nonatomic, strong) PeopleDetailIntroView *peopleDetailIntroView;
@property (nonatomic, strong) PeopleDetailDetailView *peopleDetailDetailView;
@property (nonatomic, strong) PeopleDetailGalleryView *peopleDetailGalleryView;

@property (nonatomic, assign) BOOL isMyself;

@end
