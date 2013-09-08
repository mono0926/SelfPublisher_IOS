//
//  BodyViewController.m
//  SelfPublisher
//
//  Created by mono on 7/15/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BodyViewController.h"
#import "MonoUI.h"
#import "BodyEditViewController.h"
#import "BodyPreviewViewController.h"

typedef NS_ENUM (NSUInteger, BodyModeType) {
	BodyModeTypePreview = 0,
    BodyModeTypeEdit = 1,
};

@interface BodyViewController ()
@property (nonatomic, readonly) UIChapter* parentChapter;
@property (weak, nonatomic) IBOutlet UIView *editContainerView;
@property (weak, nonatomic) IBOutlet UIView *previewContainerView;
@property (nonatomic) BodyModeType mode;
@end

@implementation BodyViewController
{
    BodyEditViewController* _editViewController;
    BodyPreviewViewController* _previewViewController;
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
    _mode = BodyModeTypePreview;
}

-(void)setParent:(UIChapter *)parent sectionBase:(UISectionBase *)sectionBase {
    _parentChapter = parent;
    _sectionBase = sectionBase;
}


-(void)viewDidAppear:(BOOL)animated {
    if (!_sectionBase) {
        [self showInputTitleView];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self configureTitle];
}

-(void)configureTitle {
    self.title = _sectionBase.caption ? [NSString stringWithFormat:@"Body of %@", _sectionBase.caption] : @"";
}

-(void)showInputTitleView {
    UIAlertView* alert = [UIAlertView alertViewWithTitle:@"Enter Section's caption."];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    __weak UIAlertView* weakAlert = alert;
    [alert addButtonWithTitle:@"OK" handler:^{
        UITextField* tf = [weakAlert textFieldAtIndex:0];
        [UISection createWithUIChapter:_parentChapter caption:tf.text resultBlock:^(UISection *section, NSError *error) {
            if (section) {
                _sectionBase = section;
                _editViewController.sectionBase = section;
                _previewViewController.sectionBase = section;
                [self configureTitle];
                return;
            }
            [SVProgressHUD showErrorWithStatus:error.description];
            [self showInputTitleView];
        }];
    }];
    [alert addButtonWithTitle:@"Cancel" handler:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert show];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}


- (IBAction)editTapped:(UIBarButtonItem *)sender {
    if (_mode == BodyModeTypePreview) {
        _mode = BodyModeTypeEdit;
        [_editViewController viewWillAppear:YES];
        _editContainerView.hidden = NO;
        [_editViewController viewDidAppear:YES];
        [_previewViewController viewWillDisappear:YES];
        _previewContainerView.hidden = YES;
        [_previewViewController viewDidDisappear:YES];
        __weak BodyViewController* weakSelf = self;
        UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone handler:^(id sender) {
            [weakSelf editTapped:sender];
        }];
        self.navigationItem.rightBarButtonItem = item;
        return;
    }
    _mode = BodyModeTypePreview;
    [_editViewController viewWillDisappear:YES];
    _editContainerView.hidden = YES;
    [_editViewController viewDidDisappear:YES];
    [_previewViewController viewWillAppear:YES];
    _previewContainerView.hidden = NO;
    [_previewViewController viewDidAppear:YES];
    __weak BodyViewController* weakSelf = self;
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit handler:^(id sender) {
        [weakSelf editTapped:sender];
    }];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)dealloc
{
    NSLog(@"body dealloc called.");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* destVC = segue.destinationViewController;
    if ([destVC isKindOfClass:[BodyEditViewController class]]) {
        _editViewController = (BodyEditViewController*)destVC;
        _editViewController.sectionBase = _sectionBase;
        return;
    }
    if ([destVC isKindOfClass:[BodyPreviewViewController class]]) {
        _previewViewController = (BodyPreviewViewController*)destVC;
        _previewViewController.sectionBase = _sectionBase;
        return;
    }
}

@end
