//
//  UIProfile.h
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@class Profile;

@interface UIProfile : MTLModel<MTLJSONSerializing>
{
    Profile* _profile;
}
@property (nonatomic, readonly) NSString* name;
- (id)initWithProfile:(Profile*)profile;
@end
