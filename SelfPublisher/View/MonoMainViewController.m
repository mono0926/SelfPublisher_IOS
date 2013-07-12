//
//  MonoMainViewController.m
//  SelfPublisher
//
//  Created by mono on 6/30/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import "MonoMainViewController.h"
#import "MonoBookCell.h"
#import "MonoUI.h"
#import "MonoBookViewController.h"
#import <CoreData/CoreData.h>

@interface MonoMainViewController ()

@end

@implementation MonoMainViewController

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
    if (!self.modelAccessor.myProfile) {
        [self performSegueWithIdentifier:@"registration" sender:self];
    }
    
    [self.collectionView registerClass:[MonoBookCell class] forCellWithReuseIdentifier:@"MonoBookCell"];
    self.collectionView.alwaysBounceVertical = YES;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelAccessor.books.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MonoBookCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MonoBookCell" forIndexPath:indexPath];
    cell.book = self.modelAccessor.books[indexPath.row];
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"b%d.jpg", indexPath.row + 1]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Book" bundle:nil];
    UINavigationController *vc = [sb instantiateInitialViewController];
    MonoBookViewController* monoVC = vc.viewControllers[0];
    monoVC.book = self.modelAccessor.books[indexPath.row];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)addTapped:(id)sender {
    
}
@end
