//
//  AppSettings.h
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const DropboxAppKey;
extern NSString* const DropboxSecret;

@interface AppSettings : NSObject
+(NSString*)baseUrl;
@end
