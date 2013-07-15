//
//  MonoChapterVIewController.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/NSFetchedResultsController.h>
@class UIChapter;
@class UIBook;
@interface MonoChapterVIewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic, readonly) UIChapter* chapter;
@property (nonatomic, readonly) UIBook* book;
-(void)setBook:(UIBook *)book chapter:(UIChapter*)chapter;
@end
