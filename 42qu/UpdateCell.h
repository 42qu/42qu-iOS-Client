//
//  UpdateCell.h
//  42qu
//
//  Created by Alex Rezit on 23/07/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskBasic, UserBasic;

@interface UpdateCell : UITableViewCell

@property (nonatomic, strong) TaskBasic *taskBasic;
@property (nonatomic, strong) UserBasic *userBasic;

// Task
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UITextView *introTextView;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *participantLabel;

// Sponsor
@property (nonatomic, strong) UIView *sponsorView;
@property (nonatomic, strong) UIButton *sponsorAvatarButton;
@property (nonatomic, strong) UILabel *sponsorNameLabel;
@property (nonatomic, strong) UILabel *sponsorJobAndOrgLabel;
@property (nonatomic, strong) UILabel *publishTimeLabel;

@end
