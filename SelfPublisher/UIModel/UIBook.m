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
@property (nonatomic) UIProfile* author;
@property (nonatomic) NSArray* chapters;
@property (nonatomic) NSString* coverImageBase64;
@end

@implementation UIBook {
    Book* _book;
    UIModelList* _chapterList;
}

- (id)initWithBook:(Book*)book {
    self = [super init];
    if (self) {
        _book = book;
        [_book addObserver:self forKeyPath:@"epub" options:NSKeyValueObservingOptionNew context:nil];
        [_book addObserver:self forKeyPath:@"mobi" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)dealloc {
    [_book removeObserver:self forKeyPath:@"epub"];
    [_book removeObserver:self forKeyPath:@"mobi"];
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
            UIBook* uiBook = [book uiModel];
            resultBlock(uiBook, nil);
            return;
        }
        resultBlock(NO, error);
    }];
}

-(UIProfile *)author {
    return _book.author.uiProfile;
}

-(NSString *)title {
    return _book.title;
}


-(NSArray *)chapters {
    return self.chapterList.allEntities;
}

-(NSString *)coverImageBase64 {
    return [_book.coverImage base64EncodedString];
}

-(UIModelList *)chapterList {
    if (_chapterList) {
        return _chapterList;
    }
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Chapter"];
    request.predicate = [NSPredicate predicateWithFormat:@"book == %@", _book];
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

-(void)convertToEpub:(void(^)(NSError*))resultBlock {
    
    BookClient* bookClient = inject(BookClient);
    [bookClient convertToEpubWithBook:self
                      completionBlock:^(NSData *epubData, NSError *error) {
                          [_book.managedObjectContext performBlock:^{
                              _book.epub = epubData;
                              [_book.managedObjectContext save:nil];
                              resultBlock(error);
                          }];
                      }];
}

-(void)convertToMobi:(void(^)(NSError*))resultBlock
{
    
    BookClient* bookClient = inject(BookClient);
    [bookClient convertToMobiWithBook:self
                      completionBlock:^(NSData *mobiData, NSError *error) {
                          [_book.managedObjectContext performBlock:^{
                              _book.mobi = mobiData;
                              [_book.managedObjectContext save:nil];
                              resultBlock(error);
                          }];
                      }];
}

-(void)setCoverImageData:(NSData *)coverImageData
{
    [_book.managedObjectContext performBlock:^{
        _book.coverImage = coverImageData;
        [_book.managedObjectContext save:nil];
    }];
}

-(UIImage *)coverImage
{
    return [UIImage imageWithData:_book.coverImage] ?: [UIImage imageNamed:@"cover_not_set.png"];
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+(NSValueTransformer*)chaptersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:UIChapter.class];
}
+(NSValueTransformer*)authorJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:UIProfile.class];
}

-(NSString *)jsonString {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModel:self];
    NSDictionary*jsonDict = adapter.JSONDictionary;
    return [self jsonStringWithJsonDict:jsonDict];
}
-(NSString*)jsonStringWithMobiFormat
{
    return [self jsonStringWithJsonDict:[self createMobiFormatDictionary]];
}

-(NSString*)jsonStringWithEpubFormat
{
    return [self jsonStringWithJsonDict:[self createEpubFormatDictionary]];
}

-(NSString *)jsonStringWithJsonDict:(NSDictionary*)jsonDict
{
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:jsonData.bytes
                                                    length:jsonData.length
                                                  encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(NSDictionary*)createEpubFormatDictionary
{
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModel:self];
    NSMutableDictionary*jsonDict = adapter.JSONDictionary.mutableCopy;
    jsonDict[@"format"] = @"epub";
    return jsonDict;
}

-(NSDictionary*)createMobiFormatDictionary
{
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModel:self];
    NSMutableDictionary*jsonDict = adapter.JSONDictionary.mutableCopy;
    jsonDict[@"format"] = @"mobi";
    return jsonDict;
}

-(NSManagedObjectID *)objectID {
    return _book.objectID;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _book && [keyPath isEqualToString:@"epub"] && _book.epub) {
        [self willChangeValueForKey:@"epubPath"];        
        NSData* epubData = _book.epub;
        NSString* tmpDir = NSTemporaryDirectory();
        NSString* filename = [NSString stringWithFormat:@"%@.epub", [NSDate date]];
        NSString* path = [tmpDir stringByAppendingString:filename];
        [epubData writeToFile:path atomically:YES];
        _epubPath = path;
        [self didChangeValueForKey:@"epubPath"];
        return;
    }
    if (object == _book && [keyPath isEqualToString:@"mobi"] && _book.mobi) {
        [self willChangeValueForKey:@"mobiPath"];
        NSData* mobiData = _book.mobi;
        NSString* tmpDir = NSTemporaryDirectory();
        NSString* filename = [NSString stringWithFormat:@"%@.mobi", [NSDate date]];
        NSString* path = [tmpDir stringByAppendingString:filename];
        [mobiData writeToFile:path atomically:YES];
        _mobiPath = path;
        [self didChangeValueForKey:@"mobiPath"];
        return;
    }
}
@end
