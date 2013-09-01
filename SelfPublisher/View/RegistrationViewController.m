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
    
    [SVProgressHUD showWithStatus:@"Registering..." maskType:SVProgressHUDMaskTypeGradient];
    
    UserClient* userClient = inject(UserClient);
    [userClient registerWithName:_nameTextField.text
                                    completionBlock:^(NSString *accessToken, NSError *error) {
                                        if (error) {
                                            [SVProgressHUD showErrorWithStatus:error.description];
                                        }
                                        [self.modelAccessor createMyProfile:_nameTextField.text
                                                                accessToken:accessToken
                                                                     result:^(UIMyProfile *myProfile) {
                                            if (myProfile) {
                                                [SVProgressHUD showSuccessWithStatus:@"Registered successfully!"];
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                return;
                                            }
                                            [SVProgressHUD showErrorWithStatus:@"Error occured :("];
                                        }];
                                    }];
}

@end
