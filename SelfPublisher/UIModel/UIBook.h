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
@class UIModelList;
@interface UIBook : MTLModel<MTLJSONSerializing>
- (id)initWithBook:(Book*)book;
-(void)convertToEpub:(void(^)(NSError*))resultBlock;
+(void)createWithTitle:(NSString*)title resultBlock:(void (^)(UIBook*, NSError*))resultBlock;

@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* author;
@property (nonatomic, readonly) NSArray* chapters;
@property (nonatomic, readonly) UIModelList* chapterList;
@property (nonatomic, readonly) NSString* jsonString;
@property (nonatomic, readonly) NSManagedObjectID* objectID;
@property (nonatomic, readonly) NSString* epubPath;

@end
