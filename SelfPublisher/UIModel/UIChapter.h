//
//  UIChapter.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UISectionBase.h"
@class UIBook;
@class UIChapter;
@class Chapter;
@class UIModelList;
@interface UIChapter : UISectionBase
- (id)initWithChapter:(Chapter*)chapter;
+(void)createWithUIBook:(UIBook*)uiBook caption:(NSString*)caption resultBlock:(void (^)(UIChapter*, NSError*))resultBlock;
@property (nonatomic, readonly) NSArray* sections;
@property (nonatomic, readonly) UIModelList* sectionList;
@property (nonatomic, readonly) NSManagedObjectID* objectID;
@end
