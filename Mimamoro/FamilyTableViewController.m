//
//  FamilyTableViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "FamilyTableViewController.h"
#import "FamilyTableViewCell.h"
#import "LeafNotification.h"
#import "FamilyViewController.h"
@interface FamilyTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    FamilyTableViewCell*cell;
    NSMutableDictionary *connectionbtn1;
    NSMutableArray *connectionnum1;
    NSDictionary *fatitl1;
    NSString *tempname;
    NSString *nummm;
}

@end

@implementation FamilyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    fatitl1 = [[NSDictionary alloc]init];
    connectionbtn1 =[[NSMutableDictionary alloc]initWithDictionary:fatitl1];
    connectionnum1 =[[NSMutableArray alloc]init];
    NSLog(@"connectionbtn1:%@",connectionbtn1);
    NSLog(@"connectionnum1:%@",connectionnum1);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContactList];
    [self.tableView reloadData];
}
-(void)reloadContactList{
    [connectionnum1 removeAllObjects];
    fatitl1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"];
    connectionbtn1 =[[NSMutableDictionary alloc]initWithDictionary:fatitl1];
    NSArray *keysArr = [connectionbtn1 allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [connectionbtn1 objectForKey:keysArr[i]];
        [connectionnum1 addObject:tempDict];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"editfam"]) {
    FamilyViewController *editfam = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    editfam.titll =[[connectionnum1 objectAtIndex:indexPath.row]valueForKey:@"titlee"];;
    editfam.numbb =[[connectionnum1 objectAtIndex:indexPath.row]valueForKey:@"numberr"];;
    editfam.famtype = @"1";
    }else if ([segue.identifier isEqualToString:@"editFamily"]) {
    FamilyViewController *editfam = segue.destinationViewController;
    editfam.famtype = @"0";
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return connectionnum1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"famiCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell =  (FamilyTableViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"FamilyTableViewCell" owner:self options:nil] lastObject];
    }
    NSDictionary *temp = [connectionnum1 objectAtIndex:indexPath.row];
    cell.famtitl1.text = [temp valueForKey:@"titlee"];
    [cell.famimg1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[temp valueForKey:@"imagee"]]]];
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"ヒント" message:@"削除しますか" preferredStyle: UIAlertControllerStyleAlert];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *temp = [connectionbtn1 allKeys];
            [connectionbtn1 removeObjectForKey:temp[indexPath.row]];
            [[NSUserDefaults standardUserDefaults]setObject:connectionbtn1 forKey:@"famTitleArrr"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:temp[indexPath.row]];
            [self reloadContactList];
            [self.tableView reloadData];
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"まだ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert2 animated:true completion:nil];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
