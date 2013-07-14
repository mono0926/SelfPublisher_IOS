//
//  Section.h
//  SelfPublisher
//
//  Created by mono on 7/15/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SectionBase.h"

@class Chapter;

@interface Section : SectionBase

@property (nonatomic, retain) Chapter *chapter;

@end
