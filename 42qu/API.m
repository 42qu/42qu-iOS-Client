//
//  API.m
//  42qu
//
//  Created by Alex Rezit on 12-5-23.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "API.h"
#import <TSocketClient.h>
#import <TBinaryProtocol.h>

#define API_HOSTNAME @""
#define API_PORT 0

@implementation API

static SnsClient *snsClient = nil;

+ (SnsClient *)shared
{
    if (!snsClient) {
        TSocketClient *transport = [[TSocketClient alloc] initWithHostname:API_HOSTNAME port:API_PORT];
        TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport strictRead:YES strictWrite:YES];
        [transport release];
        snsClient = [[[SnsClient alloc] initWithProtocol:protocol] autorelease];
        [protocol release];
    }
    return snsClient;
}

@end
