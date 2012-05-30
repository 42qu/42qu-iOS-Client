//
//  LoginView.h
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFrameLoginViewOrigin CGRectMake(0, -224, 320, 244)

@protocol LoginViewDelegate <NSObject>

- (void)onLogin;

- (void)onShow;
- (void)onDismiss;

@optional
- (BOOL)onLogout;

- (void)onRegister;

@end

@interface LoginView : UIView <UITextFieldDelegate>

@property (nonatomic, assign) id<LoginViewDelegate> delegate;
@property (nonatomic) BOOL isLoggedIn;

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *otherLoginButton;

- (void)jumpToNextField;

- (void)login;
- (void)register;

- (void)show;
- (void)dismiss;

@end
