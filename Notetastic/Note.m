//
//  Note.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/20/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import "Note.h"

@implementation Note

@synthesize title;
@synthesize body;
@synthesize picture;

- (id)init {
    if (self = [super init])  {
        self.title = kDefaultTitle;
        self.body = kDefaultBody;
        self.picture = nil;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.title = [decoder decodeObjectForKey:@"title"];
    self.body = [decoder decodeObjectForKey:@"body"];
    self.picture = [decoder decodeObjectForKey:@"picture"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.body forKey:@"body"];
    [encoder encodeObject:self.picture forKey:@"picture"];
}

@end
