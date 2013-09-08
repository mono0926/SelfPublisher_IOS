//
//  UIPlainPart.h
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UISentencePart.h"

@interface UIPlainPart : NSObject<UISentencePart>
- (id)initWithSentence:(NSString*)sentence;
@property (nonatomic, readonly) NSString* sentence;
@end
