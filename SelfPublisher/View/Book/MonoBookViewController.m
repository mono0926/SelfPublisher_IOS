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
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
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
    self.title = self.book.title;
    self.authorTextField.text = self.modelAccessor.myProfile.name;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.book.chapters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"AddChapterCell" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"addChapter.png"];
        return cell;
    }
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath];
    UIChapter* chapter = self.book.chapters[indexPath.row];
    cell.textLabel.text = chapter.caption;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.selectedChapter = nil;
        [self performSegueWithIdentifier:@"showChapter" sender:self];
        return;
    }
    self.selectedChapter = self.book.chapters[indexPath.row];
    [self performSegueWithIdentifier:@"showChapter" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChapter"]) {
        MonoChapterVIewController* vc = segue.destinationViewController;
        vc.chapter = self.selectedChapter;
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

- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
