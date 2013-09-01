//
//  BookClient.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BookClient.h"
#import "MonoUI.h"

@implementation BookClient


-(id)init
{
    UIModelAccessor* modelAccesor = inject(UIModelAccessor);
    self = [super initWithPath:@"books" accessToken:modelAccesor.myProfile.accessToken];
    if (self) {
        
    }
    return self;
}

-(void)convertToEpubWithBook:(UIBook*)book
             completionBlock:(void (^)(NSData* epubData, NSError* error)) completionBlock
{
    [self requestAsynchronousWithJsonString:[NSString stringWithFormat:@"%@", book.jsonStringWithEpubFormat]
                            completionBlock:^(NSURLResponse *response, NSData *epubData, NSError *connectionError) {
                                completionBlock([NSData dataFromBase64String:epubData.decodeAsUTF8String], connectionError);
                            }];
}

-(void)convertToMobiWithBook:(UIBook*)book
             completionBlock:(void (^)(NSData* mobiData, NSError* error)) completionBlock
{
    [self requestAsynchronousWithJsonString:[NSString stringWithFormat:@"%@", book.jsonStringWithMobiFormat]
                            completionBlock:^(NSURLResponse *response, NSData *mobiData, NSError *connectionError) {
                                completionBlock([NSData dataFromBase64String:mobiData.decodeAsUTF8String], connectionError);
                            }];
}
@end
