//
//  RegisterView.m
//  42qu
//
//  Created by Alex Rezit on 12-5-30.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

@synthesize webView = _webView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.webView = [[[UIWebView alloc] initWithFrame:self.frame] autorelease];
        [self addSubview:_webView];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [_webView release];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
