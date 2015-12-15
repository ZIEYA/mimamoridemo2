//
//  ciruViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ciruViewController.h"
#import "ciruCollectionViewCell.h"
#import "softDetailsViewController.h"
#import "LeafNotification.h"

@interface ciruViewController ()
{
    ciruCollectionViewCell *cell;
    NSDictionary *othersft;
    NSMutableDictionary *othersft2;
    NSMutableArray *othersft3;
    NSMutableDictionary *editt;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteSoft1;
@end

@implementation ciruViewController

static NSString * const reuseIdentifier = @"settingcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deletee:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.collectionView addGestureRecognizer:longPressGr];
    othersft3 = [[NSMutableArray alloc]init];
    editt = [[NSMutableDictionary alloc]init];
        if (!(othersft3 ==nil)) {
            [othersft3 removeLastObject];
        }
        othersft = [[NSDictionary alloc]init];
        othersft = [[NSUserDefaults standardUserDefaults]objectForKey:@"otherSoftTotyu123"];
        othersft2 = [[NSMutableDictionary alloc]initWithDictionary:othersft];
        NSArray *keysArr = [othersft2 allKeys];
        for (int i = 0; i<keysArr.count; i++) {
            NSDictionary *tempDict = [othersft2 objectForKey:keysArr[i]];
            [othersft3 addObject:tempDict];
        }
    [editt setValue:@"edit" forKey:@"otherImgTitle"];
    [editt setValue:@"" forKey:@"otherNameTitle"];
    [othersft3 addObject:editt];
    
    [self.tabBarItem setImage:[[UIImage imageNamed:@"contactlist"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (IBAction)delsoft1:(id)sender {
    [LeafNotification showInController:self withText:[NSString stringWithFormat:@"長押しのアイコンを削除する"]];
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
    cell.imageview1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[temp valueForKey:@"otherImgTitle"]]];
    cell.label1.text = [temp valueForKey:@"otherNameTitle"];
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
    if (indexPath.row ==othersft3.count-1) {
        [self performSegueWithIdentifier:@"otheredit" sender:self];
    }else{
        [self performSegueWithIdentifier:@"details" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        if ([segue.identifier isEqualToString:@"details"]) {
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
        cell = (ciruCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        if (!(indexPath.row ==othersft3.count-1)) {
            UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"ヒント" message:@"削除しますか" preferredStyle: UIAlertControllerStyleAlert];
            [alert2 addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                NSLog(@"成功删除");
                [othersft2 removeObjectForKey:cell.label1.text];
                [[NSUserDefaults standardUserDefaults]setObject:othersft2 forKey:@"otherSoftTotyu123"];
                [self viewDidLoad];
                [self.collectionView reloadData];
                //[self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            }]];
            [alert2 addAction:[UIAlertAction actionWithTitle:@"まだ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert2 animated:true completion:nil];
        }
    }
}

@end
