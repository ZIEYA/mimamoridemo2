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
#import "GroupModel.h"

@interface ContactCollectionViewController (){
    NSMutableDictionary *_contactDict;
    NSMutableArray *_defaultGroupArray;
    NSMutableArray *_groupArray;
    NSString *groupID;
}

@end

@implementation ContactCollectionViewController

static NSString * const reuseIdentifier = @"mycell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _groupArray = [[NSMutableArray alloc]init];
    if (!_defaultGroupArray) {
        _defaultGroupArray = [[NSMutableArray alloc]init];
        //Setting default groups
        NSDictionary *temp1 = [self addDefaultGroupName:@"配偶者" WithImage:@"spouse.png"];
        NSDictionary *temp2 = [self addDefaultGroupName:@"息子" WithImage:@"son.png"];
        NSDictionary *temp3 = [self addDefaultGroupName:@"娘" WithImage:@"daughter.png"];
        NSDictionary *temp4 = [self addDefaultGroupName:@"親友" WithImage:@"friend.png"];
        [_defaultGroupArray addObject:temp1];
        [_defaultGroupArray addObject:temp2];
        [_defaultGroupArray addObject:temp3];
        [_defaultGroupArray addObject:temp4];

        [[NSUserDefaults standardUserDefaults]setObject:_defaultGroupArray forKey:@"group"];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [self reloadGroups];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSDictionary *)addDefaultGroupName:(NSString*)groupname WithImage:(NSString*)image{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]initWithCapacity:0];
    [temp setValue:groupname forKey:@"groupname"];
    [temp setValue:image forKey:@"image"];
    return temp;
}

-(void)reloadGroups{
    [_groupArray removeAllObjects];
    NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"group"];
    for (NSDictionary *tmpdict in temp) {
        GroupModel *model = [[GroupModel alloc]init];
        model.groupname = [tmpdict valueForKey:@"groupname"];
        model.groupimage = [tmpdict valueForKey:@"image"];
        [_groupArray addObject:model];
    }

    [self.collectionView reloadData];
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

    return _groupArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    GroupModel *model = [_groupArray objectAtIndex:indexPath.row];
    cell.label.text = model.groupname;
    cell.imageview.image = [UIImage imageNamed:model.groupimage];
     
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GroupModel *model = [_groupArray objectAtIndex:indexPath.row];
    groupID = model.groupname;
    [self performSegueWithIdentifier:@"gotoContactTVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"gotoContactTVC"]) {
        ContactTableViewController *contactTVC = segue.destinationViewController;
        contactTVC.groupid = groupID;
    }
//    else if ([segue.identifier isEqualToString:@"gotoAddGroupVC"]){
//        AddGroupTableViewController *addTVC = segue.destinationViewController;
//    }

}


@end
