//
//  Chapter.h
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SectionBase.h"

@class Book, Section;

@interface Chapter : SectionBase

@property (nonatomic, retain) Book *book;
@property (nonatomic, retain) NSSet *sections;
@end

@interface Chapter (CoreDataGeneratedAccessors)

- (void)addSectionsObject:(Section *)value;
- (void)removeSectionsObject:(Section *)value;
- (void)addSections:(NSSet *)values;
- (void)removeSections:(NSSet *)values;

@end
