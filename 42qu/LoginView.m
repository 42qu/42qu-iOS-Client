//
//  LoginView.m
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "AccountControl.h"

#import "LoginView.h"

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

- (void)login
{
    [self.delegate onLogin];
    [self dismiss];
}

- (void)register
{
    if ([self.delegate respondsToSelector:@selector(onRegister)]) {
        [self.delegate onRegister];
    }
    [self dismiss];
}

#pragma mark - Animation

- (void)show
{
    // Register keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightChanged:) name:UIKeyboardDidShowNotification object:nil];
    // Begin animations
    [UIView animateWithDuration:0.35f animations:^{
        CGRect loginViewFrame = kFrameLoginViewOrigin;
        loginViewFrame.origin.y += loginViewFrame.size.height;
        [self setFrame:loginViewFrame];
        [_nameField becomeFirstResponder];
    } completion:^(BOOL finished) {
        [self.delegate onShow];
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
        [self setFrame:kFrameLoginViewOrigin];
    } completion:^(BOOL finished) {
        [self.delegate onDismiss];
        [self removeFromSuperview];
    }];
    // Remove keyboard notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:kFrameLoginViewOrigin];
    if (self) {
        // Set background image and add logo
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBG.png"]];
        self.logoView = [[[UIImageView alloc] initWithFrame:kFrameImageViewLogo] autorelease];
        _logoView.image = [UIImage imageNamed:@"logo.png"];
        [self addSubview:_logoView];
        
        // Add elements
        self.nameField = [[[UITextField alloc] initWithFrame:kFrameTextFieldName] autorelease];
        _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_nameField setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.8f]];
        [_nameField setBorderStyle:UITextBorderStyleRoundedRect];
        _nameField.placeholder = NSLocalizedString(@"Enter your email address", nil);
        [_nameField setKeyboardType:UIKeyboardTypeEmailAddress];
        [_nameField setReturnKeyType:UIReturnKeyNext];
        [_nameField addTarget:self action:@selector(jumpToNextField) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addSubview:_nameField];
        
        self.passwordField = [[[UITextField alloc] initWithFrame:kFrameTextFieldPassword] autorelease];
        _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_passwordField setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.8f]];
        [_passwordField setBorderStyle:UITextBorderStyleRoundedRect];
        _passwordField.placeholder = NSLocalizedString(@"Enter your password", nil);
        [_passwordField setReturnKeyType:UIReturnKeyDone];
        _passwordField.secureTextEntry = YES;
        [_passwordField addTarget:self action:@selector(login) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addSubview:_passwordField];
        
        self.registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_registerButton setFrame:kFrameButtonRegister];
        [_registerButton setAlpha:0.8f];
        [_registerButton setTitle:NSLocalizedString(@"Register", nil) forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(register) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerButton];
        
        self.otherLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_otherLoginButton setFrame:kFrameButtonOtherLogin];
        [_otherLoginButton setAlpha:0.8f];
        [_otherLoginButton setTitle:NSLocalizedString(@"Use other accounts", nil) forState:UIControlStateNormal];
        [self addSubview:_otherLoginButton];
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
