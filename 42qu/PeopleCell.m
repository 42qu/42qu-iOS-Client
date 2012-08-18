//
//  PeopleCell.m
//  42qu
//
//  Created by Alex on 18/08/2012.
//  Copyright (c) 2012 Seymour Dev. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
