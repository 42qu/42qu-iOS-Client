//
//  PublishViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-5-22.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

@synthesize contentTextView = _contentTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Publish", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:nil] autorelease];
    [super viewDidLoad];
    [_contentTextView becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
