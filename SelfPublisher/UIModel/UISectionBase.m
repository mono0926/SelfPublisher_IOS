//
//  UISectionBase.m
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UISectionBase.h"
#import "MonoUI.h"

@implementation UISectionBase
-(id)initWithSectionBase:(SectionBase *)sectionBase {
    self = [super init];
    if (self) {
        _sectionBase = sectionBase;
    }
    return self;
}
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

-(NSString *)caption {
    return _sectionBase.caption;
}

-(NSString *)body {
    return _sectionBase.body;
}

-(void)saveCaption:(NSString*)caption body:(NSString*)body errorBlock:(void(^)(NSError*))errorBlock {
    ModelManager* manager = inject(ModelManager);
    NSManagedObjectContext* moc = manager.managedObjectContext;
    [moc performBlock:^{
        NSError* error = [self saveImpl:moc caption:caption body:body];
        errorBlock(error);
    }];
}

-(NSError*)saveCaption:(NSString*)caption body:(NSString*)body {
    ModelManager* manager = inject(ModelManager);
    NSManagedObjectContext* moc = manager.managedObjectContext;
    NSError* error = [self saveImpl:moc caption:caption body:body];
    return error;
}

-(NSError*)saveImpl:(NSManagedObjectContext*)moc caption:(NSString*)caption body:(NSString*)body {
    if (caption) {
        _sectionBase.caption = caption;
    }
    if (body) {
        _sectionBase.body = body;
    }
    NSError* error = nil;
    [moc save:&error];
    return error;
}
@end
