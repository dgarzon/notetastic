//
//  Note.h
//  Notetastic
//
//  Created by Daniel Garzon on 10/20/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

static NSString *const kDefaultTitle = @"[No Title]";
static NSString *const kDefaultBody = @"[No Description]";
static NSString *const kDefaultImage = @"defaultImage";

@interface Note : NSObject<NSCoding>

@property (strong, readwrite) NSString *title;
@property (strong, readwrite) NSString *body;
@property (strong) UIImage *picture;

@end
