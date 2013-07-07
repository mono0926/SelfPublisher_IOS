//
//  UIChapter.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface UIChapter : MTLModel<MTLJSONSerializing>
@property (nonatomic, readonly) NSString* caption;
@property (nonatomic, readonly) NSString* body;
@property (nonatomic, readonly) NSArray* sections;
@end
