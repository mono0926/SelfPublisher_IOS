//
//  UIViewController+SP.h
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIModelAccessor;

@interface UIViewController (SP)
@property (nonatomic, readonly) UIModelAccessor* modelAccessor;
@end
