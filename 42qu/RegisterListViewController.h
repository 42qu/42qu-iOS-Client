//
//  RegisterListViewController.h
//  42qu
//
//  Created by Alex Rezit on 12-5-31.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RegisterViewController.h"

@interface RegisterListNavigationController : UINavigationController

@end

@class RegisterListViewController;

@protocol RegisterListViewControllerDelegate <RegisterViewControllerDelegate>

- (void)registerListViewControllerOnShow:(RegisterListViewController *)registerListViewController;
- (void)registerListViewControllerOnDismiss:(RegisterListViewController *)registerListViewController;

@end

@interface RegisterListViewController : UITableViewController

@property (nonatomic, assign) id<RegisterListViewControllerDelegate> delegate;

@property (nonatomic, strong) NSArray *accountList;

- (void)show;
- (void)dismiss;

@end
