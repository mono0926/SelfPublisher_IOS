//
//  UIChapter.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@class UIBook;
@class UIChapter;
@class Chapter;
@interface UIChapter : MTLModel<MTLJSONSerializing>
- (id)initWithChapter:(Chapter*)chapter;
+(void)createWithUIBook:(UIBook*)uiBook caption:(NSString*)caption resultBlock:(void (^)(UIChapter*, NSError*))resultBlock;
@property (nonatomic, readonly) NSString* caption;
@property (nonatomic, readonly) NSString* body;
@property (nonatomic, readonly) NSArray* sections;
@end
