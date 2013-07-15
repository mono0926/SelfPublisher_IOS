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
    
    NSString* jsonString = [NSString stringWithFormat:@"{\'name':'%@'", _nameTextField.text];
    NSData *requestData =[jsonString dataUsingEncoding:NSUTF8StringEncoding];    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://apps.mono-comp.com/SelfPublish/api/users"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",
                       [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    //レスポンス
    NSURLResponse *resp;
    NSError *err;
    //HTTPリクエスト送信
    NSData *result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&resp error:&err];
    NSString* accessToken = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
     [self.modelAccessor createMyProfile:_nameTextField.text accessToken:accessToken result:^(UIMyProfile *myProfile) {
         if (myProfile) {
             [SVProgressHUD showSuccessWithStatus:@"Registered successfully!"];
             [self dismissViewControllerAnimated:YES completion:nil];
             return;
         }
         [SVProgressHUD showErrorWithStatus:@"Error occured :("];
     }];
}

@end
