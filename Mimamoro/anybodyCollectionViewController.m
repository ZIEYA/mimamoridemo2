//
//  anybodyCollectionViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "anybodyCollectionViewController.h"
#import "anybodyCollectionViewCell.h"
#import "GuardTableViewController.h"
@interface anybodyCollectionViewController ()
{
    anybodyCollectionViewCell*cell;
    NSMutableArray*anyArray;
    NSMutableArray *imggg;
    NSMutableArray *nameee;
}
@end

@implementation anybodyCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"anybody"];

    nameee = [[NSMutableArray alloc]init];
    imggg = [[NSMutableArray alloc]init];
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadGroups];
}
-(void)reloadGroups{
    [nameee removeAllObjects];
    [imggg removeAllObjects];
    NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"group8"];
   // _groArray = [[NSMutableArray alloc]initWithArray:temp];
    for (NSDictionary *tmpdict in temp) {
  
        [nameee addObject:[tmpdict valueForKey:@"groupname"]];
        [imggg addObject:[tmpdict valueForKey:@"image"]];
        
        NSLog(@"%@",tmpdict);
    }
    //NSLog(@"group array:%@",_groupArray);
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imggg.count;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, self.view.frame.size.width/8, 15, self.view.frame.size.width/8);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * reuseIdentifier = @"anybodyCell";
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.anybodyImg.image  =[UIImage imageNamed:imggg[indexPath.row]];
    cell.anybodyName.text = nameee[indexPath.row];
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"GuardPush"])
    {
        GuardTableViewController *GuardTableView = segue.destinationViewController;
        NSArray *indexPath = [self.collectionView indexPathsForSelectedItems];
        cell = (anybodyCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath[0]];
        GuardTableView.GuardName = cell.anybodyName.text;
    }
}
@end
