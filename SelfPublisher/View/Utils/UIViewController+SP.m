//
//  UIViewController+SP.m
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIViewController+SP.h"
#import "MonoUI.h"

@implementation UIViewController (SP)

-(UIModelAccessor*)modelAccessor {
    return inject(UIModelAccessor);
}
@end
