//
//  UISection.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UISection.h"


@interface UISection ()
@property (nonatomic) NSString* caption;
@end

@implementation UISection
-(NSString *)caption {
    return @"sample section caption.";
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
@end
