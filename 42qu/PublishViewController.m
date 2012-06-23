//
//  PublishViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-5-22.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "PublishViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "HTTPUtils.h"
#import "API.h"
//#import "SBJson.h"
#import "AccountControl.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

@synthesize contentTextView = _contentTextView;
@synthesize textLengthLabel = _textLengthLabel;

#pragma mark - Animation

- (void)dismiss
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.contentTextView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Operation

- (void)cancel
{
    [self dismiss];
}

- (void)done
{
    /*
    // Create login API URL
    NSString *loginURLString = [NSString stringWithFormat:@"%@%@", API_ROOT, API_PO_WORD];
    NSURL *loginURL = [NSURL URLWithString:loginURLString];
    // Create login Request
    NSMutableURLRequest *loginRequest = [[NSMutableURLRequest alloc] initWithURL:loginURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f];
    // Create post data
    NSString *content = [NSString stringWithFormat:@"%@%@", _contentTextView.text, @"\n--- 来自42qu.com iOS客户端(http://seymourdev.com/product)"];
    NSDictionary *postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AccountControl shared].accessToken, API_PO_WORD_ACCESS_TOKEN, content, API_PO_WORD_CONTENT, nil];
    NSData *loginPostData = [HTTPUtils postDataFromDictionary:postDataDictionary];
    [loginRequest setHTTPBody:loginPostData];
    [loginRequest setHTTPMethod:@"POST"];
    // Set up connection
    NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:loginRequest delegate:self] autorelease];
    [loginRequest release];
    
    if (connection) {
    }
     */
    [self dismiss];
}

#pragma mark - Life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Publish", nil);
    }
    return self;
}

- (void)dealloc
{
    [_contentTextView release];
    [_textLengthLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    // Register keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightChanged:) name:UIKeyboardDidShowNotification object:nil];
    // Load view
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)] autorelease];
    [super viewDidLoad];
    _contentTextView.delegate = self;
    [_contentTextView becomeFirstResponder];
}

- (void)viewDidUnload
{
    // Remove keyboard notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [super viewDidUnload];
    self.contentTextView = nil;
    self.textLengthLabel = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Text view delegate

- (void)textViewDidChange:(UITextView *)textView
{
    // Calculate ASCII length of the text
    NSUInteger textLength = 0;
    for (NSUInteger i = 0; i < textView.text.length; i++) {
        unichar uc = [textView.text characterAtIndex:i];
        textLength += isascii(uc)?1:2;
    }
    // Set publish button status & text color
    if (textLength > 278) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        _textLengthLabel.textColor = [UIColor redColor];
    } else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        _textLengthLabel.textColor = [UIColor lightGrayColor];
    }
    // Set text length label status
    BOOL originalStatus = _textLengthLabel.hidden;
    if (textLength > 250) {
        _textLengthLabel.hidden = NO;
        _textLengthLabel.text = [NSString stringWithFormat:@"%d/139", (textLength+1)/2];
    } else {
        _textLengthLabel.hidden = YES;
    }
    // Change the position of content text view
    if (originalStatus != _textLengthLabel.hidden) {
        CGRect contentTextViewFrame = _contentTextView.frame;
        if (originalStatus && !_textLengthLabel.hidden) {
            contentTextViewFrame.size.height -= (_textLengthLabel.frame.size.height + 9.0);
        } else if (!originalStatus && _textLengthLabel.hidden) {
            contentTextViewFrame.size.height += (_textLengthLabel.frame.size.height + 9.0);
        }
        _contentTextView.frame = contentTextViewFrame;
        // Fit the position of text length indicator
        CGRect textLengthLabelFrame = _textLengthLabel.frame;
        textLengthLabelFrame.origin.x = _contentTextView.frame.origin.x + _contentTextView.frame.size.width - _textLengthLabel.frame.size.width - 6.0;
        textLengthLabelFrame.origin.y = _contentTextView.frame.origin.y + _contentTextView.frame.size.height + 3.0;
        _textLengthLabel.frame = textLengthLabelFrame;
    }
}

/*
#pragma mark - URL connection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *responseDictionary = [jsonParser objectWithData:data];
    [jsonParser release];
    if ([responseDictionary.allKeys containsObject:API_PO_WORD_ID]) {
    } else {
        NSLog(@"Failed posting");
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Failed posting");
}
 */

#pragma mark - Keyboard notification

- (void)keyboardHeightChanged:(NSNotification *)notification
{
    [UIView animateWithDuration:0.2f animations:^{
        // Get the height of application & navigation bar & keyboard height
        CGFloat applicationHeight = [UIScreen mainScreen].applicationFrame.size.height;
        CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
        NSDictionary *info = notification.userInfo;
        NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGFloat keyboardHeight = value.CGRectValue.size.height;
        // Fit the height of text view
        CGRect contentTextViewFrame = _contentTextView.frame;
        contentTextViewFrame.size.height = applicationHeight - navigationBarHeight - keyboardHeight;
        contentTextViewFrame.size.height -= _textLengthLabel.hidden?0:(_textLengthLabel.frame.size.height+9.0);
        _contentTextView.frame = contentTextViewFrame;
        // Fit the position of text length indicator
        CGRect textLengthLabelFrame = _textLengthLabel.frame;
        textLengthLabelFrame.origin.x = _contentTextView.frame.origin.x + _contentTextView.frame.size.width - _textLengthLabel.frame.size.width - 6.0;
        textLengthLabelFrame.origin.y = _contentTextView.frame.origin.y + _contentTextView.frame.size.height + 3.0;
        _textLengthLabel.frame = textLengthLabelFrame;
    }];
}

@end
