//
//  SelfPublishClientBase.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "SelfPublishClientBase.h"
#import "AppSettings.h"

@implementation SelfPublishClientBase
- (id)init
{
    self = [super initWithBaseUrl:AppSettings.baseUrl];
    if (self) {
    }
    return self;
}
@end
