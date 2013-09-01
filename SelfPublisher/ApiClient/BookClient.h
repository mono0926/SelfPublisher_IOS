//
//  BookClient.h
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "SelfPublishClientBase.h"
@class UIBook;

@interface BookClient : SelfPublishClientBase

-(void)convertToEpubWithBook:(UIBook*)book
             completionBlock:(void (^)(NSData* epubData, NSError* error)) completionBlock;
-(void)convertToMobiWithBook:(UIBook*)book
             completionBlock:(void (^)(NSData* mobiData, NSError* error)) completionBlock;
@end
