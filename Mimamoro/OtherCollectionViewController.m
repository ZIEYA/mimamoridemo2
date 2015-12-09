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
    NSArray *other;
    NSArray *other2;
    NSDictionary *othersft;
    NSMutableDictionary *othersft2;
    NSMutableArray *othersft3;
    NSMutableDictionary *editt;
    NSMutableDictionary *system;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteSoft;
@end

@implementation OtherCollectionViewController

static NSString * const reuseIdentifier = @"settingcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deletee:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.collectionView addGestureRecognizer:longPressGr];

    
    othersft3 = [[NSMutableArray alloc]init];
    editt = [[NSMutableDictionary alloc]init];
    system = [[NSMutableDictionary alloc]init];
    if (!(othersft3 ==nil)) {
        [othersft3 removeLastObject];
    }
    [system setValue:@"other444" forKey:@"otherImgTitle"];
    [system setValue:@"設定" forKey:@"otherNameTitle"];
    [othersft3 addObject:system];
    othersft = [[NSDictionary alloc]init];
    othersft = [[NSUserDefaults standardUserDefaults]objectForKey:@"otherSoftTotyu123"];
    othersft2 = [[NSMutableDictionary alloc]initWithDictionary:othersft];
    //NSLog(@"othersft2:%@",othersft2);
    NSArray *keysArr = [othersft2 allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [othersft2 objectForKey:keysArr[i]];
        [othersft3 addObject:tempDict];
    }
    [editt setValue:@"edit" forKey:@"otherImgTitle"];
    [editt setValue:@"" forKey:@"otherNameTitle"];
    [othersft3 addObject:editt];
    [self.tabBarItem setImage:[[UIImage imageNamed:@"contactlist"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //@"homeimage.png",@"lightimage.png",
    //@"ポケットドクター",@"電気守り",
    other = [[NSArray alloc]initWithObjects:@"other1",@"edit.png", nil];
    other2 = [[NSArray alloc]initWithObjects:@"設定",@"", nil];
}
- (IBAction)delsoft:(id)sender {
    [LeafNotification showInController:self withText:[NSString stringWithFormat:@"長押しのアイコンを削除する"]];
}

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
    [self.collectionView reloadData];
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
    return UIEdgeInsetsMake(15, 35, 15, 35);
}



#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 && indexPath.row ==0) {
        [self performSegueWithIdentifier:@"gotoSettingVC" sender:self];
    }else if (indexPath.section ==0 && indexPath.row ==othersft3.count-1) {
        [self performSegueWithIdentifier:@"gotoeditother" sender:self];
    }else{
        [self performSegueWithIdentifier:@"softDetails" sender:self];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"softDetails"]) {
        softDetailsViewController *editfam = segue.destinationViewController;
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        NSDictionary *temp1 = [othersft3 objectAtIndex:indexPath.row];
        editfam.sImage =[temp1 valueForKey:@"otherImgTitle"];
        editfam.sTitle =[temp1 valueForKey:@"otherNameTitle"];
    }
}


-(void)deletee:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.collectionView];
        NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:point];
        if(indexPath == nil) return ;
        cell = (SettingCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"ヒント" message:@"削除しますか" preferredStyle: UIAlertControllerStyleAlert];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            NSLog(@"成功删除");
            [othersft2 removeObjectForKey:cell.label.text];
            [[NSUserDefaults standardUserDefaults]setObject:othersft2 forKey:@"otherSoftTotyu123"];
            [self viewDidLoad];
            [self.collectionView reloadData];
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"まだ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert2 animated:true completion:nil];
    }
}

@end
