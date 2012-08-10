//
//  CustomTableViewController.m
//  42qu
//
//  Created by Alex on 09/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import "CustomTableViewController.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

#pragma mark - Data control

// For override: DO NOT MODIFY!!! MUST OVERRIDE THEM IN CHILD CLASS!!!
- (void)loadData
{
    NSLog(@"Custom Table View Controller: You have to override this method. ");
}

- (void)refreshData
{
    NSLog(@"Custom Table View Controller: You have to override this method. ");
}

// Active
- (void)loadDataInBackground
{
    [self dataWillBeginLoading];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dataDidStopLoading];
        });
    });
}

- (void)refreshDataInBackground
{
    [self dataWillBeginRefreshing];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self refreshData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dataDidStopRefreshing];
        });
    });
}

// Passive

- (void)dataWillBeginLoading
{
    self.isLoading = YES;
}

- (void)dataDidStopLoading
{
    self.isLoading = NO;
}

- (void)dataWillBeginRefreshing
{
    self.isRefreshing = YES;
}

- (void)dataDidStopRefreshing
{
    self.isRefreshing = NO;
    [_pullRefreshHeaderView pullRefreshScrollViewDidFinishLoading:self.tableView];
}

#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.isRefreshing = NO;
        self.isLoading = NO;
        
        self.pullRefreshHeaderView = [[[PullRefreshHeaderView alloc] initWithFrame:CGRectMake(0, 0 - self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)] autorelease];
        _pullRefreshHeaderView.delegate = self;
        [self.tableView addSubview:_pullRefreshHeaderView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_pullRefreshHeaderView pullRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_pullRefreshHeaderView pullRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - Pull refresh header view delegate

- (void)pullRefreshHeaderViewDidTriggerRefresh:(PullRefreshHeaderView *)pullRefreshHeaderView
{
    [self refreshDataInBackground];
}

- (BOOL)pullRefreshHeaderViewIsRefreshing
{
    return _isRefreshing;
}

@end
