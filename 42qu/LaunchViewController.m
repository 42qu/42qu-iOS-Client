//
//  LaunchViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-6-1.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "AccountControl.h"

#import "LaunchViewController.h"

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
    [accountControl showLoginView];
}

- (void)showRegisterView
{
    AccountControl *accountControl = [AccountControl shared];
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

- (void)viewDidAppear:(BOOL)animated
{
#warning Begin animation here
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL isLoggedIn = [AccountControl shared].tryLogin;
#warning End animation here
        if (isLoggedIn) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AccountControl shared] hideLaunchView];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.3f animations:^{
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
                }];
            });
        }
    });
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
