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
#import "BodyPictureCell.h"

static NSString *StringCellIdentifier = @"BodyStringCell";
static NSString *PictureCellIdentifier = @"BodyPictureCell";

@interface BodyPreviewViewController ()

@end

@implementation BodyPreviewViewController
{
    BodyStringCell* _stringCellForHeight;
    BodyPictureCell* _pictureCellForHeight;
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
    [self.tableView registerClass:[BodyPictureCell class] forCellReuseIdentifier:PictureCellIdentifier];
	// 高さ計算用のセルを保持しておく。
	_stringCellForHeight = [self.tableView dequeueReusableCellWithIdentifier:StringCellIdentifier];
	_pictureCellForHeight = [self.tableView dequeueReusableCellWithIdentifier:PictureCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<UISentencePart> part = _sectionBase.bodies[indexPath.row];
    if ([part isKindOfClass:[UIPlainPart class]]) {
        _stringCellForHeight.plainPart = (UIPlainPart*)part;
        return _stringCellForHeight.cellHeight;
    }
    return _pictureCellForHeight.cellHeight;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sectionBase.bodies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<UISentencePart> part = _sectionBase.bodies[indexPath.row];
    if ([part isKindOfClass:[UIPlainPart class]]) {
        BodyStringCell *cell = [tableView dequeueReusableCellWithIdentifier:StringCellIdentifier forIndexPath:indexPath];
        cell.plainPart = (UIPlainPart*)part;
        return cell;
    }
    BodyPictureCell* cell = [tableView dequeueReusableCellWithIdentifier:PictureCellIdentifier forIndexPath:indexPath];
    cell.picturePart = (UIPicturePart*)part;
    return cell;
}


@end
