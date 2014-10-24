//
//  Data.h
//  Notetastic
//
//  Created by Daniel Garzon on 10/21/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Note;

static NSString *const kAllNotes = @"notes.txt";
static NSString *const kNoteDetailView = @"noteDetailViewSegue";

@interface Data : NSObject

+ (NSMutableDictionary *)getAllNotes;
+ (void)setCurrentKey:(NSString *)key;
+ (NSString *)getCurrentKey;
+ (void)setNoteForCurrentKey:(Note *)note;
+ (void)setNote:(Note *)note forKey:(NSString *)key;
+ (void)removeNoteForKey:(NSString *)key;
+ (void)saveNotesToLocalStorage;
+ (NSString *)filePath;
+ (NSString *)documentPath;

@end
