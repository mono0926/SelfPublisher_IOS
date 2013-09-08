//
//  UIPlainPart.m
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIPlainPart.h"

@implementation UIPlainPart

- (id)initWithSentence:(NSString*)sentence
{
    self = [super init];
    if (self) {
        _sentence = sentence;
    }
    return self;
}
@end
