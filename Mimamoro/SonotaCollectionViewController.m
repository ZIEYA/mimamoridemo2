//
//  SonotaCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/15.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "SonotaCollectionViewController.h"
#import "SonotaCollectionViewCell.h"

@interface SonotaCollectionViewController ()

@end

@implementation SonotaCollectionViewController

static NSString * const reuseIdentifier = @"sonotacell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SonotaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if(indexPath.section ==0 && indexPath.row ==0){
        cell.imageview.image = [UIImage imageNamed:@"settingimage"];
        cell.label.text = @"設定";
    }else if (indexPath.section ==0 && indexPath.row ==1){
        cell.imageview.image = [UIImage imageNamed:@"image-1"];
        cell.label.text = @"連絡先";
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0 && indexPath.row ==0){
        [self performSegueWithIdentifier:@"gotoSettingVC" sender:self];
    }
    else if (indexPath.section ==0 && indexPath.row ==1){
        [self performSegueWithIdentifier:@"gotocontactVC" sender:self];
    }
    
}

@end
