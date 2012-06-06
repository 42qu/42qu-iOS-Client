//
//  LaunchViewController.h
//  42qu
//
//  Created by Alex Rezit on 12-6-1.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AccountControl.h"
#import "LoginView.h"
#import "RegisterView.h"

@interface LaunchViewController : UIViewController <AccountControlDelegate, LoginViewDelegate, RegisterViewDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>

@property (nonatomic, assign) LoginView *loginView;

@property (nonatomic, strong) UIButton *selectCityButton;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;

- (void)selectCityButtonPressed;
- (void)startButtonPressed;
- (void)loginButtonPressed;
- (void)registerButtonPressed;

@end
