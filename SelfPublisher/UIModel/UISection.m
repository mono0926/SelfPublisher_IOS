//
//  UISection.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UISection.h"
#import "MonoUI.h"


@interface UISection ()
@property (nonatomic) NSString* caption;
@end

@implementation UISection

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+(void)createWithUIChapter:(UIChapter*)uiChapter caption:(NSString*)caption resultBlock:(void (^)(UISection*, NSError*))resultBlock {
    ModelManager* manager = inject(ModelManager);
    NSManagedObjectContext* moc = manager.managedObjectContext;
    [moc performBlock:^{
        Section* section = [moc createObject:@"Section"];
        section.caption = caption;
        NSError* error = nil;
        Chapter* chapter = (Chapter*)[moc existingObjectWithID:uiChapter.objectID error:&error];
        if (error) {
            resultBlock(NO, error);
            return;
        }
        section.chapter = chapter;
        if ([moc save:&error]) {
            UISection* uiSection = [section uiModel];
            resultBlock(uiSection, nil);
            return;
        }
        resultBlock(NO, error);
    }];
}
@end
