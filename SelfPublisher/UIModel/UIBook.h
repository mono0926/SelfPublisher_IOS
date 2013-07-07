//
//  UIBook.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@interface UIBook : MTLModel<MTLJSONSerializing>
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* author;
@property (nonatomic, readonly) NSArray* chapters;
@end
