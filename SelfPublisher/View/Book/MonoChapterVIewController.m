//
//  MonoChapterVIewController.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoChapterVIewController.h"
#import "MonoUI.h"
#import "BodyViewController.h"

@interface MonoChapterVIewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
@property (nonatomic) UISection* selectedSection;
@end

@implementation MonoChapterVIewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

-(void)viewWillAppear:(BOOL)animated {
    self.title = _chapter.caption ?: @"";
    self.bodyTextView.text = _chapter.body;
    _chapter.sectionList.delegate = self;
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated {
    _chapter.sectionList.delegate = nil;
}

-(void)showInputTitleView {
    UIAlertView* alert = [UIAlertView alertViewWithTitle:@"Enter Chapter's caption."];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    __weak UIAlertView* weakAlert = alert;
    [alert addButtonWithTitle:@"OK" handler:^{
        UITextField* tf = [weakAlert textFieldAtIndex:0];
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
    UISection* section = [self.chapter.sectionList entityAtIndex:indexPath.row];
    cell.textLabel.text = section.caption;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedSection = [self.chapter.sectionList entityAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showSection" sender:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chapter.sectionList.numberOfItems;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toBodySegue"]) {
        BodyViewController* bodyVC = segue.destinationViewController;
        [bodyVC setParent:nil sectionBase:_chapter];
        return;
    }
    if ([segue.identifier isEqualToString:@"showSection"]) {
        BodyViewController* bodyVC = segue.destinationViewController;
        [bodyVC setParent:_chapter sectionBase:_selectedSection];
        return;
    }
}
- (IBAction)addNewSectionTapped:(id)sender {
    _selectedSection = nil;
    [self performSegueWithIdentifier:@"showSection" sender:nil];
}
#pragma mark - Table view delegate

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{}
-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath {
}

- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
