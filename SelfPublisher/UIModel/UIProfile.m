//
//  UIProfile.m
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIProfile.h"
#import "MonoUI.h"
@interface UIProfile ()
@property (nonatomic) NSString* name;
@end

@implementation UIProfile
- (id)initWithProfile:(Profile*)profile
{
    self = [super init];
    if (self) {
        _profile = profile;
    }
    return self;
}

-(NSString *)name {
    return _profile.name;
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

@end
