//
//  LoginView.h
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@protocol LoginViewDelegate <NSObject>

- (void)loginViewOnShow:(LoginView *)loginView;
- (void)loginViewOnDismiss:(LoginView *)loginView;

- (void)loginView:(LoginView *)loginView onLoginWithMail:(NSString *)mail andPassword:(NSString *)password;

@optional
- (BOOL)onLogout;

- (void)loginViewOnRegisterButtonPressed:(LoginView *)loginView;

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
