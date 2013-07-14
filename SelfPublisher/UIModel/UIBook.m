//
//  UIBook.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIBook.h"
#import "MonoUI.h"

@interface UIBook ()
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* author;
@property (nonatomic) NSArray* chapters;
@end

@implementation UIBook {
    NSArray* _chapters;
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSString *)title {
    return @"Sample";
}


-(NSArray *)chapters {
    if (_chapters) {
        return _chapters;
    }
    _chapters = [self createSampleChapters];
    return _chapters;
}

-(NSArray*) createSampleChapters {
    UIChapter* c1 = [[UIChapter alloc]init];
    UIChapter* c2 = [[UIChapter alloc]init];
    UIChapter* c3 = [[UIChapter alloc]init];
    return @[c1, c2, c3];
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+(NSValueTransformer*)chaptersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:UIChapter.class];
}

@end
