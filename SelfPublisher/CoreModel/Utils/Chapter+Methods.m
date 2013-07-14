//
//  Chapter+Methods.m
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "Chapter+Methods.h"
#import "MonoUI.h"

@implementation Chapter (Methods)
-(id)uiModel {
    return [[UIChapter alloc]initWithChapter:self];
}
@end
