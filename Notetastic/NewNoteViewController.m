//
//  NewNoteViewController.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/23/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import "NewNoteViewController.h"
#import "UIColor+BrandColors.h"

@interface NewNoteViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation NewNoteViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.barTintColor = nil;
    self.navigationController.toolbar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor emeraldColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                                                      NSFontAttributeName: [UIFont fontWithName:@"Montserrat-Bold" size:18.0]}];
    self.navigationController.view.backgroundColor = [UIColor cloudsColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.titleTextField.delegate = self;
    self.titleTextField.returnKeyType = UIReturnKeyDone;
    self.titleTextField.backgroundColor = [UIColor clearColor];
    [self.titleTextField setTextColor:[UIColor darkGrayColor]];
    [self.titleTextField setFont:[UIFont fontWithName:@"Lato-Bold" size:18]];
    self.titleTextField.layer.borderColor = [UIColor clearColor].CGColor;
    self.titleTextField.layer.borderWidth = 0;
    
    self.descriptionTextView.delegate = self;
    self.descriptionTextView.returnKeyType = UIReturnKeyDone;
    self.descriptionTextView.scrollEnabled = NO;
    self.descriptionTextView.backgroundColor = [UIColor clearColor];
    [self.descriptionTextView setTextColor:[UIColor darkGrayColor]];
    [self.descriptionTextView setFont:[UIFont fontWithName:@"Lato-Regular" size:16]];
    
    self.navigationItem.title = @"New Note";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(handleSingleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    [self configureView];
}

- (void)configureView {
    self.titleTextField.text = @"New Note - Title";
    self.descriptionTextView.text = @"";
    [self.descriptionTextView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

@end
