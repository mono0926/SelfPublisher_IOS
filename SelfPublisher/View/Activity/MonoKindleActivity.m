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
    
    NSString* jsonString = self.book.jsonString;

    NSData *requestData =
    [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]
                            cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    //HTTPメソッドは"POST"
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json"
   forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",
                       [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    //レスポンス
    NSURLResponse *resp;
    NSError *err;
    
    //HTTPリクエスト送信
    NSData *result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&resp error:&err];
    
    
    [self activityDidFinish:YES];
}

@end
