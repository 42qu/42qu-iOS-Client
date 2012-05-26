//
//  HTTPUtils.m
//  42qu
//
//  Created by Alex Rezit on 12-5-23.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "HTTPUtils.h"

@implementation HTTPUtils

+ (NSData *)postDataFromDictionary:(NSDictionary *)dictionary
{
    NSMutableString *postString = [NSMutableString string];
    for (NSString *key in dictionary.allKeys) {
        NSString *value = [dictionary objectForKey:key];
        NSString *encodedValue = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [postString appendFormat:@"%@=%@", key, encodedValue];
        [postString appendString:@"&"];
    }
    [postString deleteCharactersInRange:NSMakeRange(postString.length-1, 1)];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    return postData;
}

@end
