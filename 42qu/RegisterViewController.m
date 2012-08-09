//
//  RegisterViewController.m
//  42qu
//
//  Created by Alex on 08/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import "RegisterViewController.h"

#import "RegisterListViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

#pragma mark - Animations

- (void)dismiss
{
    [(RegisterListViewController *)[self.navigationController.viewControllers objectAtIndex:0] dismiss];
}

#pragma mark - Actions

- (void)doneButtonPressed
{
    [self dismiss];
}

#pragma mark - Life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backBarButtonItem = [[[UIBarButtonItem alloc] init] autorelease];
    backBarButtonItem.title = @"Back";
    [(RegisterListViewController *)[self.navigationController.viewControllers objectAtIndex:0] navigationItem].backBarButtonItem = backBarButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)] autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
