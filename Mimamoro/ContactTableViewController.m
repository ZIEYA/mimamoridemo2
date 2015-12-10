//
//  ContactTableViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactTableViewController.h"
#import "ContactTableViewCell.h"
#import "EditContactViewController.h"

@interface ContactTableViewController (){
    ContactTableViewCell*cell;
    NSMutableDictionary *_contactDict;
    NSMutableArray *_familyContactArray;
    NSMutableArray *_otherContactArray;
    NSMutableArray *_allContactArray;
    NSDictionary *tempdict;
    int edittype; //0:追加 1:編集
    NSString *tempname;

}

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
  //  [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"famTitleArr"];
    [super viewDidLoad];
    self.navigationItem.title = _family;
    _allContactArray = [[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContactList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)reloadContactList{
    [_allContactArray removeAllObjects];
    tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:_family];
    _contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
    NSArray *keysArr = [_contactDict allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [_contactDict objectForKey:keysArr[i]];
        [_allContactArray addObject:tempDict];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _allContactArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell =  (ContactTableViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"ContactTableViewCell" owner:self options:nil] lastObject];
    }

    NSDictionary *temp = [_allContactArray objectAtIndex:indexPath.row];
    cell.ctvName.text = [temp valueForKey:@"name"];
    cell.ctvEmail.text = [temp valueForKey:@"email"];
    if ([[temp valueForKey:@"emergencytype"] isEqualToString: @"1"]&&[[temp valueForKey:@"contacttype"] isEqualToString: @"1"]) {
        [cell.ctvState setImage:[UIImage imageNamed:@"emerWorr"]];
    }else if([[temp valueForKey:@"contacttype"] isEqualToString: @"1"]&&[[temp valueForKey:@"emergencytype"] isEqualToString: @"0"]){
        [cell.ctvState setImage:[UIImage imageNamed:@"worr"]];
    }else if([[temp valueForKey:@"emergencytype"] isEqualToString: @"1"]&&[[temp valueForKey:@"contacttype"] isEqualToString: @"0"]){
        [cell.ctvState setImage:[UIImage imageNamed:@"emer"]];
    }else{
        [cell.ctvState setImage:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;

    tempname = [[_allContactArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    
    [self performSegueWithIdentifier:@"gotoEditContactVC" sender:self];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditContactViewController *editVC = segue.destinationViewController;
    editVC.familytype = _family;
    if (edittype == 0) {
        editVC.editType = 0;
    }else if (edittype == 1){
        editVC.editType = 1;
        editVC.tempName = tempname;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *temp = [_contactDict allKeys];
        [_contactDict removeObjectForKey:temp[indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:_contactDict forKey:_family];
        [self reloadContactList];
        [self getNotofocation];
        [self.tableView reloadData];
    }
}

- (void)getNotofocation{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Emergency" object:self];
}

- (IBAction)addContactAction:(id)sender {
    edittype = 0;
    [self performSegueWithIdentifier:@"gotoEditContactVC" sender:self];
}
@end