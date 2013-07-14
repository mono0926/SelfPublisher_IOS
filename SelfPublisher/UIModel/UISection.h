//
//  UISection.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UISectionBase.h"

@interface UISection : UISectionBase
@property (nonatomic, readonly) NSString* caption;
@property (nonatomic, readonly) NSString* body;
@end
