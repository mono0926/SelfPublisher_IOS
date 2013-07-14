//
//  UIBook.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@class Book;
@interface UIBook : MTLModel<MTLJSONSerializing>
- (id)initWithBook:(Book*)book;
+(void)createWithTitle:(NSString*)title resultBlock:(void (^)(UIBook*, NSError*))resultBlock;

@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* author;
@property (nonatomic, readonly) NSArray* chapters;
@property (nonatomic, readonly) NSString* jsonString;

@end
