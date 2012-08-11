//
//  AccountControl.h
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginView.h"
#import "RegisterListViewController.h"

@class LaunchViewController;

@interface AccountControl : NSObject <LoginViewDelegate, RegisterListViewControllerDelegate>

@property (nonatomic, assign) UINavigationController *launchNavigationController;
@property (nonatomic, assign) LaunchViewController *launchViewController;
@property (nonatomic, assign) LoginView *loginView;
@property (nonatomic, assign) RegisterListNavigationController *registerListNavigationController;
@property (nonatomic, assign) RegisterListViewController *registerListViewController;

@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, readonly) NSString *mail;
@property (nonatomic, readonly) NSString *password;
@property (nonatomic, readonly) NSInteger userID;
@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSInteger expiresIn;

+ (AccountControl *)shared;

// Account info

- (NSString *)mail;
- (NSString *)password;
- (NSInteger)userID;
- (NSString *)accessToken;
- (NSInteger)expiresIn;

// Account

- (BOOL)tryLogin;

// View

- (void)showLaunchView;
- (void)hideLaunchView;
- (void)showLoginView;
- (void)showRegisterListView;

@end
