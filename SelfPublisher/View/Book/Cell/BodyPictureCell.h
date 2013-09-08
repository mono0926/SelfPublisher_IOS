//
//  BodyPictureCell.h
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIPicturePart;

@interface BodyPictureCell : UITableViewCell
@property (nonatomic) UIPicturePart* picturePart;
@property (nonatomic, readonly) CGFloat cellHeight;
@end
