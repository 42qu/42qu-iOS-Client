//
//  AccountControl.m
//  Lugo
//
//  Created by Alex Rezit on 12-3-27.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <TSocketClient.h>
#import <TBinaryProtocol.h>
//#import "SBJson.h"
//#import "HTTPUtils.h"
#import "API.h"

#import "AppDelegate.h"
#import "AccountControl.h"

// User Default Key
#define USER_DEFAULT_KEY_MAIL @"mail"
#define USER_DEFAULT_KEY_PASSWORD @"password"

@implementation AccountControl

//static URLConnectionType connectionType = URLConnectionTypeUnknown;

@synthesize delegate = _delegate;

@synthesize loginView = _loginView;

@synthesize isLoggedIn;
@synthesize userID;
@synthesize name;
@synthesize accessToken;
@synthesize refreshToken;
@synthesize expiresIn;

static AccountControl *accountControl = nil;

+ (AccountControl *)shared
{
    if (!accountControl) {
        accountControl = [AccountControl new];
        accountControl.userID = [[NSMutableString alloc] init];
        accountControl.name = [[NSMutableString alloc] init];
        accountControl.accessToken = [[NSMutableString alloc] init];
        accountControl.refreshToken = [[NSMutableString alloc] init];
    }
    return accountControl;
}

#pragma mark - Basic operation

- (BOOL)loginWithMail:(NSString *)mail andPassword:(NSString *)password
{
    /*
    // Create login API URL
    NSString *loginURLString = [NSString stringWithFormat:@"%@%@", API_ROOT, API_AUTH_LOGIN];
    NSURL *loginURL = [NSURL URLWithString:loginURLString];
    // Create login Request
    NSMutableURLRequest *loginRequest = [[NSMutableURLRequest alloc] initWithURL:loginURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f];
    // Create post data
    NSDictionary *postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:mail, API_AUTH_LOGIN_MAIL, password, API_AUTH_LOGIN_PASSWORD, CLIENT_ID, API_AUTH_LOGIN_CLIENT_ID, CLIENT_SECRET, API_AUTH_LOGIN_CLIENT_SECRET, nil];
    NSData *loginPostData = [HTTPUtils postDataFromDictionary:postDataDictionary];
    [loginRequest setHTTPBody:loginPostData];
    [loginRequest setHTTPMethod:@"POST"];
    // Set up connection
    NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:loginRequest delegate:self] autorelease];
    connectionType = URLConnectionTypeLogin;
    [loginRequest release];
    
    if (connection) {
    }
     */
    SnsClient *snsClient = [API shared];
    AuthResponse *authResponse = nil;
    @try {
        AuthRequestMail *authRequestMail = [[[AuthRequestMail alloc] initWithClient_id:CLIENT_ID client_secret:CLIENT_SECRET mail:mail password:password] autorelease];
        authResponse = [snsClient login_by_mail:authRequestMail];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        return NO;
    }
    return YES;
}

- (void)login
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mail = [userDefaults stringForKey:USER_DEFAULT_KEY_MAIL];
    NSString *password = [userDefaults stringForKey:USER_DEFAULT_KEY_PASSWORD];
    if (!mail || !password) {
        if (!_loginView) {
            self.loginView = [[[LoginView alloc] init] autorelease];
            _loginView.delegate = self;
            AppDelegate *delegate = (AppDelegate *)self.delegate;
            [delegate.window addSubview:_loginView];
        }
        [_loginView show];
        return;
    }
    if ([self loginWithMail:mail andPassword:password]) {
        [self.delegate didLogin];
    } else {
        [self.delegate didFailLogin];
    }
}

#pragma mark - Login view delegate

static NSUInteger i = 0;

- (void)onShow
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mail = [userDefaults stringForKey:USER_DEFAULT_KEY_MAIL];
    if ([self respondsToSelector:@selector(mailDisplay:)]) {
        i = mail.length;
        [self performSelector:@selector(mailDisplay:) withObject:mail];
    } else {
        _loginView.nameField.text = mail;
    }
}

/*
// The easter egg
- (void)mailDisplay:(NSString *)mail
{
    if (i == 0) {
        return;
    } else {
        [UIView animateWithDuration:0.003 animations:^{
            i--;
            NSMutableString *mailDisplay = [NSMutableString stringWithString:_loginView.nameField.text];
            [mailDisplay appendFormat:@"%c", [mail characterAtIndex:mail.length - 1 - i]];
            _loginView.nameField.text = mailDisplay;
        } completion:^(BOOL finished) {
            [self mailDisplay:mail];
        }];
    }
}
 */

- (void)onDismiss
{
    _loginView = nil;
}

- (void)onLogin
{
    NSString *mail = _loginView.nameField.text;
    NSString *password = _loginView.passwordField.text;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:mail forKey:USER_DEFAULT_KEY_MAIL];
    [userDefaults setValue:password forKey:USER_DEFAULT_KEY_PASSWORD];
    [self performSelector:@selector(login) withObject:nil afterDelay:0.1];
}

/*
#pragma mark - URL connection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    switch (connectionType) {
        case URLConnectionTypeLogin: {
            // Set values to default
            isLoggedIn = NO;
            [userID setString:@""];
            [name setString:@""];
            [accessToken setString:@""];
            [refreshToken setString:@""];
            expiresIn = 0;
            // Parse json data
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            NSDictionary *responseDataDictionary = [jsonParser objectWithData:data];
            [jsonParser release];
            if ([responseDataDictionary.allKeys containsObject:API_AUTH_LOGIN_ACCESS_TOKEN]) {
                // Success
                isLoggedIn = YES;
                [userID appendFormat:@"%d", [responseDataDictionary objectForKey:API_AUTH_LOGIN_USER_ID]];
                [name appendFormat:@"%@", [responseDataDictionary objectForKey:API_AUTH_LOGIN_NAME]];
                [accessToken appendFormat:@"%@", [responseDataDictionary objectForKey:API_AUTH_LOGIN_ACCESS_TOKEN]];
                [refreshToken appendFormat:@"%@", [responseDataDictionary objectForKey:API_AUTH_LOGIN_REFRESH_TOKEN]];
                expiresIn = [[responseDataDictionary objectForKey:API_AUTH_LOGIN_EXPIRES_IN] integerValue];
                [self.delegate didLogin];
            } else {
                // Failed
                if ([responseDataDictionary.allKeys containsObject:API_AUTH_LOGIN_ERROR_CODE]) {
                    NSLog(@"Error code: %@\nError discription: %@", [responseDataDictionary objectForKey:API_AUTH_LOGIN_ERROR_CODE], [responseDataDictionary objectForKey:API_AUTH_LOGIN_ERROR]);
                }
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:USER_DEFAULT_KEY_PASSWORD];
                [self.delegate didFailLogin];
            }
            connectionType = URLConnectionTypeUnknown;
            break;
        }
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate didFailLogin];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_DEFAULT_KEY_PASSWORD];
}
 */

@end
