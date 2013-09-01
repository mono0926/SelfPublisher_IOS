//
//  Book.h
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Chapter, Profile;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSData * coverImage;
@property (nonatomic, retain) NSData * epub;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * mobi;
@property (nonatomic, retain) Profile *author;
@property (nonatomic, retain) NSSet *chapters;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addChaptersObject:(Chapter *)value;
- (void)removeChaptersObject:(Chapter *)value;
- (void)addChapters:(NSSet *)values;
- (void)removeChapters:(NSSet *)values;

@end
