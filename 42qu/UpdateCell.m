//
//  UpdateCell.m
//  42qu
//
//  Created by Alex Rezit on 23/07/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import "UpdateCell.h"

@implementation UpdateCell

@synthesize taskBasic = _taskBasic;
@synthesize userBasic = _userBasic;
@synthesize titleLabel = _titleLabel;
@synthesize distanceLabel = _distanceLabel;
@synthesize introTextView = _introTextView;
@synthesize endTimeLabel = _endTimeLabel;
@synthesize participantLabel = _participantLabel;
@synthesize sponsorView = _sponsorView;
@synthesize sponsorAvatarButton = _sponsorAvatarButton;
@synthesize sponsorNameLabel = _sponsorNameLabel;
@synthesize sponsorJobAndOrgLabel = _sponsorJobAndOrgLabel;
@synthesize publishTimeLabel = _publishTimeLabel;

#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_taskBasic release];
    [_userBasic release];
    [_titleLabel release];
    [_distanceLabel release];
    [_introTextView release];
    [_endTimeLabel release];
    [_participantLabel release];
    [_sponsorView release];
    [_sponsorAvatarButton release];
    [_sponsorNameLabel release];
    [_sponsorJobAndOrgLabel release];
    [_publishTimeLabel release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
