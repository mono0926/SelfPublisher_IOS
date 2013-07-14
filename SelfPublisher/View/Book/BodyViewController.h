//
//  BodyViewController.h
//  SelfPublisher
//
//  Created by mono on 7/15/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UISectionBase;
@class UIChapter;

@interface BodyViewController : UIViewController
@property (nonatomic, readonly) UISectionBase* sectionBase;
-(void)setParent:(UIChapter *)parent sectionBase:(UISectionBase*)sectionBase;
@end
