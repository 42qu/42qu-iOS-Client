//
//  PeopleCell.h
//  42qu
//
//  Created by Alex on 18/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orgLabel;
@property (nonatomic, strong) UILabel *jobLabel;

@end
