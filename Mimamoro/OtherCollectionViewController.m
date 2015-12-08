//
//  OtherCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "OtherCollectionViewController.h"
#import "SettingCollectionViewCell.h"
#import "ItemModel.h"
#import "AddNewItemTableViewController.h"

@interface OtherCollectionViewController (){
    //NSMutableArray *_newItemArray;
    //NSMutableArray *_showItemArray;
    NSMutableArray *_defaultItemArray;
    NSMutableArray *_itemArray;
    int editType;//0:新規 1:編集
    NSString *tempItemName;
    NSString *tempItemImage;
}

@end

@implementation OtherCollectionViewController

static NSString * const reuseIdentifier = @"settingcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarItem setImage:[[UIImage imageNamed:@"contactlist"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    _itemArray = [[NSMutableArray alloc]init];
    NSMutableArray *tmparr = [[NSUserDefaults standardUserDefaults]objectForKey:@"item"];
    if (!tmparr) {
        //Default items
        _defaultItemArray = [[NSMutableArray alloc]init];
        NSDictionary *temp1 = [self addDefaultItemName:@"設定" WithImage:@"image-7.png"];
        NSDictionary *temp2 = [self addDefaultItemName:@"ポケットドクター" WithImage:@"hospital.png"];
        NSDictionary *temp3 = [self addDefaultItemName:@"電気見守り" WithImage:@"home.png"];
        [_defaultItemArray addObject:temp1];
        [_defaultItemArray addObject:temp2];
        [_defaultItemArray addObject:temp3];
        [[NSUserDefaults standardUserDefaults]setObject:_defaultItemArray forKey:@"item"];
    }else{
        _itemArray = [[NSMutableArray alloc]initWithArray:tmparr];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)reloadItems{
    

    [_itemArray  removeAllObjects];
    NSMutableArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"item"];
    for (NSDictionary *tmpdict in temp) {
        ItemModel *model = [[ItemModel alloc]init];
        model.itemname = [tmpdict valueForKey:@"name"];
        model.itemimage = [tmpdict valueForKey:@"image"];
        [_itemArray addObject:model];
    }
    
    [self.collectionView reloadData];
}

-(NSDictionary*)addDefaultItemName:(NSString*)itemname WithImage:(NSString*)image{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    [temp setValue:itemname forKey:@"name"];
    [temp setValue:image forKey:@"image"];
    return temp;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier  isEqual: @"gotoAddNewItemTVC"]){
        AddNewItemTableViewController *addVC = segue.destinationViewController;
        addVC.tmpitemName = tempItemName;
        addVC.tmpitemImage = tempItemImage;
        addVC.edittype = editType;
    }

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SettingCollectionViewCell *cell;
    if ((indexPath.section *2 + indexPath.row) ==_itemArray.count) {
       cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.label.text = @"";
        cell.imageview.image = [UIImage imageNamed:@"add.png"];
        return cell;
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        ItemModel *model= [_itemArray objectAtIndex:(indexPath.section *2 +indexPath.row)];
        cell.imageview.image = [UIImage imageNamed:model.itemimage];
        cell.label.text = model.itemname;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    tempItemName = nil;
    tempItemImage =nil;
    //Setting table view controller
    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.section ==0 && indexPath.row ==0) {
        [self performSegueWithIdentifier:@"gotoSettingVC" sender:self];
    }
    //DenkiManage view controller
    else if(indexPath.section ==0 && indexPath.row ==2){
        [self performSegueWithIdentifier:@"gotoDenkiManageVC" sender:self
         ];
    }
    else if (indexPath.section ==0 && indexPath.row ==1){
        [self performSegueWithIdentifier:@"gotoPocketDoctorVC" sender:self];
    }
    //Add new item view controller
    else if ((indexPath.section *2+indexPath.row) == _itemArray.count){
        [self performSegueWithIdentifier:@"gotoAddNewItemTVC" sender:self];
        editType = 0;
    }else{
        ItemModel *model= [_itemArray objectAtIndex:(indexPath.section *2 +indexPath.row )];
        editType = 1;
        tempItemName = model.itemname;
        tempItemImage = model.itemimage;
        [self performSegueWithIdentifier:@"gotoAddNewItemTVC" sender:self];
        
    }
}


@end
