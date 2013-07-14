//
//  SectionBase.h
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SectionBase : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * caption;

@end
