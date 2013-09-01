//
//  UIMyProfile.m
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIMyProfile.h"
#import "MonoUI.h"


@interface UIMyProfile ()
@property (nonatomic) NSString* accessToken;
@end

@implementation UIMyProfile

-(NSString *)accessToken
{
    return self.myProfile.accessToken;
}

-(MyProfile*)myProfile
{
    return (MyProfile*)_profile;
}

@end
