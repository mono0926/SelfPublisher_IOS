//
//  BodyPictureCell.m
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BodyPictureCell.h"
#import "MonoUI.h"

@interface BodyPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@end

@implementation BodyPictureCell

- (id)initWithNibName:(NSString*)nibName
{
    self = [[[UINib nibWithNibName:nibName bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    if (self) {
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self initWithNibName:@"BodyPictureCell"];
    if (self) {
    }
    return self;
}

-(void)setPicturePart:(UIPicturePart *)picturePart
{
    _picturePart = picturePart;
    [_picturePart loadImage:^(UIImage *image, NSError *error) {
        _pictureImageView.image = image;
    }];
}

-(CGFloat)cellHeight
{
    return self.frame.size.width;
}


@end
