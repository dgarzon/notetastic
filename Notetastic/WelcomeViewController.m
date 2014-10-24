//
//  WelcomeViewController.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/4/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//
#import <Canvas/Canvas.h>
#import "WelcomeViewController.h"
#import "UIColor+BrandColors.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet CSAnimationView *brandView;
@property (weak, nonatomic) IBOutlet UIImageView *brandLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *brandTitleLabel;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor emeraldColor];
    self.brandView.backgroundColor = [UIColor clearColor];
    
    self.brandTitleLabel.text = @"Notetastic";
    self.brandTitleLabel.textColor = [UIColor cloudsColor];
    self.brandTitleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:32];
    
    self.brandLogoImageView.image = [UIImage imageNamed:@"brandLogo"];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"segueNotes" sender:self];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
