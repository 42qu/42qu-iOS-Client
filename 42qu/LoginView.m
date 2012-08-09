//
//  LoginView.m
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginView.h"

#import "AccountControl.h"

#define kFrameLoginViewOrigin CGRectMake(0, -244, 320, 244)

#define kHeightLogo 60.0
#define kHeightField 31.0
#define kHeightButton 37.0

#define kFrameImageViewLogo CGRectMake(55, 25, 210, kHeightLogo)
#define kFrameTextFieldName CGRectMake(30, 110, 260, kHeightField)
#define kFrameTextFieldPassword CGRectMake(30, 151, 260, kHeightField)
#define kFrameButtonRegister CGRectMake(30, 192, 75, kHeightButton)
#define kFrameButtonOtherLogin CGRectMake(115, 192, 175, kHeightButton)

@implementation LoginView

@synthesize delegate = _delegate;
@synthesize isLoggedIn = _isLoggedIn;

@synthesize logoView = _logoView;
@synthesize nameField = _nameField;
@synthesize passwordField = _passwordField;
@synthesize registerButton = _registerButton;
@synthesize otherLoginButton = _otherLoginButton;

- (void)jumpToNextField
{
    [_nameField resignFirstResponder];
    [_passwordField becomeFirstResponder];
}

#pragma mark - Delegate

- (void)loginButtonPressed
{
    [self.delegate loginView:self onLoginWithMail:_nameField.text andPassword:_passwordField.text];
    [self dismiss];
}

- (void)registerButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(loginViewOnRegisterButtonPressed:)]) {
        [self.delegate loginViewOnRegisterButtonPressed:self];
    }
    [self dismiss];
}

#pragma mark - Animations

- (void)show
{
    // Add to window
    [[(AppDelegate *)[UIApplication sharedApplication].delegate window] addSubview:self];
    
    // Register keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightChanged:) name:UIKeyboardDidShowNotification object:nil];
    
    // Begin animations
    [UIView animateWithDuration:0.35f animations:^{
        CGRect loginViewFrame = self.frame;
        loginViewFrame.origin.y += loginViewFrame.size.height;
        [self setFrame:loginViewFrame];
        [_nameField becomeFirstResponder];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.delegate loginViewOnShow:self];
        }
    }];
}

- (void)dismiss
{
    // Hide keyboard
    for (UIView *oneView in self.subviews) {
        if ([oneView isFirstResponder]) {
            [oneView resignFirstResponder];
            break;
        }
    }
    
    // Begin animations
    [UIView animateWithDuration:0.3f animations:^{
        CGRect loginViewFrame = self.frame;
        loginViewFrame.origin.y -= loginViewFrame.size.height;
        [self setFrame:loginViewFrame];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.delegate loginViewOnDismiss:self];
            [self removeFromSuperview];
        }
    }];
    
    // Remove keyboard notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:kFrameLoginViewOrigin];
    if (self) {
        if (![UIApplication sharedApplication].statusBarHidden) {
            CGRect frame = self.frame;
            frame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
            self.frame = frame;
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_logoView release];
    [_nameField release];
    [_passwordField release];
    [_registerButton release];
    [_otherLoginButton release];
    [super dealloc];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    // Set background image and add logo
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login-bg"]];
    self.logoView = [[[UIImageView alloc] initWithFrame:kFrameImageViewLogo] autorelease];
    _logoView.image = [UIImage imageNamed:@"logo"];
    [self addSubview:_logoView];
    
    // Add elements
    self.nameField = [[[UITextField alloc] initWithFrame:kFrameTextFieldName] autorelease];
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_nameField setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.8f]];
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.placeholder = NSLocalizedString(@"Enter your email address", nil);
    _nameField.keyboardType = UIKeyboardTypeEmailAddress;
    _nameField.returnKeyType = UIReturnKeyNext;
    _nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _nameField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_nameField addTarget:self action:@selector(jumpToNextField) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self addSubview:_nameField];
    
    self.passwordField = [[[UITextField alloc] initWithFrame:kFrameTextFieldPassword] autorelease];
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passwordField setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.8f]];
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordField.placeholder = NSLocalizedString(@"Enter your password", nil);
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.secureTextEntry = YES;
    [_passwordField addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self addSubview:_passwordField];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_registerButton setFrame:kFrameButtonRegister];
    [_registerButton setAlpha:0.8f];
    [_registerButton setTitle:NSLocalizedString(@"Register", nil) forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_registerButton];
    
    self.otherLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_otherLoginButton setFrame:kFrameButtonOtherLogin];
    [_otherLoginButton setAlpha:0.8f];
    [_otherLoginButton setTitle:NSLocalizedString(@"Use other accounts", nil) forState:UIControlStateNormal];
    [self addSubview:_otherLoginButton];
}

#pragma mark - Keyboard notification

- (void)keyboardHeightChanged:(NSNotification *)notification
{
    // Get the height of application & navigation bar & keyboard height
    CGFloat applicationHeight = [UIScreen mainScreen].applicationFrame.size.height;
    NSDictionary *info = notification.userInfo;
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = value.CGRectValue.size.height;
    
    // Fit the height of login view
    CGRect loginViewFrame = self.frame;
    CGFloat loginViewHeight = applicationHeight - keyboardHeight;
    loginViewFrame.size.height = loginViewHeight;
    
    CGFloat spaceHeight = loginViewHeight - kHeightLogo - kHeightField * 2 - kHeightButton;
    
    // Adjust elements origin y
    [UIView animateWithDuration:0.3f animations:^{
        CGRect logoViewFrame = _logoView.frame;
        logoViewFrame.origin.y = spaceHeight * (25.0/85.0);
        _logoView.frame = logoViewFrame;
        
        CGRect nameFieldFrame = _nameField.frame;
        nameFieldFrame.origin.y = spaceHeight * (50.0/85.0) + kHeightLogo;
        _nameField.frame = nameFieldFrame;
        
        CGRect passwordFieldFrame = _passwordField.frame;
        passwordFieldFrame.origin.y = spaceHeight * (60.0/85.0) + kHeightLogo + kHeightField;
        _passwordField.frame = passwordFieldFrame;
        
        CGRect registerButtonFrame = _registerButton.frame;
        registerButtonFrame.origin.y = spaceHeight * (70.0/85.0) + kHeightLogo + kHeightField * 2;
        _registerButton.frame = registerButtonFrame;
        
        CGRect otherLoginButtonFrame = _otherLoginButton.frame;
        otherLoginButtonFrame.origin.y = spaceHeight * (70.0/85.0) + kHeightLogo + kHeightField * 2;
        _otherLoginButton.frame = otherLoginButtonFrame;
    }];
}

@end
