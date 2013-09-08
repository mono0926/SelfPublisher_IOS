//
//  SettingViewController.m
//  SelfPublisher
//
//  Created by mono on 9/7/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "SettingViewController.h"
#import "MonoUI.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *dropboxEnabledSwitch;

@end

@implementation SettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dropboxEnabledSwitch.on = self.modelAccessor.myProfile.isDropboxEnabled;
}
- (IBAction)dropboxEnabledChanged:(UISwitch*)dropboxSwitch
{
    UIActionSheet* actionSheet = [UIActionSheet actionSheetWithTitle:@""];
    [actionSheet setCancelButtonWithTitle:@"Cancel"
                                  handler:^{
                                      dropboxSwitch.on = !dropboxSwitch.on;
                                  }];
    if (dropboxSwitch.isOn) {
        actionSheet.title = @"You'll be able to insert images to your books.";
        [actionSheet setDestructiveButtonWithTitle:@"Enable"
                                           handler:^{
                                               [self.modelAccessor authorizeWithNavigationController:self.navigationController];
                                               self.modelAccessor.myProfile.isDropboxEnabled = YES;
                                           }];
    } else {
        actionSheet.title = @"Your all inserted images will be cleared.";
        [actionSheet setDestructiveButtonWithTitle:@"Disable"
                                           handler:^{
#warning 認証を切る
                                               self.modelAccessor.myProfile.isDropboxEnabled = NO;
                                           }];
        
    }
    [actionSheet showInView:self.view.window];
}
- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
