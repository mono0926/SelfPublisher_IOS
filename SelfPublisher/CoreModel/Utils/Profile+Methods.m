//
//  Profile+Methods.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "Profile+Methods.h"
#import "MonoModel.h"
#import "MonoUI.h"
@implementation Profile (Methods)
-(UIProfile *)uiProfile
{
    if ([self isKindOfClass:MyProfile.class])
    {
        return [[UIMyProfile alloc]initWithProfile:self];
    }
    return [[UIProfile alloc]initWithProfile:self];
}
@end
