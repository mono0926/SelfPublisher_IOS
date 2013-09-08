//
//  BodyPreviewViewController.m
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BodyPreviewViewController.h"
#import "MonoUI.h"
#import "BodyStringCell.h"

static NSString *StringCellIdentifier = @"BodyStringCell";

@interface BodyPreviewViewController ()

@end

@implementation BodyPreviewViewController
{
    BodyStringCell* _stringCellForHeight;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[BodyStringCell class] forCellReuseIdentifier:StringCellIdentifier];
	// 高さ計算用のセルを保持しておく。
	_stringCellForHeight = [self.tableView dequeueReusableCellWithIdentifier:StringCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    _stringCellForHeight.sentence = _sectionBase.body;
    return _stringCellForHeight.cellHeight;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BodyStringCell *cell = [tableView dequeueReusableCellWithIdentifier:StringCellIdentifier forIndexPath:indexPath];
    cell.sentence = _sectionBase.body;
    return cell;
}


@end
