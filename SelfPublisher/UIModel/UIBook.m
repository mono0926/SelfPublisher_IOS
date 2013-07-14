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
    Book* _book;
    UIModelList* _chapterList;
}

- (id)initWithBook:(Book*)book {
    self = [super init];
    if (self) {
        _book = book;
    }
    return self;
}

+(void)createWithTitle:(NSString*)title resultBlock:(void (^)(UIBook*, NSError*))resultBlock {
    ModelManager* manager = inject(ModelManager);
    NSManagedObjectContext* moc = manager.managedObjectContext;
    [moc performBlock:^{
        Book* book = [moc createObject:@"Book"];
        book.title = title;
        book.author = moc.myProfile;
        NSError* error = nil;
        if ([moc save:&error]) {
            UIBook* uiBook = [[UIBook alloc] initWithBook:book];
            resultBlock(uiBook, nil);
            return;
        }
        resultBlock(NO, error);
    }];
}

-(NSString *)author {
    return _book.author.name;
}

-(NSString *)title {
    return _book.title;
}


-(NSArray *)chapters {
    return self.chapterList.allEntities;
}

-(UIModelList *)chapterList {
    if (_chapterList) {
        return _chapterList;
    }
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Chapter"];
    NSSortDescriptor* sortDiscripter1 = [[NSSortDescriptor alloc]initWithKey:@"caption"
                                                                   ascending:YES];
    request.sortDescriptors = @[sortDiscripter1];

    _chapterList = [[UIModelList alloc]initWithManagedObjectContext:_book.managedObjectContext
                                                            request:request
                                                        sectionName:nil
                                                          cacheName:nil
                                                           delegate:nil];
    return _chapterList;
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+(NSValueTransformer*)chaptersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:UIChapter.class];
}

-(NSString *)jsonString {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModel:self];
    NSDictionary*jsonDict = adapter.JSONDictionary;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(NSManagedObjectID *)objectID {
    return _book.objectID;
}
@end
