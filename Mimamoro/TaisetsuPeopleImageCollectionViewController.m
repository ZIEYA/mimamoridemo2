//
//  TaisetsuPeopleImageCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/16.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "TaisetsuPeopleImageCollectionViewController.h"
#import "TaisetsuImageCollectionViewCell.h"

@interface TaisetsuPeopleImageCollectionViewController (){
    NSMutableArray *_imageStrArray;
}

@end

@implementation TaisetsuPeopleImageCollectionViewController

static NSString * const reuseIdentifier = @"taisetsuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageStrArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<12; i++) {
        NSString *str = [NSString stringWithFormat:@"item-%d",i];
        [_imageStrArray addObject:str];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _imageStrArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TaisetsuImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *tmp = [_imageStrArray objectAtIndex:(indexPath.section * 3 + indexPath.row)];
    cell.imageview.image = [UIImage imageNamed:tmp];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tmpstr = [_imageStrArray objectAtIndex:(indexPath.section *3 + indexPath.row)];
    [self.imagedelegate setSelectedImage:tmpstr];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark <UICollectionViewDelegate>



@end
