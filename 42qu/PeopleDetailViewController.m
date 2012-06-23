//
//  PeopleDetailViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-6-16.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "PeopleDetailViewController.h"
#import "CustomSegmentedControl.h"

#define kHeightSegmentedControl 40.0f

@interface PeopleDetailViewController ()

@end

@implementation PeopleDetailViewController

@synthesize segmentedControl = _segmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_segmentedControl release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create and add segmented control
    self.segmentedControl = [[[CustomSegmentedControl alloc] 
                             initWithFrame:CGRectMake(0, 0, 320, kHeightSegmentedControl) 
                             andTitles:[NSArray arrayWithObjects:NSLocalizedString(@"Intro", nil), NSLocalizedString(@"Details", nil), NSLocalizedString(@"Photos", nil), nil] 
                             andHighlightedTitles:nil 
                             andSelectedTitles:nil 
                             andBackgroundImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-bg"] 
                             andDividerImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-divider"] 
                             andHighlightedBackgroundImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-highlighted"] 
                             andSelectedBackgroundImage:[UIImage imageNamed:@"peopledetail-segmentedcontrol-selected"]] autorelease];
    [self.view addSubview:_segmentedControl];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.segmentedControl = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
