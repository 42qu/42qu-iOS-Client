//
//  PeopleDetailIntroView.m
//  42qu
//
//  Created by Alex Rezit on 12-6-26.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import "PeopleDetailIntroView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PeopleDetailIntroView

@synthesize coverImageView = _coverImageView;
@synthesize avatarImageView = _avatarImageView;
@synthesize nameLabel = _nameLabel;
@synthesize jobLabel = _jobLabel;
@synthesize orgLabel = _orgLabel;
@synthesize mottoTextView = _mottoTextView;

#pragma mark - Draw

- (void)drawDividerLineInContext:(CGContextRef)context
{
    CGContextSetRGBStrokeColor(context, 0.6, 0.6, 0.6, 1.0);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, 50, 280);
    CGContextAddLineToPoint(context, 270, 280);
    CGContextStrokePath(context);
}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code

 }
 */

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawDividerLineInContext:context];
}

- (void)dealloc
{
    [_coverImageView release];
    [_avatarImageView release];
    [_nameLabel release];
    [_jobLabel release];
    [_orgLabel release];
    [_mottoTextView release];
    [super dealloc];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.backgroundColor = [UIColor colorWithWhite:0.83 alpha:1.0];
    
    // Add cover
    self.coverImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 230.0f)] autorelease];
    if (YES) {
        _coverImageView.image = [UIImage imageNamed:@"Default"];
    }
    [self addSubview:_coverImageView];
    
    // Add name label
    self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 150, 150, 40)] autorelease];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textAlignment = UITextAlignmentRight;
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.text = @"Alex";
    _nameLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    _nameLabel.shadowColor = [UIColor lightGrayColor];
    [self addSubview:_nameLabel];
    
    // Add job label
    UIView *jobLabelBackgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 190, 320, 40)] autorelease];
    jobLabelBackgroundView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    [self addSubview:jobLabelBackgroundView];
    self.jobLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 190, 150, 40)] autorelease];
    _jobLabel.backgroundColor = [UIColor clearColor];
    _jobLabel.textAlignment = UITextAlignmentRight;
    _jobLabel.adjustsFontSizeToFitWidth = YES;
    _jobLabel.textColor = [UIColor whiteColor];
    _jobLabel.text = @"应用程序开发工程师";
    _jobLabel.shadowColor = [UIColor darkGrayColor];
    [self addSubview:_jobLabel];
    
    // Add avatar
    UIView *avatarFrameView = [[[UIView alloc] initWithFrame:CGRectMake(170, 130, 130, 130)] autorelease];
    avatarFrameView.layer.borderWidth = 5.0f;
    avatarFrameView.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.2f].CGColor;
    avatarFrameView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    avatarFrameView.layer.shadowOpacity = 1.0f;
    [self addSubview:avatarFrameView];
    self.avatarImageView = [[[UIImageView alloc] initWithFrame:CGRectInset(avatarFrameView.frame, 5.0f, 5.0f)] autorelease];
    _avatarImageView.image = [UIImage imageNamed:@"untitled.jpg"];
    [self addSubview:_avatarImageView];
    
    // Add org label
    self.orgLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 235, 110, 25)];
    _orgLabel.backgroundColor = [UIColor clearColor];
    _orgLabel.textAlignment = UITextAlignmentRight;
    _orgLabel.adjustsFontSizeToFitWidth = YES;
    _orgLabel.textColor = [UIColor darkGrayColor];
    _orgLabel.text = @"@ 42区";
    _orgLabel.shadowColor = [UIColor lightGrayColor];
    [self addSubview:_orgLabel];
    
    // Add motto text view
    self.mottoTextView = [[[UITextView alloc] initWithFrame:CGRectMake(20, 280, 300, 55)] autorelease];
    _mottoTextView.editable = NO;
    _mottoTextView.backgroundColor = [UIColor clearColor];
    _mottoTextView.textColor = [UIColor darkGrayColor];
    _mottoTextView.font = [_mottoTextView.font fontWithSize:16];
    _mottoTextView.text = @"Be the change you want to see in the world. ";
    [self addSubview:_mottoTextView];
}

@end
