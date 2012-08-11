//
//  AppDelegate.h
//  42qu
//
//  Created by Alex Rezit on 12-5-22.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) UINavigationController *updateNavigationController;
@property (strong, nonatomic) UINavigationController *notificationNavigationController;
@property (strong, nonatomic) UINavigationController *peopleNavigationController;
@property (strong, nonatomic) UINavigationController *profileNavigationController;

@end
