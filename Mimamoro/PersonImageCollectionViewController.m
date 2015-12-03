//
//  PersonImageCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "PersonImageCollectionViewController.h"
#import "PersonCollectionViewCell.h"

@interface PersonImageCollectionViewController (){
    NSMutableArray *_imageArray ;
}

@end

@implementation PersonImageCollectionViewController

static NSString * const reuseIdentifier = @"personcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"item-%d",i]];
        [_imageArray addObject:image];
    }
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageview.image = [_imageArray objectAtIndex:(indexPath.section * 4 + indexPath.row)];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *selectImage = [_imageArray objectAtIndex:(indexPath.section *3 + indexPath.row)];
    [self.imagedelegate setSelectedImage:selectImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark <UICollectionViewDelegate>



@end
