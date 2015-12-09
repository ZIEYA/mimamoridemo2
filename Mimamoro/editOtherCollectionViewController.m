//
//  editOtherCollectionViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "editOtherCollectionViewController.h"
#import "editOtherCollectionViewCell.h"
@interface editOtherCollectionViewController ()
{
    editOtherCollectionViewCell *cell;
    NSArray*otherImgTitle;
    NSArray*otherNameTitle;
    NSMutableDictionary*othersoft;
    NSMutableDictionary*othersoft2;
}
@end

@implementation editOtherCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    othersoft = [[NSMutableDictionary alloc]init];
    othersoft2 = [[NSMutableDictionary alloc]init];
    if (!othersoft2) {
        othersoft2 = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    othersoft2 = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"otherSoftTotyu123"]];
    otherImgTitle = [[NSArray alloc]initWithObjects:@"other1000",@"other222",@"other111",@"other1300",@"other333",@"other555",@"other1100",@"other999",@"other888",@"other777",@"other1200", nil];
    otherNameTitle = [[NSArray alloc]initWithObjects:@"脈拍測定",@"電気守り",@"ポケット医者",@"老人たち",@"電卓",@"音楽",@"メモ帳",@"メール管理",@"診察を予約",@"病院連絡",@"老人用品", nil];
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return otherImgTitle.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"editOtherCell";
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.otherImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[otherImgTitle objectAtIndex:indexPath.row]]]];
    cell.otherLabel.text = [otherNameTitle objectAtIndex:indexPath.row];
    
    UIView*selview = [[UIView alloc]initWithFrame:cell.frame];
    selview.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    selview.layer.cornerRadius = 11;
    cell.selectedBackgroundView = selview;
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(87, 100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 5, 15, 5);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (editOtherCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    keyAnima.values = @[@(-M_PI_4 /90.0 * 15),@(M_PI_4 /90.0 * 15),@(-M_PI_4 /90.0 * 15)];
    //执行完之后不删除动画
    keyAnima.removedOnCompletion = YES;
    //执行完之后保存最新的状态
    keyAnima.fillMode = kCAFillModeForwards;
    //动画执行时间
    keyAnima.duration = 0.2;
    //设置重复次数。
    keyAnima.repeatCount = 2;
    //添加核心动画
    [cell.otherImg.layer addAnimation:keyAnima forKey:nil];
    //familyImg = familyTitle[indexPath.row];下載脈拍傍受か
    //familynumber = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"ヒント" message:[NSString stringWithFormat:@"下載%@か",cell.otherLabel.text] preferredStyle: UIAlertControllerStyleAlert];
    [alert2 addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [othersoft setValue:[otherImgTitle objectAtIndex:indexPath.row] forKey:@"otherImgTitle"];
        [othersoft setValue:[otherNameTitle objectAtIndex:indexPath.row] forKey:@"otherNameTitle"];
        [othersoft2 setObject:othersoft forKey:[otherNameTitle objectAtIndex:indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults]setObject:othersoft2 forKey:@"otherSoftTotyu123"];
    }]];
    [alert2 addAction:[UIAlertAction actionWithTitle:@"まだ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    //弹出提示框；
    [self presentViewController:alert2 animated:true completion:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
