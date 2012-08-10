//
//  AccountControl.m
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "AppDelegate.h"
#import "API.h"
#import <TSocketClient.h>
#import <TBinaryProtocol.h>

#import "AccountControl.h"

#import "LaunchViewController.h"

#import "RegisterListViewController.h"

// User Default Key
#define USER_DEFAULT_KEY_MAIL @"AccountMail"
#define USER_DEFAULT_KEY_PASSWORD @"AccountPassword"
#define USER_DEFAULT_KEY_USERID @"AccountUserID"
#define USER_DEFAULT_KEY_ACCESSTOKEN @"AccountAccessToken"
#define USER_DEFAULT_KEY_EXPIRE @"AccountExpire"

@implementation AccountControl

@synthesize isLoggedIn;

static AccountControl *accountControl = nil;

+ (AccountControl *)shared
{
    if (!accountControl) {
        accountControl = [[AccountControl alloc] init];
        accountControl.isLoggedIn = (accountControl.accessToken != nil/* && accountControl.expiresIn > [[NSDate date] timeIntervalSince1970]*/);
    }
    return accountControl;
}

- (void)dealloc
{
    [super dealloc];
}

// Read

- (NSString *)mail
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:USER_DEFAULT_KEY_MAIL];
}

- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:USER_DEFAULT_KEY_PASSWORD];
}

- (NSInteger)userID
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:USER_DEFAULT_KEY_USERID];
}

- (NSString *)accessToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:USER_DEFAULT_KEY_ACCESSTOKEN];
}

- (NSInteger)expiresIn
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:USER_DEFAULT_KEY_EXPIRE];
}

// Set

- (void)saveMail:(NSString *)mail
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:mail forKey:USER_DEFAULT_KEY_MAIL];
    [userDefaults synchronize];
}

- (void)savePassword:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:password forKey:USER_DEFAULT_KEY_PASSWORD];
    [userDefaults synchronize];
}

- (void)saveUserID:(NSInteger)userID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:userID forKey:USER_DEFAULT_KEY_USERID];
    [userDefaults synchronize];
}

- (void)saveAccessToken:(NSString *)accessToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:accessToken forKey:USER_DEFAULT_KEY_ACCESSTOKEN];
    [userDefaults synchronize];
}

- (void)saveExpiresIn:(NSInteger)expiresIn
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:expiresIn forKey:USER_DEFAULT_KEY_EXPIRE];
    [userDefaults synchronize];
}

// Remove

- (void)removeMail
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_DEFAULT_KEY_MAIL];
    [userDefaults synchronize];
}

- (void)removePassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_DEFAULT_KEY_PASSWORD];
    [userDefaults synchronize];
}

- (void)removeUserID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_DEFAULT_KEY_USERID];
    [userDefaults synchronize];
}

- (void)removeAccessToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_DEFAULT_KEY_ACCESSTOKEN];
    [userDefaults synchronize];
}

- (void)removeExpiresIn
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_DEFAULT_KEY_EXPIRE];
    [userDefaults synchronize];
}

#pragma mark - Basic operation

- (void)loginWithMail:(NSString *)mail andPassword:(NSString *)password
{
    [self saveMail:mail];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SnsClient *snsClient = [API newConnection];
        @try {
            AuthRequest *authRequest = [[[AuthRequest alloc] initWithClient_id:CLIENT_ID client_secret:CLIENT_SECRET] autorelease];
            AuthResponse *authResponse = [snsClient login_by_mail:authRequest :mail :password];
            [self saveUserID:authResponse.user_id];
            [self saveAccessToken:authResponse.access_token];
            [self saveExpiresIn:authResponse.expire_in];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self savePassword:password];
                [self.delegate accountControlDidLogin];
            });
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removePassword];
                [self.delegate accountControlDidFailLoginWithReason:exception.reason];
            });
        }
        [API closeConnection];
    });
}

- (void)registerWithSomething
{
    
}

#pragma mark - View operation

- (void)showLoginView
{
    if (!_loginView) {
        self.loginView = [[[LoginView alloc] init] autorelease];
        _loginView.nameField.text = self.mail;
        _loginView.delegate = self;
        [_loginView show];
    }
}

- (void)showRegisterListView
{
    if (!_registerListViewController) {
        self.registerListViewController = [[[RegisterListViewController alloc] init] autorelease];
        _registerListViewController.delegate = self;
        self.registerListNavigationController = [[[RegisterListNavigationController alloc] initWithRootViewController:_registerListViewController] autorelease];
        [_registerListNavigationController retain];
        [_registerListViewController show];
    }
}

#pragma mark - Login view delegate

- (void)loginViewOnShow:(LoginView *)loginView
{
    
}

- (void)loginViewOnDismiss:(LoginView *)loginView
{
    self.loginView = nil;
}

- (void)loginView:(LoginView *)loginView onLoginWithMail:(NSString *)mail andPassword:(NSString *)password
{
    [self loginWithMail:mail andPassword:password];
}

#pragma mark - Register list view controller delegate

- (void)registerListViewControllerOnShow:(RegisterListViewController *)registerListViewController
{
    
}

- (void)registerListViewControllerOnDismiss:(RegisterListViewController *)registerListViewController
{
    [_registerListNavigationController release];
    self.registerListNavigationController = nil;
    self.registerListViewController = nil;
}

#pragma mark - Register view delegate

- (void)registerViewController:(RegisterViewController *)registerViewController didRegisteredWithAccessToken:(NSString *)accessToken
{
    [self saveAccessToken:accessToken];
    [self.delegate accountControlDidLogin];
}

@end
