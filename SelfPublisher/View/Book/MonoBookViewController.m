//
//  MonoBookViewController.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoBookViewController.h"
#import "MonoUI.h"
#import "MonoChapterVIewController.h"
#import "MonoKindleActivity.h"

@interface MonoBookViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIChapter* selectedChapter;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@end

@implementation MonoBookViewController {
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.book.title ?: @"";
    self.authorLabel.text = self.modelAccessor.myProfile.name;
}

-(void)viewDidAppear:(BOOL)animated {
    if (!_book) {
        [self showInputTitleView];
    }
}

-(void)showInputTitleView {
    UIAlertView* alert = [UIAlertView alertViewWithTitle:@"Enter Book's Title."];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    __weak UIAlertView* weakAlert = alert;
    [alert addButtonWithTitle:@"OK" handler:^{
        UITextField* tf = [weakAlert textFieldAtIndex:0];        
        [UIBook createWithTitle:tf.text resultBlock:^(UIBook *book, NSError *error) {
            if (book) {
                _book = book;
                self.title = _book.title;
                return;
            }
            [SVProgressHUD showErrorWithStatus:error.description];
            [self showInputTitleView];
        }];
    }];
    [alert addButtonWithTitle:@"Cancel" handler:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert show];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.book.chapterList.numberOfItems;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath];
    UIChapter* chapter = [self.book.chapterList entityAtIndex:indexPath.row];
    cell.textLabel.text = chapter.caption;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedChapter = [self.book.chapterList entityAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showChapter" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChapter"]) {
        MonoChapterVIewController* vc = segue.destinationViewController;
        [vc setBook:_book chapter:self.selectedChapter];
    }
}
- (IBAction)actionTapped:(id)sender {
//    NSArray *activityItems = [NSArray arrayWithObjects:@"hoge", nil];
    /*
    if (_postImage.image != nil) {
        activityItems = @[_postText.text, _postImage.image];
    } else {
        activityItems = @[_postText.text];
    }
    */
    
    NSArray* myActivityItems = @[[[MonoKindleActivity alloc]initWithBook:self.book]];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:nil applicationActivities:myActivityItems];
    [self presentViewController:activityController animated:YES completion:nil];
}
- (IBAction)addNewChapterTapped:(id)sender {
    _selectedChapter = nil;
    [self performSegueWithIdentifier:@"showChapter" sender:self];
}

- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
