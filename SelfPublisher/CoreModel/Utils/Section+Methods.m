//
//  Section+Methods.m
//  SelfPublisher
//
//  Created by mono on 7/15/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "Section+Methods.h"
#import "MonoUI.h"

@implementation Section (Methods)
-(id)uiModel {
    return [[UISection alloc]initWithSectionBase:self];
}
@end
