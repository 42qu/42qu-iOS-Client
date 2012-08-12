//
//  CustomTableViewController.h
//  42qu
//
//  Created by Alex on 09/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshHeaderView.h"

@interface CustomTableViewController : UITableViewController <PullRefreshHeaderViewDelegate>

@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) PullRefreshHeaderView *pullRefreshHeaderView;

- (void)loadDataInBackground;
- (void)refreshDataInBackground;

@end
