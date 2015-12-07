//
//  ItemImageCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/07.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ItemImageCollectionViewController.h"
#import "ItemImageCollectionViewCell.h"

@interface ItemImageCollectionViewController (){
    NSMutableArray *_imageArray;
}

@end

@implementation ItemImageCollectionViewController

static NSString * const reuseIdentifier = @"imagecell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray = [[NSMutableArray alloc]init];
    for (int i=1; i<11; i++) {
        NSString *str = [NSString stringWithFormat:@"image-%d",i];
        [_imageArray addObject:str];
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
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *tmpstr = [_imageArray objectAtIndex:(indexPath.section*2 + indexPath.row)];
    cell.imageview.image = [UIImage imageNamed:tmpstr];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tmpstr = [_imageArray objectAtIndex:(indexPath.section*2 + indexPath.row)];
    [self.itemdelegate setSelectedImage:tmpstr];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
