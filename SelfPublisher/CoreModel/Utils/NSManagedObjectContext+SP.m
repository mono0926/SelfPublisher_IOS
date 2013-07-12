//
//  NSManagedObjectContext+SP.m
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "NSManagedObjectContext+SP.h"
#import "MonoModel.h"

@implementation NSManagedObjectContext (SP)

-(MyProfile*) myProfile {
    return [self single:@"MyProfile" where:nil];
}
-(MyProfile*)createMyProfile {
    MyProfile* myProfile = [self createObject:@"MyProfile"];
    return myProfile;
}
@end
