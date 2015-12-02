//
//  OtherCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "OtherCollectionViewController.h"
#import "SettingCollectionViewCell.h"

@interface OtherCollectionViewController ()

@end

@implementation OtherCollectionViewController

static NSString * const reuseIdentifier = @"settingcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarItem setImage:[[UIImage imageNamed:@"contactlist"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[SettingCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SettingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section ==0 && indexPath.row ==0) {
        cell.imageview.image = [UIImage imageNamed:@"settingimage.png"];
        cell.label.text =@"設定";
    }
    if (indexPath.section ==0 && indexPath.row ==1) {
        cell.imageview.image = [UIImage imageNamed:@"homeimage.png"];
        cell.label.text =@"ポケットドクター";
    }
    if (indexPath.section ==1 && indexPath.row ==0) {
        cell.imageview.image = [UIImage imageNamed:@"lightimage.png"];
        cell.label.text =@"電気守り";
    }
    if (indexPath.section ==1 && indexPath.row ==1) {
        cell.imageview.image = [UIImage imageNamed:@"plusimage.png"];
        cell.label.text =@"";
    }
    
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 && indexPath.row ==0) {
        [self performSegueWithIdentifier:@"gotoSettingVC" sender:self];
    }
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
