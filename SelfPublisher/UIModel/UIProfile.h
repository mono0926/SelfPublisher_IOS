//
//  UIProfile.h
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Profile;

@interface UIProfile : NSObject
@property (nonatomic, readonly) NSString* name;
- (id)initWithProfile:(Profile*)profile;
@end
