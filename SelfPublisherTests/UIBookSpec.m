//
//  SelfPublisherTests.m
//  SelfPublisherTests
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "Kiwi.h"
#import "MonoUI.h"

SPEC_BEGIN(UIBookSpec)

describe(@"UIBook", ^{
    context(@"シリアライズ", ^{
        it(@"", ^{
            UIModelAccessor* accessor = inject(UIModelAccessor);
            UIBook* book = accessor.books[0];
            NSData* encodedData = [NSJSONSerialization dataWithJSONObject:book options:NSJSONWritingPrettyPrinted error:nil];
            NSString* jsonString = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
            NSLog(jsonString);
        });
    });
});

SPEC_END