//
//  NewNoteViewController.h
//  Notetastic
//
//  Created by Daniel Garzon on 10/23/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteDetailViewController.h"

@interface NewNoteViewController :  UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end
