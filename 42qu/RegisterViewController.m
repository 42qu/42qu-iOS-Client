//
//  RegisterViewController.m
//  42qu
//
//  Created by Alex on 08/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import "RegisterViewController.h"

#import "RegisterListViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

#pragma mark - 

- (void)loadRegisterWebpage
{
    NSURLRequest *registerRequest = [NSURLRequest requestWithURL:_registerURL];
    [_registerWebView loadRequest:registerRequest];
}

#pragma mark - Animations

- (void)dismiss
{
    [(RegisterListViewController *)[self.navigationController.viewControllers objectAtIndex:0] dismiss];
}

#pragma mark - Actions

- (void)refreshButtonPressed
{
    [self loadRegisterWebpage];
}

#pragma mark - Life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure nav bar buttons
    UIBarButtonItem *backBarButtonItem = [[[UIBarButtonItem alloc] init] autorelease];
    backBarButtonItem.title = @"Back";
    [(RegisterListViewController *)[self.navigationController.viewControllers objectAtIndex:0] navigationItem].backBarButtonItem = backBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed)] autorelease];
    
    // Initialize web view
    self.registerWebView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)] autorelease];
    _registerWebView.delegate = self;
    [self.view addSubview:_registerWebView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadRegisterWebpage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web view delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *responseURL = request.URL;
    NSMutableString *responseString = [[[NSMutableString alloc] initWithString:responseURL.absoluteString] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^api://.*"];
    if ([predicate evaluateWithObject:responseString]) {
        [responseString deleteCharactersInRange:NSMakeRange(0, 6)];
        if ([responseString rangeOfString:@"/"].location != NSNotFound) {
            [responseString deleteCharactersInRange:NSMakeRange([responseString rangeOfString:@"/"].location, responseString.length - [responseString rangeOfString:@"/"].location)];
        }
        NSArray *keysAndValuesArray = [responseString componentsSeparatedByString:@"&"];
        NSString *accessToken = nil;
        NSString *mail = nil;
        NSString *password = nil;
        for (NSString *keyAndValue in keysAndValuesArray) {
            if ([keyAndValue rangeOfString:@"access_token="].location == 0) {
                NSString *accessTokenOrig = [keyAndValue substringFromIndex:13];
                accessToken = [accessTokenOrig stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else if ([keyAndValue rangeOfString:@"mail="].location == 0) {
                NSString *mailOrig = [keyAndValue substringFromIndex:5];
                mail = [mailOrig stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else if ([keyAndValue rangeOfString:@"password="].location == 0) {
                NSString *passwordOrig = [keyAndValue substringFromIndex:9];
                password = [passwordOrig stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
        }
        if (accessToken) {
            [self dismiss];
            if (mail && password && [self.delegate respondsToSelector:@selector(registerViewController:didRegisteredWithAccessToken:mail:password:)]) {
                [self.delegate registerViewController:self didRegisteredWithAccessToken:accessToken mail:mail password:password];
            } else {
                [self.delegate registerViewController:self didRegisteredWithAccessToken:accessToken];
            }
        }
    }
    return YES;
}

@end
