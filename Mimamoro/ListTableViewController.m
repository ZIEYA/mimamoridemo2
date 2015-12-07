//
//  ListTableViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/23.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ListTableViewController.h"
#import "EditListTableViewController.h"

@interface ListTableViewController (){
    NSMutableDictionary *listContentDict;
    NSMutableArray *minomawariArray;
    NSMutableArray *sonotaArray;
    int edittype ;//0:追加　1:編集
    NSString *tempcotent;//Deliver a key(name)to edit view controller
}

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!minomawariArray) {
        minomawariArray = [[NSMutableArray alloc]init];
    }
    if (!sonotaArray) {
        sonotaArray = [[NSMutableArray alloc]init];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)reloadList{
    [minomawariArray removeAllObjects];
    [sonotaArray removeAllObjects];
    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"listcontent"];
    listContentDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
    NSArray *keysArr = [listContentDict allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [listContentDict objectForKey:keysArr[i]];
        NSString *type = [tempDict valueForKey:@"type"];
        if ([type isEqualToString:@"0"]) {
            [minomawariArray addObject:tempDict];
        }else if ([type isEqualToString:@"1"]){
            [sonotaArray addObject:tempDict];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count  ;
    if (section == 0){
        count =  minomawariArray.count ;
    }else if(section == 1){
        count =  sonotaArray.count ;
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"身の回りのもの";
    }else if(section ==1){
        return @"その他お願い事項";
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    if (indexPath.section == 0) {
        NSDictionary *temp = [minomawariArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp valueForKey:@"content"];
    }
    if (indexPath.section == 1) {
        NSDictionary *temp = [sonotaArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp valueForKey:@"content"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;
    if (indexPath.section == 0){
        tempcotent = [[minomawariArray objectAtIndex:indexPath.row]valueForKey:@"content"];
    }
    if (indexPath.section ==1){
        tempcotent = [[sonotaArray objectAtIndex:indexPath.row]valueForKey:@"content"];
    }
    [self performSegueWithIdentifier:@"gotoEditListVC" sender:self];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [minomawariArray removeObjectAtIndex:indexPath.row];
        }else if (indexPath.section == 1){
            [sonotaArray removeObjectAtIndex:indexPath.row];
        }
        NSMutableDictionary *newListDict = [[NSMutableDictionary alloc]initWithCapacity:0];
        for (NSDictionary *tempdict in minomawariArray) {
            NSString *tmpname = [tempdict valueForKey:@"content"];
            [newListDict setObject:tempdict forKey:tmpname];
        }
        for (NSDictionary *tempdict in sonotaArray) {
            NSString *tmpname = [tempdict valueForKey:@"content"];
            [newListDict setObject:tempdict forKey:tmpname];
        }
        [[NSUserDefaults standardUserDefaults]setObject:newListDict forKey:@"listcontent"];
        
    }
    [self reloadList];
    [self.tableView reloadData];
}

- (IBAction)addListContentAction:(id)sender {
    edittype = 0;
    [self performSegueWithIdentifier:@"gotoEditListVC" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditListTableViewController *editListVC = segue.destinationViewController;
    editListVC.editType = edittype;
    editListVC.tempContent = tempcotent;
}

@end
