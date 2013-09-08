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

-(NSArray *)bodies
{
    NSError* error = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"\\!\\[\\]\\(([a-zA-Z0-9.]*)\\)"
                                                                            options:0
                                                                              error:&error];
    NSString* body = self.body;
    if (!body) {
        return @[];
    }
    NSArray* arr = [regexp matchesInString:body
                                   options:0
                                     range:NSMakeRange(0, body.length)];
    
    if (!arr.count) {
        UIPlainPart* plainPart = [[UIPlainPart alloc] initWithSentence:body];
        return @[plainPart];
    }
    
    NSUInteger initial = 0;
    NSMutableArray* outputs = [NSMutableArray new];
    for (NSTextCheckingResult* result in arr) {
        NSRange range = [result rangeAtIndex:0];
        if (range.location != 0 && range.location > initial) {
            NSString* plain = [body substringWithRange:NSMakeRange(initial, range.location - initial)];
            UIPlainPart* plainPart = [[UIPlainPart alloc] initWithSentence:plain];
            [outputs addObject:plainPart];
        }
        initial = range.location + range.length;
        NSString* picturePath = [body substringWithRange:range];
        UIPicturePart* picturePart = [[UIPicturePart alloc]initWithImagePath:picturePath];
        [outputs addObject:picturePart];
    }
    
    if (body.length > initial) {
        NSString* plain = [body substringWithRange:NSMakeRange(initial, body.length - initial)];
        UIPlainPart* plainPart = [[UIPlainPart alloc] initWithSentence:plain];
        [outputs addObject:plainPart];
    }
    
    return outputs;
    
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

-(NSString*)addImage:(UIImage*)image
{
    NSString* shortUUID = [[NSString uuidString] substringToIndex:5];
    NSData* imageData = [[NSData alloc]initWithData:UIImageJPEGRepresentation(image, 0.7)];
    NSString* localPath = [NSString stringWithFormat:@"%@.jpg", shortUUID];
    DBPath* dbPath =  [[DBPath root]childPath:localPath];
    UIModelAccessor* modelAccessor = inject(UIModelAccessor);
    DBFilesystem* fileSystem = modelAccessor.dbFileSystem;
    NSError* error = nil;
#warning この段階ではまだDropboxへアップロードはされていない
    DBFile* file = [fileSystem createFile:dbPath error:&error];
    [file writeData:imageData error:&error];
    if (error) {
        return nil;
    }
    return [NSString stringWithFormat:@"![](%@)", localPath];
}
@end
