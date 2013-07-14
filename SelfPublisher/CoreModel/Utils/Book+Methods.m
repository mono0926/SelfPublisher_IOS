//
//  Book+Methods.m
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "Book+Methods.h"
#import "MonoUI.h"
@implementation Book (Methods)
-(id)uiModel {
    return [[UIBook alloc]initWithBook:self];
}
@end
