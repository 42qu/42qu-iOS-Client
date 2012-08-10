//
//  RegisterViewController.h
//  42qu
//
//  Created by Alex on 08/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;

@protocol RegisterViewControllerDelegate <NSObject>

- (void)registerViewController:(RegisterViewController *)registerViewController didRegisteredWithAccessToken:(NSString *)accessToken;

@end

@interface RegisterViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, assign) id<RegisterViewControllerDelegate> delegate;

@property (nonatomic, strong) NSURL *registerURL;

@property (nonatomic, strong) UIWebView *registerWebView;

@end
