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
#import <QuartzCore/QuartzCore.h>

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

#pragma mark - Life cycle

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

#pragma mark - Data control

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

- (BOOL)tryLogin
{
    if (self.accessToken) {
#warning may refresh here
        return YES;
    }
    return NO;
}

- (void)didLogin
{
#warning show success info
    [self performSelector:@selector(hideLaunchView) withObject:nil afterDelay:0.3f];
}

- (void)didFailLoginWithReason:(NSString *)reason
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed", nil) message:reason delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
    [alert release];
    [self showLaunchView];
}

- (void)loginWithMail:(NSString *)mail andPassword:(NSString *)password
{
    [self saveMail:mail];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SnsClient *snsClient = [API newConnection];
        @try {
            AuthResponse *authResponse = [snsClient login_by_mail:CLIENT_ID :CLIENT_SECRET :mail :password];
            [self saveUserID:authResponse.user_id];
            [self saveAccessToken:authResponse.access_token];
            [self saveExpiresIn:authResponse.expire_in];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self savePassword:password];
                [self didLogin];
            });
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removePassword];
                [self didFailLoginWithReason:exception.reason];
            });
        }
        [API closeConnection:snsClient];
    });
}

- (void)registerWithSomething
{
    
}

#pragma mark - View operation

- (void)showLaunchView
{
    if (!_launchViewController) {
        self.launchViewController = [[[LaunchViewController alloc] init] autorelease];
        self.launchNavigationController = [[[UINavigationController alloc] initWithRootViewController:_launchViewController] autorelease];
        [_launchNavigationController retain];
        [[(AppDelegate *)[UIApplication sharedApplication].delegate window].rootViewController.view addSubview:_launchNavigationController.view];
    }
}

- (void)hideLaunchView
{
    if (_launchNavigationController) {
        [UIView animateWithDuration:0.66f animations:^{
            CATransition *transition = [CATransition animation];
            transition.duration = 0.66f;
            transition.type = kCATransitionReveal;
            transition.subtype = kCATransitionFromTop;
            [[(AppDelegate *)[UIApplication sharedApplication].delegate window].rootViewController.view.layer addAnimation:transition forKey:nil];
            [_launchNavigationController.view removeFromSuperview];
        } completion:^(BOOL finished) {
            if (finished) {
                [_launchNavigationController release];
                _launchNavigationController = nil;
                _launchViewController = nil;
            }
        }];
    }
}

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
    [self didLogin];
}

- (void)registerViewController:(RegisterViewController *)registerViewController didRegisteredWithAccessToken:(NSString *)accessToken mail:(NSString *)mail password:(NSString *)password
{
    [self saveAccessToken:accessToken];
    [self saveMail:mail];
    [self savePassword:password];
    [self performSelector:@selector(didLogin) withObject:nil afterDelay:0.3f];
}

@end
