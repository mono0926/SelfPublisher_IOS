//
//  MonoKindleActivity.m
//  SelfPublisher
//
//  Created by mono on 7/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoKindleActivity.h"
#import "MonoUI.h"

@interface MonoKindleActivity ()
@property (nonatomic) UIBook* book;
@end

@implementation MonoKindleActivity

- (id)initWithBook:(UIBook*)book
{
    self = [super init];
    if (self) {
        self.book = book;
    }
    return self;
}

-(NSString *)activityType {
    return @"Kindle";
}

-(NSString *)activityTitle {
    return @"Kindle";
}

-(UIImage *)activityImage {
    return [UIImage imageNamed:@"amazon.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

-(void)performActivity {
    
    [_book convertToEpub:^(NSString *result, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"Your book has been published successfully!"];
        id hoge = nil;
    }];
    
    [SVProgressHUD showSuccessWithStatus:@"Wait for a book published."];
    [self activityDidFinish:YES];
}

@end
