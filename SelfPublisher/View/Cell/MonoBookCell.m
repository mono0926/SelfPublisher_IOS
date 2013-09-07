//
//  MonoBookCell.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoBookCell.h"
#import "MonoUI.h"

@interface MonoBookCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation MonoBookCell

- (id)initWithFrame:(CGRect)frame
{
    self = [[[UINib nibWithNibName:@"MonoBookCell" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    if (self) {
        self.frame = frame;
    }
    return self;
}

-(void)setBook:(UIBook *)book {
    _book = book;
    _titleLabel.text = book.title;
    _imageView.image = book.coverImage;
}

@end
