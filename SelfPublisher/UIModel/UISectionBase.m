//
//  UISectionBase.m
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UISectionBase.h"

@implementation UISectionBase
-(id)initWithSectionBase:(SectionBase *)sectionBase {
    self = [super init];
    if (self) {
        _sectionBase = sectionBase;
    }
    return self;
}
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
@end
