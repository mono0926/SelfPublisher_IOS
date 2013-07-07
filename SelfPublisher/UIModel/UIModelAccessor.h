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

@interface UIModelAccessor : NSObject<Injectable>

@property (nonatomic) NSArray* books;

-(void)addBook;

@end
