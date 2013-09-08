//
//  UISectionBaseSpec.m
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "Kiwi.h"
#import "MonoTest.h"

SPEC_BEGIN(UISectionBaseSpec)

describe(@"UISectionBase", ^{
    __block ModelManager* _modelManager;
    __block NSManagedObjectContext* moc;
    __block Section* section;
    __block UISectionBase* target;
    beforeEach(^{
        _modelManager = inject(ModelManager);
        [MNTestUtil initializeModelManagerMock];
        moc = _modelManager.managedObjectContext;
        section = [moc createObject:@"Section"];
        target = [[UISectionBase alloc]initWithSectionBase:section];
    });
    context(@"sectionのbodyが", ^{
        context(@"nil", ^{
            beforeEach(^{
                section.body = nil;
            });
            it(@"bodiesは0", ^{
                [[target.bodies should]beEmpty];
            });
        });
        context(@"文字列だけ", ^{
            beforeEach(^{
                section.body = @"abc";
            });
            it(@"bodyはabc", ^{
                [[target.body should]equal:@"abc"];
            });
            it(@"bodiesは1", ^{
                [[theValue(target.bodies.count)should]equal:theValue(1u)];
                UIPlainPart* plainPart = target.bodies[0];
                [[plainPart should]beKindOfClass:[UIPlainPart class]];
                [[plainPart.sentence should]equal:@"abc"];
            });
        });
        context(@"画像だけ", ^{
            beforeEach(^{
                section.body = @"![](hoge.jpg)";
            });
            it(@"bodyはabc", ^{
                [[target.body should]equal:@"![](hoge.jpg)"];
            });
            it(@"bodiesは1", ^{
                [[theValue(target.bodies.count)should]equal:theValue(1u)];
                UIPicturePart* picturePart = target.bodies[0];
                [[picturePart should]beKindOfClass:[UIPicturePart class]];
                [[picturePart.imagePath should]equal:@"![](hoge.jpg)"];
            });
        });
        
        context(@"画像・文字", ^{
            beforeEach(^{
                section.body = @"![](hoge.jpg)hello";
            });
            it(@"bodyはabc", ^{
                [[target.body should]equal:@"![](hoge.jpg)hello"];
            });
            it(@"bodiesは2", ^{                
                [[theValue(target.bodies.count)should]equal:theValue(2u)];
            });
            it(@"bodiesの1つめは画像", ^{
                UIPicturePart* picturePart = target.bodies[0];
                [[picturePart should]beKindOfClass:[UIPicturePart class]];
                [[picturePart.imagePath should]equal:@"![](hoge.jpg)"];
            });
            it(@"bodiesの2つめは文字", ^{
                UIPlainPart* plainPart = target.bodies[1];
                [[plainPart should]beKindOfClass:[UIPlainPart class]];
                [[plainPart.sentence should]equal:@"hello"];
            });
        });
        
        context(@"画像・文字", ^{
            beforeEach(^{
                section.body = @"hello![](hoge.jpg)";
            });
            it(@"bodyはabc", ^{
                [[target.body should]equal:@"hello![](hoge.jpg)"];
            });
            it(@"bodiesは2", ^{
                [[theValue(target.bodies.count)should]equal:theValue(2u)];
            });
            it(@"bodiesの1つめは文字", ^{
                UIPlainPart* plainPart = target.bodies[0];
                [[plainPart should]beKindOfClass:[UIPlainPart class]];
                [[plainPart.sentence should]equal:@"hello"];
            });
            it(@"bodiesの2つめは画像", ^{
                UIPicturePart* picturePart = target.bodies[1];
                [[picturePart should]beKindOfClass:[UIPicturePart class]];
                [[picturePart.imagePath should]equal:@"![](hoge.jpg)"];
            });
        });
    });
});

SPEC_END

