//
//  MyProfile.h
//  SelfPublisher
//
//  Created by mono on 9/7/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Profile.h"


@interface MyProfile : Profile

@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic, retain) NSNumber * isDropboxEnabled;

@end
