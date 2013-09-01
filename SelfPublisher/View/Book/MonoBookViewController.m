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
#import "MonoIBooksActivity.h"

@interface MonoBookViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIChapter* selectedChapter;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIButton *kindleButton;
@property (weak, nonatomic) IBOutlet UIButton *iBooksButton;
@end

@implementation MonoBookViewController {
    UIDocumentInteractionController* _documentInteractionController;
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
-(void)viewWillAppear:(BOOL)animated {
    _book.chapterList.delegate = self;
    [self.tableView reloadData];
    [_book addObserver:self forKeyPath:@"epubPath" options:NSKeyValueObservingOptionNew context:nil];
    [_book addObserver:self forKeyPath:@"mobiPath" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    if (!_book) {
        [self showInputTitleView];
    }
}


-(void)viewWillDisappear:(BOOL)animated {
    _book.chapterList.delegate = nil;
    [_book removeObserver:self forKeyPath:@"epubPath"];
    [_book removeObserver:self forKeyPath:@"mobiPath"];
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
                [_book addObserver:self forKeyPath:@"epubPath" options:NSKeyValueObservingOptionNew context:nil];
                [_book addObserver:self forKeyPath:@"mobiPath" options:NSKeyValueObservingOptionNew context:nil];
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
    return 1;
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
- (IBAction)actionTapped:(id)sender
{
    NSArray* myActivityItems = @[[[MonoIBooksActivity alloc]initWithBook:self.book],
                                 [[MonoKindleActivity alloc]initWithBook:self.book]];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:nil
                                                                                     applicationActivities:myActivityItems];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (IBAction)addNewChapterTapped:(id)sender {
    _selectedChapter = nil;
    [self performSegueWithIdentifier:@"showChapter" sender:self];
}

- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)openEpub {
    NSURL *url = [NSURL fileURLWithPath:_book.epubPath];
    [self openImplWithUrl:url];
}
- (void)openMobi {
    NSURL *url = [NSURL fileURLWithPath:_book.mobiPath];
    [self openImplWithUrl:url];
}

-(void)openImplWithUrl:(NSURL*)url
{
    _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
    _documentInteractionController.delegate = self;
    
    BOOL isValid;
    isValid = [_documentInteractionController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    if (!isValid) {
        NSLog(@"No applications found to open %@", url.description);
    }
    
}
- (IBAction)iBooksTapped:(id)sender {
    [self openEpub];
}
- (IBAction)kindleTapped:(id)sender {
    [self openMobi];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _book && [keyPath isEqualToString:@"epubPath"]) {
        _iBooksButton.enabled = YES;
        return;
    }
    if (object == _book && [keyPath isEqualToString:@"mobiPath"]) {
        _kindleButton.enabled = YES;
        return;
    }
}
@end
