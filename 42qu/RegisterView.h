//
//  RegisterView.h
//  42qu
//
//  Created by Alex Rezit on 12-5-30.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterView;

@protocol RegisterViewDelegate <NSObject>

- (void)registerViewOnShow:(RegisterView *)registerView;
- (void)registerViewOnDismiss:(RegisterView *)registerView;

@optional

- (void)registerView:(RegisterView *)registerView onRegisterWithCid:(NSUInteger)cid andAccessToken:(NSString *)accessToken;

@end

@interface RegisterView : UIView

@property (nonatomic, strong) UIWebView *webView;

@end
