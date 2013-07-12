//
//  Book.h
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Chapter, Profile;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *chpaters;
@property (nonatomic, retain) Profile *author;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addChpatersObject:(Chapter *)value;
- (void)removeChpatersObject:(Chapter *)value;
- (void)addChpaters:(NSSet *)values;
- (void)removeChpaters:(NSSet *)values;

@end
