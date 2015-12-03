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

@interface ContactCollectionViewController (){
    NSMutableDictionary *_contactDict;
    NSMutableArray *_groupArr;
    NSMutableArray *_wifeArr;
    NSMutableArray *_daughterArr;
    NSMutableArray *_sonArr;
    NSMutableArray *_friendArr;
    NSMutableArray *_doctorArr;
    NSInteger *groupcount;
    
    NSString *groupID;
}

@end

@implementation ContactCollectionViewController

static NSString * const reuseIdentifier = @"mycell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_groupArr) {
        _groupArr = [[NSMutableArray alloc]init];
    }
    [_groupArr addObject:@"配偶者"];
    [_groupArr addObject:@"息子"];
    [_groupArr addObject:@"娘"];
    [_groupArr addObject:@"親友"];
    
    if (!_wifeArr) {
        _wifeArr = [[NSMutableArray alloc]init];
    }
    if (!_daughterArr) {
        _daughterArr =[[NSMutableArray alloc]init];
    }
    if (!_sonArr) {
        _sonArr =[[NSMutableArray alloc]init];
    }
    if (!_friendArr) {
        _friendArr =[[NSMutableArray alloc]init];
    }
    if (!_doctorArr) {
        _doctorArr =[[NSMutableArray alloc]init];
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
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.label.text = @"配偶者";
        cell.imageview.image = [UIImage imageNamed:@"spouse.png"];
        groupID = @"配偶者";
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.label.text = @"息子";
        cell.imageview.image = [UIImage imageNamed:@"son.png"];
        groupID = @"息子";
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.label.text = @"娘";
        cell.imageview.image = [UIImage imageNamed:@"daughter.png"];
        groupID = @"娘";
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.label.text = @"親友";
        cell.imageview.image = [UIImage imageNamed:@"friend.png"];
        groupID = @"親友";
    }
    else{
        cell.label.text = @"追加";
        cell.imageview.image = [UIImage imageNamed:@"addgroup.png"];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
    [self performSegueWithIdentifier:@"gotoAddGroupVC" sender:self];
    }
    else{
    [self performSegueWithIdentifier:@"gotoContactTVC" sender:self];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ContactTableViewController *contactTVC = segue.destinationViewController;
    contactTVC.groupid = groupID;
}


@end
