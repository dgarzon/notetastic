//
//  NoteTableViewCell.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/20/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import "NoteTableViewCell.h"
#import "UIColor+BrandColors.h"

@interface NoteTableViewCell()

@end

@implementation NoteTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    
    [self.noteTitleLabel setTextColor:[UIColor darkGrayColor]];
    [self.noteTitleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:18]];
    
    [self.noteDescriptionLabel setTextColor:[UIColor lightGrayColor]];
    [self.noteDescriptionLabel setFont:[UIFont fontWithName:@"Lato-Light" size:16]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
