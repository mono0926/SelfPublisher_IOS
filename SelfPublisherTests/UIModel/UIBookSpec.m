//
//  UIBookSpec.m
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//
#import "Kiwi.h"
#import "MonoTest.h"

SPEC_BEGIN(UIBookSpec)

describe(@"hoge", ^{
    registerMatchers(@"RX");
    __block ModelManager* _modelManager;
    __block NSManagedObjectContext* _moc;
    __block UIBook* _target;
    beforeEach(^{
        _modelManager = inject(ModelManager);
        [MNTestUtil initializeModelManagerMock];
        _moc = _modelManager.managedObjectContext;
        _target = [[UIBook alloc]init];
    });
    context(@"context", ^{
        it(@"", ^{            
            [[_target should]beNonNil];
            [[_target should]beKindOfClass:UIBook.class];
        });
    });
});

SPEC_END
