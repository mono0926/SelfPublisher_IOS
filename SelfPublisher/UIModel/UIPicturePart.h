//
//  UIPicturePart.h
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UISentencePart.h"

@interface UIPicturePart : NSObject<UISentencePart>
- (id)initWithImagePath:(NSString*)imagePath;
@property (nonatomic, readonly) NSString* imagePath;
-(void)loadImage:(void (^)(UIImage* image, NSError* error))resultBlock;
@end
