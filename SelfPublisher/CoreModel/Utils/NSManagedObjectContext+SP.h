//
//  NSManagedObjectContext+SP.h
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <CoreData/CoreData.h>
@class MyProfile;

@interface NSManagedObjectContext (SP)
-(MyProfile*) myProfile;

-(MyProfile*)createMyProfile;
@end
