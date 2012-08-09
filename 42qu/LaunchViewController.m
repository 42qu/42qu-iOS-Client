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

- (void)switchButtonStatus
{
    // Fade effect
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    [UIView animateWithDuration:0.3f animations:^{
        BOOL startButtonHidden = _startButton.hidden;
        _startButton.hidden = !startButtonHidden;
        _loginButton.hidden = startButtonHidden;
        _registerButton.hidden = startButtonHidden;
    }];
}

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

- (void)selectCityButtonPressed
{
    // Show city picker in an action sheet
    UIActionSheet *selectCityActionSheet = [[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select\n\n", nil), nil] autorelease];
    UIPickerView *cityPicker = [[[UIPickerView alloc] init] autorelease];
    cityPicker.delegate = self;
    [selectCityActionSheet addSubview:cityPicker];
    [selectCityActionSheet showInView:self.view];
}

- (void)startButtonPressed
{
    [self switchButtonStatus];
}

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
    [_selectCityButton release];
    [_startButton release];
    [_loginButton release];
    [_registerButton release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize top bar
    UIView *topbarView = [[[UIView alloc] initWithFrame:kFrameViewTopbar] autorelease];
    [topbarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"launch-navbar-bg"]]];
    
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:kFrameLabelTitle] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = NSLocalizedString(@"Sector 42", nil);
    titleLabel.textAlignment = UITextAlignmentCenter;
    [topbarView addSubview:titleLabel];
    
    self.selectCityButton = [[[UIButton alloc] initWithFrame:kFrameButtonSelectCity] autorelease];
    [_selectCityButton setTitle:@"Beijing" forState:UIControlStateNormal];
    [_selectCityButton setBackgroundImage:[UIImage imageNamed:@"launch-navbar-bg"] forState:UIControlStateNormal];
    [_selectCityButton addTarget:self action:@selector(selectCityButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [topbarView addSubview:_selectCityButton];
    
    [self.view addSubview:topbarView];
    
    // Initialize bottom buttons
    self.startButton = [[[UIButton alloc] initWithFrame:kFrameButtonStart] autorelease];
    [_startButton setTitle:NSLocalizedString(@"Start my voyage. ", nil) forState:UIControlStateNormal];
    [_startButton setBackgroundImage:[UIImage imageNamed:@"launch-startbutton-bg"] forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
    
    self.loginButton = [[[UIButton alloc] initWithFrame:kFrameButtonLogin] autorelease];
    [_loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"launch-startbutton-bg"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.hidden = YES;
    [self.view addSubview:_loginButton];
    
    self.registerButton = [[[UIButton alloc] initWithFrame:kFrameButtonRegister] autorelease];
    [_registerButton setTitle:NSLocalizedString(@"Register", nil) forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"launch-startbutton-bg"] forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _registerButton.hidden = YES;
    [self.view addSubview:_registerButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.selectCityButton = nil;
    self.startButton = nil;
    self.loginButton = nil;
    self.registerButton = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
//    [self tryLogin];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Account control delegate

- (void)accountControlDidLogin
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    [UIView animateWithDuration:0.3f animations:^{
        [_startButton setTitle:@"Login success. " forState:UIControlStateNormal];
    }];
    [self.navigationController.view removeFromSuperview];
}

- (void)accountControlDidFailLoginWithReason:(NSString *)reason
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed", nil) message:reason delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    [UIView animateWithDuration:0.3f animations:^{
        [_startButton setTitle:@"Try again. " forState:UIControlStateNormal];
    }];
}

#pragma mark - Picker view delegate

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 0;
}

@end
