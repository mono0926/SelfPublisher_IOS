//
//  MonoBookViewController.h
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIBook;
@interface MonoBookViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UIBook* book;
@end
