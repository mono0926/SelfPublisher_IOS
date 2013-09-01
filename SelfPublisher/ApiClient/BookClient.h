//
//  BookClient.h
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "SelfPublishClientBase.h"

@interface BookClient : SelfPublishClientBase

-(void)convertToEpub:(NSString*)name
     completionBlock:(void (^)(NSData* epubData, NSError* error)) completionBlock;
@end
