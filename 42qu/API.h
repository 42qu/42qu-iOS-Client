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
#define CLIENT_ID 16
#define CLIENT_SECRET @"t7SmSdquS-idUgwmZDavxQ"

@class SnsClient;

@interface API : NSObject

+ (SnsClient *)newConnection;
+ (void)closeConnection;

@end
