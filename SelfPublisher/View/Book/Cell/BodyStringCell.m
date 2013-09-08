//
//  BodyStringCell.m
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BodyStringCell.h"
#import "MonoUI.h"

@interface BodyStringCell ()
@property (weak, nonatomic) IBOutlet UILabel *sentenceLabel;

@end

@implementation BodyStringCell

- (id)initWithNibName:(NSString*)nibName
{
    self = [[[UINib nibWithNibName:nibName bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    if (self) {
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self initWithNibName:@"BodyStringCell"];
    if (self) {
    }
    return self;
}

-(void)setPlainPart:(UIPlainPart *)plainPart
{
    _plainPart = plainPart;
    _sentenceLabel.text = plainPart.sentence;
}

-(CGFloat)cellHeight
{
    NSDictionary *attributes = @{NSFontAttributeName: _sentenceLabel.font};
    CGSize size = [_sentenceLabel.text boundingRectWithSize:CGSizeMake(320, 1000)
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:attributes
                                                    context:nil].size;
    return size.height + 20;
}

@end
