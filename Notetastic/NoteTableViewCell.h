//
//  NoteTableViewCell.h
//  Notetastic
//
//  Created by Daniel Garzon on 10/20/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;
@property (weak, nonatomic) IBOutlet UILabel *noteTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteDescriptionLabel;

@end
