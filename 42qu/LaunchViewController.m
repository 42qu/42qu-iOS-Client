//
//  LaunchViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-6-1.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "LaunchViewController.h"
#import "RegisterListViewController.h"

#define kFrameViewTopbar CGRectMake(0, 0, 320, 44)
#define kFrameLabelTitle CGRectMake(0, 0, 120, 44)
#define kFrameButtonSelectCity CGRectMake(120, 0, 240, 44)

#define kHeightButtonStart 50.0
#define kFrameButtonStart CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height - kHeightButtonStart, 320, kHeightButtonStart)
#define kFrameButtonLogin CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height - kHeightButtonStart, 160, kHeightButtonStart)
#define kFrameButtonRegister CGRectMake(160, [UIScreen mainScreen].applicationFrame.size.height - kHeightButtonStart, 160, kHeightButtonStart)

@interface LaunchViewController ()

@end

@implementation LaunchViewController

#pragma mark - Internal methods

- (void)showLoginView
{
    AccountControl *accountControl = [AccountControl shared];
    accountControl.delegate = self;
    [accountControl showLoginView];
}

- (void)showRegisterView
{
    AccountControl *accountControl = [AccountControl shared];
    accountControl.delegate = self;
    [accountControl showRegisterListView];
}

#pragma mark - User action

- (void)loginButtonPressed
{
    [self showLoginView];
}

- (void)registerButtonPressed
{
    [self showRegisterView];
}

#pragma mark - Life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default"]];
    }
    return self;
}

- (void)dealloc
{
    [_loginButton release];
    [_registerButton release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginButton = [[[UIButton alloc] initWithFrame:kFrameButtonLogin] autorelease];
    [_loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"launch-startbutton-bg"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    self.registerButton = [[[UIButton alloc] initWithFrame:kFrameButtonRegister] autorelease];
    [_registerButton setTitle:NSLocalizedString(@"Register", nil) forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"launch-startbutton-bg"] forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.loginButton = nil;
    self.registerButton = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Account control delegate

- (void)accountControlDidLogin
{
    [self.navigationController.view removeFromSuperview];
}

- (void)accountControlDidFailLoginWithReason:(NSString *)reason
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed", nil) message:reason delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
