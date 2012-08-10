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

@interface LaunchViewController : UIViewController <AccountControlDelegate>

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;

- (void)loginButtonPressed;
- (void)registerButtonPressed;

@end
