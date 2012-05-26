//
//  PublishViewController.h
//  42qu
//
//  Created by Alex Rezit on 12-5-22.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishViewController : UIViewController <UITextViewDelegate/*, NSURLConnectionDelegate*/>

@property (nonatomic, strong) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) IBOutlet UILabel *textLengthLabel;

- (void)dismiss;

- (void)cancel;
- (void)done;

@end
