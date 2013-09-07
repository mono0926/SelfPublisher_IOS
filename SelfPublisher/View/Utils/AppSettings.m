//
//  AppSettings.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "AppSettings.h"

NSString* const DropboxAppKey = @"j55215vf75hur2l";
NSString* const DropboxSecret = @"ukzqht19mebjm8x";

typedef NS_ENUM (NSUInteger, ServerEnvironment)
{
	ServerEnvironmentRelease = 0,
    ServerEnvironmentDevelopHome = 1,
    ServerEnvironmentDevelopOffice = 2,
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
            return @"http://192.168.0.13/Mono.API.SelfPublish/api/";
            break;
        case ServerEnvironmentDevelopOffice:
            return @"http://192.168.100.111/Mono.API.SelfPublish/api/";
            break;
        default:
            return nil;
    }
}
@end
