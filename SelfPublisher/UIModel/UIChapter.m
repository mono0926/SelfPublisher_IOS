//
//  UIChapter.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIChapter.h"
#import "MonoUI.h"

@interface UIChapter ()
@property (nonatomic) NSString* caption;
@property (nonatomic) NSString* body;
@property (nonatomic) NSArray* sections;
@property (nonatomic, readonly) Chapter* chapter;
@end

@implementation UIChapter {
    NSArray* _sections;
    UIModelList* _sectionList;
}

- (id)initWithChapter:(Chapter*)chapter
{
    self = [super initWithSectionBase:chapter];
    if (self) {
    }
    return self;
}

+(void)createWithUIBook:(UIBook*)uiBook caption:(NSString*)caption resultBlock:(void (^)(UIChapter*, NSError*))resultBlock {
    ModelManager* manager = inject(ModelManager);
    NSManagedObjectContext* moc = manager.managedObjectContext;
    [moc performBlock:^{
        Chapter* chapter = [moc createObject:@"Chapter"];
        chapter.caption = caption;
        NSError* error = nil;
        Book* book = (Book*)[moc existingObjectWithID:uiBook.objectID error:&error];
        if (error) {            
            resultBlock(NO, error);
            return;
        }
        chapter.book = book;
        if ([moc save:&error]) {
            UIChapter* uiChapter = [chapter uiModel];
            resultBlock(uiChapter, nil);
            return;
        }
        resultBlock(NO, error);
    }];
}

-(Chapter *)chapter {
    return (Chapter*)_sectionBase;
}

-(NSArray *)sections {
    return self.sectionList.allEntities;
}

-(UIModelList *)sectionList {    
    if (_sectionList) {
        return _sectionList;
    }
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
    request.predicate = [NSPredicate predicateWithFormat:@"chapter == %@", self.chapter];
    NSSortDescriptor* sortDiscripter1 = [[NSSortDescriptor alloc]initWithKey:@"caption"
                                                                   ascending:YES];
    request.sortDescriptors = @[sortDiscripter1];
    
    _sectionList = [[UIModelList alloc]initWithManagedObjectContext:self.chapter.managedObjectContext
                                                            request:request
                                                        sectionName:nil
                                                          cacheName:nil
                                                           delegate:nil];
    return _sectionList;
}

-(NSArray*) createSampleSections {
    UISection* s1 = [[UISection alloc]init];
    UISection* s2 = [[UISection alloc]init];
    UISection* s3 = [[UISection alloc]init];
    return @[s1, s2, s3];
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+(NSValueTransformer*)sectionsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:UISection.class];
}

-(NSManagedObjectID *)objectID {
    return _sectionBase.objectID;
}
@end
