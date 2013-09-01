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
- (id)initWithPath:(NSString*)path accessToken:(NSString*)accessToken
{
    self = [super initWithBaseUrl:AppSettings.baseUrl
                             path:path
                      accessToken:accessToken];
    if (self) {
    }
    return self;
}
@end
