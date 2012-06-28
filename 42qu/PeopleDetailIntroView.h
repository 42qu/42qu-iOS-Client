//
//  PeopleDetailIntroView.h
//  42qu
//
//  Created by Alex Rezit on 12-6-26.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleDetailIntroView : UIView

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *jobLabel;
@property (nonatomic, strong) UILabel *orgLabel;
@property (nonatomic, strong) UITextView *mottoTextView;

@end
