//
//  UserClient.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UserClient.h"
#import "ApiClient.h"
#import "MonoUI.h"
@implementation UserClient

-(void)registerWithName:(NSString*)name
        completionBlock:(void (^)(NSString* accessToken, NSError* error)) completionBlock
{
    NSString* jsonString = [NSString stringWithFormat:@"{'name':'%@'}", name];
    [self requestAsynchronousWithJsonString:jsonString
                            completionBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                NSError* error = nil;
                                NSDictionary* userDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&error];
                                completionBlock(userDict[@"accessToken"], error ?: connectionError);
                            }];
}

@end
