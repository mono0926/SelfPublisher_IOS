//
//  UIModelAccessor.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "UIModelAccessor.h"
#import "MonoUI.h"

@interface UIModelAccessor ()
@property (nonatomic, readonly) NSManagedObjectContext* moc;
@end

@implementation UIModelAccessor {
    UIModelList* _bookList;
    UIMyProfile* _myProfile;
}

-(UIMyProfile *)myProfile {
    if (_myProfile) {
        return _myProfile;
    }
    MyProfile* cMyProfile = self.moc.myProfile;
    if (cMyProfile) {
        _myProfile = [[UIMyProfile alloc]initWithProfile:cMyProfile];
        return _myProfile;
    }
    return nil;
}

-(void)createMyProfile:(NSString*)name result:(void(^)(UIMyProfile*))result {
    [self.moc performBlock:^{
        MyProfile* myProfile = self.moc.createMyProfile;
        if (myProfile) {
            myProfile.name = name;
            if ([self.moc save:nil]) {
                result(self.myProfile);
            }
        }
    }];
}

-(UIModelList *)bookList {
    if (_bookList) {
        return _bookList;
    }
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    NSSortDescriptor* sortDiscripter1 = [[NSSortDescriptor alloc]initWithKey:@"title"
                                                                   ascending:YES];
    request.sortDescriptors = @[sortDiscripter1];
    
    _bookList = [[UIModelList alloc]initWithManagedObjectContext:self.moc
                                                            request:request
                                                        sectionName:nil
                                                          cacheName:nil
                                                           delegate:nil];
    return _bookList;
}

-(NSManagedObjectContext*)moc {
    return [inject(ModelManager) managedObjectContext];
}
@end
