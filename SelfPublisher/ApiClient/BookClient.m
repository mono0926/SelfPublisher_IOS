//
//  BookClient.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BookClient.h"

@implementation BookClient

-(void)convertToEpub:(NSString*)name
        completionBlock:(void (^)(NSData* epubData, NSError* error)) completionBlock
{
    [self requestAsynchronousWithJsonString:nil
                            completionBlock:^(NSURLResponse *response, NSData *epubData, NSError *connectionError) {
                                completionBlock(epubData, connectionError);
                            }];
}
@end
