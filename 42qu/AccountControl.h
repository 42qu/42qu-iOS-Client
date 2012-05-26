//
//  AccountControl.h
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginView.h"

@protocol AccountControlDelegate <NSObject>

- (void)didLogin;
- (void)didFailLogin;

@end

@interface AccountControl : NSObject </*NSURLConnectionDelegate, */LoginViewDelegate>

/*
enum {
    URLConnectionTypeUnknown = 0,
    URLConnectionTypeLogin
}; typedef NSUInteger URLConnectionType;
 */

@property (nonatomic, assign) id<AccountControlDelegate> delegate;

@property (nonatomic, assign) LoginView *loginView;

@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, strong) NSMutableString *userID;
@property (nonatomic, strong) NSMutableString *name;
@property (nonatomic, strong) NSMutableString *accessToken;
@property (nonatomic, strong) NSMutableString *refreshToken;
@property (nonatomic, assign) NSInteger expiresIn;

+ (AccountControl *)shared;

- (void)loginWithMail:(NSString *)mail andPassword:(NSString *)password;
- (void)login;

@end
