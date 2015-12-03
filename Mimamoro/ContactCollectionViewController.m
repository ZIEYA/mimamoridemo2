//
//  ContactCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactCollectionViewController.h"
#import "ContactCollectionViewCell.h"
#import "ContactTableViewController.h"
#import "AddGroupTableViewController.h"

@interface ContactCollectionViewController (){
    NSMutableDictionary *_contactDict;
    NSMutableArray *_groupArray;
  
    NSInteger *groupcount;
    
    NSString *groupID;
}

@end

@implementation ContactCollectionViewController

static NSString * const reuseIdentifier = @"mycell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_groupArray) {
        _groupArray = [[NSMutableArray alloc]init];
        [_groupArray addObject:@"配偶者"];
        [_groupArray addObject:@"息子"];
        [_groupArray addObject:@"娘"];
        [_groupArray addObject:@"親友"];
        [[NSUserDefaults standardUserDefaults]setObject:_groupArray forKey:@"group"];
    }
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadContactList{
    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contactlist"];
    _contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
    NSArray *keysArr = [_contactDict allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [_contactDict objectForKey:keysArr[i]];
        //NSLog(@"tempdict:%@",tempDict);
        NSString *type = [tempDict valueForKey:@"contacttype"];
//        if ([type isEqualToString:@"0"]) {
//            [_emergencyArr addObject:tempDict];
//        }else if ([type isEqualToString:@"1"]){
//            [_worryArr addObject:tempDict];
//        }
    }

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

    return _groupArray.count +1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section *2 + indexPath.row) == _groupArray.count) {
        
        ContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.imageview.image =[UIImage imageNamed:@"addgroup.png"];
        cell.label.text = @"追加";
        return cell;
    }
    ContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.label.text = [_groupArray objectAtIndex:(indexPath.section*2 + indexPath.row )];
    if ([cell.label.text isEqualToString:@"配偶者"]) {
        cell.imageview.image = [UIImage imageNamed:@"spouse.png"];
    }
    if ([cell.label.text isEqualToString:@"息子"]) {
        cell.imageview.image = [UIImage imageNamed:@"son.png"];
    }
    if ([cell.label.text isEqualToString:@"娘"]) {
        cell.imageview.image = [UIImage imageNamed:@"daughter.png"];
    }
    if ([cell.label.text isEqualToString:@"親友"]) {
        cell.imageview.image = [UIImage imageNamed:@"friend.png"];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_groupArray.count == (indexPath.section *2 + indexPath.row)){
        groupID = @"";
        [self performSegueWithIdentifier:@"gotoAddGroupVC" sender:self];
        
    }else{
        groupID = [_groupArray objectAtIndex:(indexPath.section*2 + indexPath.row)];
        [self performSegueWithIdentifier:@"gotoContactTVC" sender:self];
    }


    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"gotoContactTVC"]) {
        ContactTableViewController *contactTVC = segue.destinationViewController;
        contactTVC.groupid = groupID;
    }else if ([segue.identifier isEqualToString:@"gotoAddGroupVC"]){
        AddGroupTableViewController *addTVC = segue.destinationViewController;
    }

}


@end
