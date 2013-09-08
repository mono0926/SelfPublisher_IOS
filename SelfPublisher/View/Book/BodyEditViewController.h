//
//  BodyEditViewController.h
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UISectionBase;

@interface BodyEditViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic) UISectionBase* sectionBase;
@end
