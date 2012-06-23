//
//  LaunchViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-6-1.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"
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

@synthesize loginView = _loginView;

@synthesize selectCityButton = _selectCityButton;
@synthesize startButton = _startButton;
@synthesize loginButton = _loginButton;
@synthesize registerButton = _registerButton;

#pragma mark - Internal methods

- (void)tryLogin
{
    AccountControl *accountControl = [AccountControl shared];
    accountControl.delegate = self;
    [accountControl login];
}

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
    if (!_loginView) {
        self.loginView = [[[LoginView alloc] init] autorelease];
        _loginView.delegate = self;
        [self.view addSubview:_loginView];
    }
    [_loginView show];
}

- (void)showRegisterView // & Account control delegate
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    RegisterListViewController *registerListViewController = [[[RegisterListViewController alloc] init] autorelease];
    [self.navigationController pushViewController:registerListViewController animated:NO];
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
    
    [self tryLogin];
    
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
    self.loginView = nil;
    self.selectCityButton = nil;
    self.startButton = nil;
    self.loginButton = nil;
    self.registerButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Account control delegate

- (void)didLogin
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    [UIView animateWithDuration:0.3f animations:^{
        [_startButton setTitle:@"Login success. " forState:UIControlStateNormal];
    }];
}

- (void)didFailLogin
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    [UIView animateWithDuration:0.3f animations:^{
        [_startButton setTitle:@"Login failed. " forState:UIControlStateNormal];
    }];
}

#pragma mark - Login view delegate

static NSUInteger i = 0;

- (void)loginViewOnShow:(LoginView *)loginView
{
    NSString *mail = [AccountControl savedMail];
    if ([self respondsToSelector:@selector(mailDisplay:)]) {
        i = mail.length;
        [self performSelector:@selector(mailDisplay:) withObject:mail];
    } else {
        _loginView.nameField.text = mail;
    }
}

/*
 // The easter egg
 - (void)mailDisplay:(NSString *)mail
 {
 if (i == 0) {
 return;
 } else {
 [UIView animateWithDuration:0.003 animations:^{
 i--;
 NSMutableString *mailDisplay = [NSMutableString stringWithString:_loginView.nameField.text];
 [mailDisplay appendFormat:@"%c", [mail characterAtIndex:mail.length - 1 - i]];
 _loginView.nameField.text = mailDisplay;
 } completion:^(BOOL finished) {
 [self mailDisplay:mail];
 }];
 }
 }
 */

- (void)loginViewOnDismiss:(LoginView *)loginView
{
    _loginView = nil;
}

- (void)loginView:(LoginView *)loginView onLoginWithMail:(NSString *)mail andPassword:(NSString *)password
{
    [self switchButtonStatus];
    [_startButton setTitle:@"Logging in... " forState:UIControlStateNormal];
    [AccountControl saveMail:mail];
    [AccountControl savePassword:password];
    [[AccountControl shared] performSelector:@selector(login) withObject:nil afterDelay:0.1];
}

- (void)loginViewOnRegisterButtonPressed:(LoginView *)loginView
{
#warning unfinished method
    NSLog(@"Show register view. ");
}

#pragma mark - Register view delegate

- (void)registerViewOnShow:(RegisterView *)registerView
{
    
}

- (void)registerViewOnDismiss:(RegisterView *)registerView
{
    
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
