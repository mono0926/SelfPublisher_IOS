//
//  BodyStringCell.h
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIPlainPart;

@interface BodyStringCell : UITableViewCell
@property (nonatomic) UIPlainPart* plainPart;
@property (nonatomic, readonly) CGFloat cellHeight;
@end
