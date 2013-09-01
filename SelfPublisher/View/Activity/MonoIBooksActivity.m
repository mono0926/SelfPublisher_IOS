//
//  MonoIBooksActivity.m
//  SelfPublisher
//
//  Created by mono on 9/1/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoIBooksActivity.h"
#import "MonoUI.h"

@interface MonoIBooksActivity ()
@property (nonatomic) UIBook* book;
@end

@implementation MonoIBooksActivity
- (id)initWithBook:(UIBook*)book
{
    self = [super init];
    if (self) {
        self.book = book;
    }
    return self;
}

-(NSString *)activityType {
    return @"iBooks";
}

-(NSString *)activityTitle {
    return @"iBooks";
}

-(UIImage *)activityImage {
    return [UIImage imageNamed:@"ibooks.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

-(void)performActivity {
    
    [_book convertToEpub:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.description];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"Your book has been published successfully!"];
    }];
    
    [SVProgressHUD showSuccessWithStatus:@"Wait for a book published."];
    [self activityDidFinish:YES];
}
@end
