//
//  Data.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/21/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import "Data.h"
#import "Note.h"

@implementation Data

static NSMutableDictionary *allNotes;
static NSString *currentKey;

+ (NSMutableDictionary *)getAllNotes {
    if (allNotes == nil) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
            allNotes = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        } else {
            allNotes = [[NSMutableDictionary alloc] init];
        }
    }
    return allNotes;
    
}

+ (void)setCurrentKey:(NSString *)key {
    currentKey = key;
}

+ (NSString *)getCurrentKey {
    return currentKey;
}

+ (void)setNoteForCurrentKey:(Note *)note {
    [self setNote:note forKey:currentKey];
}

+ (void)setNote:(Note *)note forKey:(NSString *)key {
    [allNotes setObject:note forKey:key];
}

+ (void)removeNoteForKey:(NSString *)key {
    [allNotes removeObjectForKey:key];
}

+ (void)saveNotesToLocalStorage {
    [NSKeyedArchiver archiveRootObject:allNotes toFile:[self filePath]];
}

+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)filePath {
    return [[self documentPath] stringByAppendingPathComponent:kAllNotes];
}

@end
