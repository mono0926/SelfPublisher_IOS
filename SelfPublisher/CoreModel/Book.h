//
//  Book.h
//  SelfPublisher
//
//  Created by mono on 7/11/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Chapter;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSSet *chpaters;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addChpatersObject:(Chapter *)value;
- (void)removeChpatersObject:(Chapter *)value;
- (void)addChpaters:(NSSet *)values;
- (void)removeChpaters:(NSSet *)values;

@end
