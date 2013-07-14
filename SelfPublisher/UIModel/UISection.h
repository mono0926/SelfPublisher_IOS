//
//  UISection.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UISectionBase.h"
@class  UISection;
@class UIChapter;

@interface UISection : UISectionBase
@property (nonatomic, readonly) NSString* caption;
@property (nonatomic, readonly) NSString* body;
+(void)createWithUIChapter:(UIChapter*)uiChapter caption:(NSString*)caption resultBlock:(void (^)(UISection*, NSError*))resultBlock;
@end
