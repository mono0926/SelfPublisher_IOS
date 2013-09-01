//
//  AppSettings.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "AppSettings.h"

typedef NS_ENUM (NSUInteger, ServerEnvironment)
{
	ServerEnvironmentRelease = 0,
    ServerEnvironmentDevelopHome = 1,
};

static ServerEnvironment _serverEnvironment;

@implementation AppSettings

+(void)initialize
{
    _serverEnvironment = ServerEnvironmentDevelopHome;
}

+(NSString *)baseUrl
{
    switch (_serverEnvironment) {
        case ServerEnvironmentRelease:
            return @"http://apps.mono-comp.com/SelfPublish/api/";
            break;
        case ServerEnvironmentDevelopHome:
            return @"http://192.168.0.13//Mono.API.SelfPublish/api/";
        default:
            return nil;
    }
}
@end
