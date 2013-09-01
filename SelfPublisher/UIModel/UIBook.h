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
@class UIProfile;
@interface UIBook : MTLModel<MTLJSONSerializing>
- (id)initWithBook:(Book*)book;
-(void)convertToEpub:(void(^)(NSError*))resultBlock;
-(void)convertToMobi:(void(^)(NSError*))resultBlock;
+(void)createWithTitle:(NSString*)title resultBlock:(void (^)(UIBook*, NSError*))resultBlock;

@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) UIProfile* author;
@property (nonatomic, readonly) NSArray* chapters;
@property (nonatomic, readonly) UIModelList* chapterList;
@property (nonatomic, readonly) NSString* jsonString;
@property (nonatomic, readonly) NSString* jsonStringWithMobiFormat;
@property (nonatomic, readonly) NSString* jsonStringWithEpubFormat;
@property (nonatomic, readonly) NSManagedObjectID* objectID;
@property (nonatomic, readonly) NSString* epubPath;
@property (nonatomic, readonly) NSString* mobiPath;

@end
