//
//  UIModelAccessor.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Syringe.h"
@class UIChapter;
@class UIBook;
@class UIMyProfile;
@class UIModelList;
@class UserClient;
@class BookClient;

@interface UIModelAccessor : NSObject<Injectable>

@property (nonatomic) UIMyProfile* myProfile;
@property (nonatomic) UIModelList* bookList;
-(void)createMyProfile:(NSString*)name accessToken:(NSString*)accessToken result:(void(^)(UIMyProfile*))result;

@end
