//
//  BodyViewController.m
//  SelfPublisher
//
//  Created by mono on 7/15/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BodyViewController.h"
#import "MonoUI.h"

@interface BodyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *bodyTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;
@property (nonatomic, readonly) UIChapter* parentChapter;

@end

@implementation BodyViewController

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
}

-(void)setParent:(UIChapter *)parent sectionBase:(UISectionBase *)sectionBase {
    _parentChapter = parent;
    _sectionBase = sectionBase;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (_sectionBase) {
        [self configureTitleAndBody];
    } else {
        [self showInputTitleView];
    }
    
    [self observeKeyboard];
}

-(void)configureTitleAndBody {
    self.title = [NSString stringWithFormat:@"Body of %@", _sectionBase.caption];
    _bodyTextField.text = _sectionBase.body ?: @"";
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
                [self configureTitleAndBody];
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

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    NSError* error = [_sectionBase saveCaption:nil body:_bodyTextField.text];
    if (error) {
        
    }
    [self stopObervingKeyboard];
}

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)stopObervingKeyboard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    CGRect keyboardFrame= [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat height = keyboardFrame.size.height;
    
    _bottomSpaceConstraint.constant = - height;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    _bottomSpaceConstraint.constant = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

@end
