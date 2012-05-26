//
//  HTTPUtils.h
//  42qu
//
//  Created by Alex Rezit on 12-5-23.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPUtils : NSObject

+ (NSData *)postDataFromDictionary:(NSDictionary *)dictionary;

@end
