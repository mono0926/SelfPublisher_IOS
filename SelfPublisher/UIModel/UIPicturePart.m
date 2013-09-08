//
//  UIPicturePart.m
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIPicturePart.h"
#import "MonoUI.h"

@implementation UIPicturePart
-(id)initWithImagePath:(NSString *)imagePath
{
    self = [super init];
    if (self) {
        _imagePath = imagePath;
    }
    return self;
}

-(void)loadImage:(void (^)(UIImage* image, NSError* error))resultBlock
{
    UIModelAccessor* modelAccessor = inject(UIModelAccessor);
    DBPath* dbPath = [[DBPath alloc]initWithString:[_imagePath substringWithRange:NSMakeRange(4, _imagePath.length - 5)]];
    DBFile* dbFile = [modelAccessor.dbFileSystem openFile:dbPath error:nil];
    NSData* data = [dbFile readData:nil];
    UIImage* image = [UIImage imageWithData:data];
#warning エセコールバック
    resultBlock(image, nil);
}
@end
