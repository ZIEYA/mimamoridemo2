//
//  OtherCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "OtherCollectionViewController.h"
#import "SettingCollectionViewCell.h"
#import "softDetailsViewController.h"
#import "LeafNotification.h"
@interface OtherCollectionViewController ()
{
    SettingCollectionViewCell *cell;
    NSDictionary *othersft;
    NSMutableDictionary *othersft2;
    NSMutableArray *othersft3;
    NSMutableDictionary *editt;
    NSMutableDictionary *system;
}
@end

@implementation OtherCollectionViewController

static NSString * const reuseIdentifier = @"settingcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    othersft3 = [[NSMutableArray alloc]init];
    editt = [[NSMutableDictionary alloc]init];
    system = [[NSMutableDictionary alloc]init];
    [system setValue:@"other444" forKey:@"otherImgTitle"];
    [system setValue:@"設定" forKey:@"otherNameTitle"];
    [othersft3 addObject:system];
    [editt setValue:@"contacts" forKey:@"otherImgTitle"];
    [editt setValue:@"連絡先" forKey:@"otherNameTitle"];
    [othersft3 addObject:editt];
    
    [self.tabBarItem setImage:[[UIImage imageNamed:@"contactlist"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
    [self.collectionView reloadData];
    //[self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return othersft3.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        NSDictionary *temp = [othersft3 objectAtIndex:indexPath.row];
        cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[temp valueForKey:@"otherImgTitle"]]];
        cell.label.text = [temp valueForKey:@"otherNameTitle"];
    UIView*selview = [[UIView alloc]initWithFrame:cell.frame];
    selview.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    selview.layer.cornerRadius = 11;
    cell.selectedBackgroundView = selview;
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 130);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, self.view.frame.size.width/9, 15, self.view.frame.size.width/9);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        [self performSegueWithIdentifier:@"gotoSettingVC" sender:self];
    }else if (indexPath.row ==othersft3.count-1) {
        [self performSegueWithIdentifier:@"gotoeditother" sender:self];
    }
}

@end
