//
//  Chapter.h
//  SelfPublisher
//
//  Created by mono on 7/11/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book, Section;

@interface Chapter : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSSet *sections;
@property (nonatomic, retain) Book *book;
@end

@interface Chapter (CoreDataGeneratedAccessors)

- (void)addSectionsObject:(Section *)value;
- (void)removeSectionsObject:(Section *)value;
- (void)addSections:(NSSet *)values;
- (void)removeSections:(NSSet *)values;

@end
