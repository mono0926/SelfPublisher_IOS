//
//  MonoChapterVIewController.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoChapterVIewController.h"
#import "MonoUI.h"

@interface MonoChapterVIewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation MonoChapterVIewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _chapter.caption ?: @"";
    self.bodyTextView.text = _chapter.body;
}

-(void)setBook:(UIBook *)book chapter:(UIChapter *)chapter {
    _book = book;
    _chapter = chapter;
}

-(void)viewDidAppear:(BOOL)animated {
    if (!_chapter) {
        [self showInputTitleView];
    }
}

-(void)showInputTitleView {
    __weak UIAlertView* alert = [UIAlertView alertViewWithTitle:@"Input Chapter's caption."];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert addButtonWithTitle:@"OK" handler:^{
        UITextField* tf = [alert textFieldAtIndex:0];
        [UIChapter createWithUIBook:_book caption:tf.text resultBlock:^(UIChapter *chapter, NSError *error) {
            if (chapter) {
                _chapter = chapter;
                self.title = _chapter.caption;
                return;
            }
            [SVProgressHUD showErrorWithStatus:error.description];
            [self showInputTitleView];
        }];
    }];
    [alert addButtonWithTitle:@"Cancel" handler:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert show];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"SectionCell" forIndexPath:indexPath];
    UISection* section = self.chapter.sections[indexPath.row];
    cell.textLabel.text = section.caption;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chapter.sections.count;
}

@end
