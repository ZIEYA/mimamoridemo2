//
//  ContactCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactCollectionViewController.h"
#import "ContactTableViewController.h"
#import "ContactCollectionViewCell.h"
#import "EditContactViewController.h"
#import "LeafNotification.h"
@interface ContactCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    ContactCollectionViewCell*cell;
    NSArray*connectionTitle;
    NSMutableDictionary *connectionbtn;
    NSMutableArray *connectionnum;
    NSDictionary *fatitl;
    NSArray * titlll;
    NSArray * imgeee;
    NSMutableDictionary*dddd;
    NSMutableDictionary*ffff;
    NSDictionary *cccc;
}

@end

@implementation ContactCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    cccc =[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"];
    if (cccc.count == 0) {
        dddd = [[NSMutableDictionary alloc]init];
        ffff = [[NSMutableDictionary alloc]init];
        
        titlll =[[NSArray alloc]initWithObjects:@"妻",@"親友",@"娘",@"息子", nil];
        imgeee =[[NSArray alloc]initWithObjects:@"妻",@"親友",@"娘",@"息子", nil];
        NSLog(@"%lu",(unsigned long)titlll.count);
        for (int i = 0; i<imgeee.count; i++) {
            ffff =[[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
            [dddd setValue:titlll[i] forKey:@"titlee"];
            [dddd setValue:imgeee[i] forKey:@"imagee"];
            [dddd setValue:[NSString stringWithFormat:@"%d",i] forKey:@"numberr"];
            [ffff setObject:dddd forKey:titlll[i]];
            [[NSUserDefaults standardUserDefaults]setObject:ffff forKey:@"famTitleArrr"];
            NSLog(@"dddd%@",dddd);
            NSLog(@"ffff%@",ffff);
        }
        
    }    fatitl = [[NSDictionary alloc]init];
    fatitl = [[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"];
    connectionbtn =[[NSMutableDictionary alloc]initWithDictionary:fatitl];
    connectionnum =[[NSMutableArray alloc]init];
    connectionTitle = [[NSArray alloc]initWithObjects:@"妻",@"夫",@"親友",@"息子",@"嫁",@"娘",@"婿",@"孫",@"孫娘",@"医者",@"看護婦", nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContactList];
    [self.collectionView reloadData];
}
-(void)reloadContactList{
    [connectionnum removeAllObjects];
    fatitl = [[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"];
    connectionbtn =[[NSMutableDictionary alloc]initWithDictionary:fatitl];
    NSArray *keysArr = [connectionbtn allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [connectionbtn objectForKey:keysArr[i]];
        [connectionnum addObject:tempDict];
    }
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return connectionnum.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    NSDictionary *temp = [connectionnum objectAtIndex:indexPath.row];
    
    [cell.image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[temp valueForKey:@"imagee"]]]];
    cell.name.text = [temp valueForKey:@"titlee"];
    
    
    UIView*selview = [[UIView alloc]initWithFrame:cell.frame];
    selview.backgroundColor = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1];
    selview.layer.cornerRadius = 11;
    cell.selectedBackgroundView = selview;
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(85, 100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"lai"])
    {
        ContactTableViewController *ContactTableView = segue.destinationViewController;
        NSArray *indexPath = [self.collectionView indexPathsForSelectedItems];
        cell = (ContactCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath[0]];
        ContactTableView.family = cell.name.text;
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
