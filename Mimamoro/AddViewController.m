
//
//  AddViewController.m
//  Mimamoro
//
//  Created by totyu3 on 15/12/8.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (strong, nonatomic) UITextField *groupName;
@property (strong, nonatomic) UIImage *groupImage;
@property (strong, nonatomic) UICollectionView *collectionView;

@property(strong , nonatomic) NSArray *imageArr;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArr = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"ren1.png"],[UIImage imageNamed:@"ren2.png"],[UIImage imageNamed:@"ren3.ico"],[UIImage imageNamed:@"ren4.ico"],[UIImage imageNamed:@"ren5.ico"],[UIImage imageNamed:@"ren6.ico"],[UIImage imageNamed:@"ren6.ico"],[UIImage imageNamed:@"ren8.ico"],[UIImage imageNamed:@"ren7.ico"],[UIImage imageNamed:@"ren10.ico"],nil];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = save;
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //flowlayout.itemSize = CGSizeMake(100,100);
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05,self.view.bounds.size.height*0.15,self.view.bounds.size.width*0.9,self.view.bounds.size.width*0.6)collectionViewLayout:flowlayout];
    self.collectionView.backgroundColor = [UIColor brownColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
    [self.view addSubview:self.collectionView];
    

    self.groupName = [[UITextField alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height*0.5, 200, 40)];
    self.groupName.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.groupName];
    
    self.collectionView.dataSource =self;
    self.collectionView.delegate = self;
}
#pragma mark - collectionview datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"mycell";
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor redColor];
    UIImageView *img = [[UIImageView alloc]init];
    img.frame = CGRectMake(0, 0, 90, 90);
    [cell addSubview:img];
    img.image = self.imageArr[indexPath.row];
    return cell;
}
#pragma mark - uicollectionviewdelegate flowlayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return CGSizeMake(100, 100);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark - uicollcetionviewdelegate
//选中调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
}
//返回这个uicollectionview是否可以选择
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - save事件
-(void)saveAction
{
    NSMutableDictionary *add = [[NSMutableDictionary alloc]init];
    [add setValue:self.groupName.text forKey:@"name"];
    self.rootArr = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"root"]];

    NSLog(@"22:%@",self.rootArr);
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    if (self.rootArr.count==0) {
        [self.rootArr addObject:add];
        [userdef setObject:_rootArr forKey:@"root"];
    }else{
        [self.rootArr addObject:add];
        [userdef removeObjectForKey:@"root"];
        [userdef setObject:_rootArr forKey:@"root"];
    }
    [userdef synchronize];
    [self.navigationController popViewControllerAnimated:YES];
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

@end
