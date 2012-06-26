//
//  PeopleDetailViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-6-16.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "PeopleDetailViewController.h"
#import "CustomSegmentedControl.h"
#import "TabbedSlideView.h"

#define kHeightSegmentedControl 40.0f
#define kHeightButtonExchangeCard 40.0f

@interface PeopleDetailViewController ()

@end

@implementation PeopleDetailViewController

@synthesize segmentedControl = _segmentedControl;
@synthesize tabbedSlideView = _tabbedSlideView;
@synthesize exchangeCardButton = _exchangeCardButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)dealloc
{
    [_segmentedControl release];
    [_tabbedSlideView release];
    [_exchangeCardButton release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create and add segmented control
    self.segmentedControl = [[[CustomSegmentedControl alloc] 
                             initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeightSegmentedControl) 
                             andTitles:[NSArray arrayWithObjects:NSLocalizedString(@"Intro", nil), NSLocalizedString(@"Details", nil), NSLocalizedString(@"Photos", nil), nil] 
                             andImages:nil
                             andHighlightedTitles:nil 
                             andSelectedTitles:nil 
                             andBackgroundImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-bg"] 
                             andDividerImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-divider"] 
                             andHighlightedBackgroundImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-highlighted"] 
                             andSelectedBackgroundImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-selected"]] autorelease];
    [self.view addSubview:_segmentedControl];
    
    // Create and add content view
    self.tabbedSlideView = [[[TabbedSlideView alloc] initWithCustomSegmentedControl:_segmentedControl andContentViewFrame:CGRectMake(0, kHeightSegmentedControl, self.view.frame.size.width, self.view.frame.size.height - kHeightSegmentedControl - kHeightButtonExchangeCard)] autorelease];
    [self.view addSubview:_tabbedSlideView];
    
    // Create and add exchange card button
    self.exchangeCardButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - kHeightButtonExchangeCard, self.view.frame.size.width, kHeightButtonExchangeCard)] autorelease];
    _exchangeCardButton.backgroundColor = [UIColor colorWithWhite:95.0f/255.0f alpha:1.0f];
    [_exchangeCardButton setTitle:NSLocalizedString(@"Exchange Card", nil) forState:UIControlStateNormal];
    [self.view addSubview:_exchangeCardButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.segmentedControl = nil;
    self.tabbedSlideView = nil;
    self.exchangeCardButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
