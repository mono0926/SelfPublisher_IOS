//
//  BodyEditViewController.m
//  SelfPublisher
//
//  Created by mono on 9/8/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "BodyEditViewController.h"
#import "MonoUI.h"

static const CGFloat AccessoryViewHeight = 35.0;

@interface BodyEditViewController ()
@property (weak, nonatomic) IBOutlet UITextView *bodyTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;
@end

@implementation BodyEditViewController
{    
    UIImagePickerController* _picker;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBody];
    [self observeKeyboard];
    _bodyTextField.inputAccessoryView = [self createAccessoryView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.view.superview.hidden) {
        [_bodyTextField becomeFirstResponder];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopObervingKeyboard];
    [self closeKeyboard];
    NSError* error = [_sectionBase saveCaption:nil body:_bodyTextField.text];
    if (error) {
        
    }
}


-(void)configureBody
{    
    _bodyTextField.text = _sectionBase.body ?: @"";
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
    
    _bottomSpaceConstraint.constant = height;
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

- (UIView *)createAccessoryView
{
    CGFloat viewWidth = self.view.frame.size.width;
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, AccessoryViewHeight)];
    accessoryView.backgroundColor = [UIColor iOS7lightGrayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat buttonWidth = 65.0f;
    button.frame = CGRectMake(viewWidth - buttonWidth, 0, buttonWidth, AccessoryViewHeight);
    [button setTitle:@"Close" forState:UIControlStateNormal];
    // ボタンを押した時のイベント
    [button addTarget:self action:@selector(closeKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pictureButton setImage:[UIImage imageNamed:@"add_picture.png"] forState:UIControlStateNormal];
    pictureButton.frame = CGRectMake(0, 0, AccessoryViewHeight, AccessoryViewHeight);
    [pictureButton addTarget:self action:@selector(addPictureTapped) forControlEvents:UIControlEventTouchUpInside];
    
    // View にボタン追加
    [accessoryView addSubview:button];
    [accessoryView addSubview:pictureButton];
    
    return accessoryView;
}

- (void)closeKeyboard
{
    [_bodyTextField resignFirstResponder];
}

#pragma mark - image
- (IBAction)addPictureTapped
{
    [self showImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)showImagePickerController:(UIImagePickerControllerSourceType)sourceType {
    // 毎回初期化しないと落ちることがある
    _picker = [UIImagePickerController new];
    _picker.delegate = self;
    
    switch (sourceType) {
        case UIImagePickerControllerSourceTypeCamera:
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])  {
                _picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            break;
        case UIImagePickerControllerSourceTypePhotoLibrary:
            _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        default:
            break;
    }
    [self presentViewController:_picker animated:YES completion:nil];
}

#pragma mark - ImagePickerViewDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    NSString* imageName = [_sectionBase addImage:originalImage];
    [_bodyTextField insertText:imageName];
}

@end
