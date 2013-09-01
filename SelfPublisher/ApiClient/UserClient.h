//
//  UserClient.h
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "SelfPublishClientBase.h"

@interface UserClient : SelfPublishClientBase

-(void)registerWithName:(NSString*)name
        completionBlock:(void (^)(NSString* accessToken, NSError* error)) completionBlock;

@end
