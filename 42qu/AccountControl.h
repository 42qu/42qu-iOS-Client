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

@protocol AccountControlDelegate <NSObject>

- (void)accountControlDidLogin;
- (void)accountControlDidFailLoginWithReason:(NSString *)reason;

@end

@interface AccountControl : NSObject <LoginViewDelegate, RegisterListViewControllerDelegate>

@property (nonatomic, assign) id<AccountControlDelegate> delegate;

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

// View

- (void)showLoginView;
- (void)showRegisterListView;

@end
