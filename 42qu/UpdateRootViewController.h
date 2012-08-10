//
//  UpdateRootViewController.h
//  42qu
//
//  Created by Alex Rezit on 12-5-22.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomTableViewController.h"

@interface UpdateRootViewController : CustomTableViewController

@property (nonatomic, strong) NSMutableArray *updateList;

- (void)publish;

@end
