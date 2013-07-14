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
@end

@implementation UIChapter {
    NSArray* _sections;
    Chapter* _chapter;
}

- (id)initWithChapter:(Chapter*)chapter
{
    self = [super init];
    if (self) {
        _chapter = chapter;
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
            UIChapter* uiChapter = [[UIChapter alloc] initWithChapter:chapter];
            resultBlock(uiChapter, nil);
            return;
        }
        resultBlock(NO, error);
    }];
}

-(NSString *)caption {
    return _chapter.caption;
}

-(NSString *)body {
    return @"Ichiro Suzuki (鈴木 一朗 Suzuki Ichirō?), usually known simply as Ichiro (イチロー Ichirō?) (born October 22, 1973), is a Japanese-born professional baseball outfielder who currently plays for the New York Yankees. Originally a player in Japan's Nippon Professional Baseball (NPB), Ichiro moved to the United States in 2001 to play in MLB for the Seattle Mariners, with whom he spent 11 seasons. Ichiro has established a number of batting records, including MLB's single-season record for hits with 262. He had 10 consecutive 200-hit seasons, the longest streak by any player, surpassing Wee Willie Keeler's streak of eight.[1]Before playing in the MLB, Ichiro played nine years for the Orix Blue Wave in Japan's Pacific League. Posted by Orix after the 2000 season, Ichiro became Seattle's right fielder. The first Japanese-born position player to be signed to the major leagues,[2] Ichiro led the American League (AL) in batting average and stolen bases en route to being named AL Rookie of the Year and AL Most Valuable Player (MVP).Ichiro is the first MLB player to enter the Japanese Baseball Hall of Fame (The Golden Players Club). He is a ten-time All-Star and won the 2007 All-Star Game MVP Award for a three-hit performance that included the event's first-ever inside-the-park home run. Ichiro won a Gold Glove Award in each of his first ten years in the major leagues, and has had seven hitting streaks of 20 or more games, with a high of 27.";
}

-(NSArray *)sections {
    if (_sections) {
        return _sections;
    }
    _sections = [self createSampleSections];
    return _sections;
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
@end
