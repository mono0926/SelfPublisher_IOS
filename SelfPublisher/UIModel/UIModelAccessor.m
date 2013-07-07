//
//  UIModelAccessor.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIModelAccessor.h"
#import "MonoUI.h"


@implementation UIModelAccessor {
    NSArray* _books;
}

-(NSArray *)books {
    if (_books) {
        return _books;
    }
    _books = [self createSampleBooks];
    return _books;
}

-(NSArray*) createSampleBooks {
    UIBook* b1 = [[UIBook alloc]init];
    UIBook* b2 = [[UIBook alloc]init];
    UIBook* b3 = [[UIBook alloc]init];
    UIBook* b4 = [[UIBook alloc]init];
    UIBook* b5 = [[UIBook alloc]init];
    UIBook* b6 = [[UIBook alloc]init];
    UIBook* b7 = [[UIBook alloc]init];
    UIBook* b8 = [[UIBook alloc]init];
    UIBook* b9 = [[UIBook alloc]init];
    UIBook* b10 = [[UIBook alloc]init];
    return @[b1, b2, b3, b4, b5, b6, b7, b8, b9, b10];
}
@end
