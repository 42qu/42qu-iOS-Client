//
//  RegisterListViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-5-31.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "AppDelegate.h"

#import "RegisterListViewController.h"

#define SNS_42QU @"42qu"
#define SNS_SINA_WEIBO @"weibo"
#define SNS_GOOGLE @"google"
#define SNS_RENREN @"renren"
#define SNS_TENCENT_WEIBO @"tencent"

@interface RegisterListNavigationController ()

@end

@implementation RegisterListNavigationController

#pragma mark - Life cycle

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, [UIScreen mainScreen].applicationFrame.size.height);
    }
    return self;
}

@end

@interface RegisterListViewController ()

@end

@implementation RegisterListViewController

#pragma mark - Animations

- (void)show
{
    // Add to window
    [[(AppDelegate *)[UIApplication sharedApplication].delegate window] addSubview:self.navigationController.view];
    
    // Begin animations
    [UIView animateWithDuration:0.3f animations:^{
        CGRect registerListNavigationControllerFrame = self.navigationController.view.frame;
        registerListNavigationControllerFrame.origin.y -= registerListNavigationControllerFrame.size.height;
        self.navigationController.view.frame = registerListNavigationControllerFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.delegate registerListViewControllerOnShow:self];
        }
    }];
}

- (void)dismiss
{
    // Begin animations
    [UIView animateWithDuration:0.3f animations:^{
        CGRect registerListNavigationControllerFrame = self.navigationController.view.frame;
        registerListNavigationControllerFrame.origin.y += registerListNavigationControllerFrame.size.height;
        self.navigationController.view.frame = registerListNavigationControllerFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.delegate registerListViewControllerOnDismiss:self];
            [self.navigationController.view removeFromSuperview];
        }
    }];
}

#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Choose Accout", nil);
    }
    return self;
}

- (void)dealloc
{
    [_accountList release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)] autorelease];
    self.accountList = [[[NSArray alloc] initWithObjects:SNS_42QU, SNS_SINA_WEIBO, SNS_GOOGLE, SNS_RENREN, SNS_TENCENT_WEIBO, nil] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_accountList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = NSLocalizedString([_accountList objectAtIndex:indexPath.row], nil);
    cell.imageView.image = [UIImage imageNamed:[_accountList objectAtIndex:indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSUInteger row = indexPath.row;
    RegisterViewController *registerViewController = [[[RegisterViewController alloc] init] autorelease];
    registerViewController.delegate = self.delegate;
    registerViewController.title = [_accountList objectAtIndex:row];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

@end
