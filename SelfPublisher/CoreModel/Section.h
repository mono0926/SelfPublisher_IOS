//
//  Section.h
//  SelfPublisher
//
//  Created by mono on 7/11/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Chapter;

@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) Chapter *chapter;

@end
