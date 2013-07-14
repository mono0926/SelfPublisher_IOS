//
//  RegistrationViewController.m
//  SelfPublisher
//
//  Created by mono on 7/12/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "RegistrationViewController.h"
#import "MonoUI.h"

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@end

@implementation RegistrationViewController

- (void)viewWillAppear:(BOOL)animated {
    [_nameTextField becomeFirstResponder];
}

- (IBAction)registerTapped:(id)sender {
     [self.modelAccessor createMyProfile:_nameTextField.text result:^(UIMyProfile *myProfile) {
         if (myProfile) {
             [self dismissViewControllerAnimated:YES completion:nil];
         }
     }];
}

@end
