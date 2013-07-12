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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerTapped:(id)sender {
    NSManagedObjectContext* moc = [inject(ModelManager) managedObjectContext];
    [moc performBlock:^{
        if ([moc createMyProfile]) {
            if ([moc save:nil]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

@end
