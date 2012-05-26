//
//  API.h
//  42qu
//
//  Created by Alex Rezit on 12-5-23.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "service.h"

// API Key
#define CLIENT_ID @"10299882"
#define CLIENT_SECRET @"df36723f6bc246f0a485e74ff852a6c3"

/*
// API URL
#define API_ROOT @"http://api.42qu.com"
#define API_AUTH_LOGIN @"/user/oauth/login"
#define API_PO_WORD @"/po/word"

// API Auth
#define API_AUTH_LOGIN_CLIENT_ID @"client_id"
#define API_AUTH_LOGIN_CLIENT_SECRET @"client_secret"
#define API_AUTH_LOGIN_MAIL @"mail"
#define API_AUTH_LOGIN_PASSWORD @"password"

#define API_AUTH_LOGIN_ERROR_CODE @"error_code"
#define API_AUTH_LOGIN_ERROR @"error"

#define API_AUTH_LOGIN_USER_ID @"user_id"
#define API_AUTH_LOGIN_NAME @"name"
#define API_AUTH_LOGIN_ACCESS_TOKEN @"access_token"
#define API_AUTH_LOGIN_REFRESH_TOKEN @"refresh_token"
#define API_AUTH_LOGIN_EXPIRES_IN @"expires_in"

// API Po
#define API_PO_WORD_ACCESS_TOKEN @"access_token"
#define API_PO_WORD_CONTENT @"txt"

#define API_PO_WORD_ID @"id"
#define API_PO_WORD_LINK @"link"
 */

@class SnsClient;

@interface API : NSObject

+ (SnsClient *)shared;

@end
