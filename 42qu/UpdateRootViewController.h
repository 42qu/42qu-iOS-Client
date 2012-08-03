//
//  UpdateRootViewController.h
//  42qu
//
//  Created by Alex Rezit on 12-5-22.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateRootViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *updateList;

- (void)publish;

@end
