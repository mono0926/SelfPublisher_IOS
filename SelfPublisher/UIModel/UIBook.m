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
    Book* _book;
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

-(NSString *)title {
    return _book.title;
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
