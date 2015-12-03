//
//  ContactTableViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactTableViewController.h"
#import "EditContactViewController.h"

@interface ContactTableViewController (){
    NSMutableDictionary *_contactDict;
    NSMutableArray *_familyContactArray;
    NSMutableArray *_otherContactArray;
    int edittype; //0:追加 1:編集
    NSString *tempname;//Deliver a key(name)to edit view controller
    int emergencymark;//0:普通の連絡先　1:緊急時のみの連絡先
}

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _family;
    if (!_familyContactArray) {
        _familyContactArray = [[NSMutableArray alloc]init];
    }
    if (!_otherContactArray) {
        _otherContactArray = [[NSMutableArray alloc]init];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContactList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)reloadContactList{
    [_familyContactArray removeAllObjects];
    [_otherContactArray removeAllObjects];
    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contactlist"];
    _contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
    NSArray *keysArr = [_contactDict allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [_contactDict objectForKey:keysArr[i]];
        NSString *type = [tempDict valueForKey:@"contacttype"];
        NSString *familyname = [tempDict valueForKey:@"familyName"];
        if ([familyname isEqualToString: _family]) {
            if ([type isEqualToString:@"0"]) {
                [_familyContactArray addObject:tempDict];
            }else if ([type isEqualToString:@"1"]){
                [_otherContactArray addObject:tempDict];
            }
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
        count =  _familyContactArray.count ;
    }else if(section == 1){
        count =  _otherContactArray.count ;
    }
    return count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"不安时通知";
    }else if(section ==1){
        return @"紧急时通知";
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"contactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    if(indexPath.section == 0){
        NSDictionary *temp = [_familyContactArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp valueForKey:@"name"];
        cell.detailTextLabel.text = [temp valueForKey:@"email"];
        NSString *tempStr = [temp valueForKey:@"emergencytype"];
        if ([tempStr isEqualToString:@"0"]) {
            cell.imageView.image = [UIImage imageNamed:@"unemergency.png"];
        }else if([tempStr isEqualToString:@"1"]){
            cell.imageView.image = [UIImage imageNamed:@"emergencymark.png"];
        }
    }
    if(indexPath.section == 1){
        NSDictionary *temp = [_otherContactArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp valueForKey:@"name"];
        cell.detailTextLabel.text = [temp valueForKey:@"email"];
        NSString *tempStr = [temp valueForKey:@"emergencytype"];
        if ([tempStr isEqualToString:@"0"]) {
            cell.imageView.image = [UIImage imageNamed:@"unemergency.png"];
        }else if([tempStr isEqualToString:@"1"]){
            cell.imageView.image = [UIImage imageNamed:@"emergencymark.png"];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;
    if (indexPath.section == 0){
        tempname = [[_familyContactArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    }
    if (indexPath.section ==1){
        tempname = [[_otherContactArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    }
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
        [[NSUserDefaults standardUserDefaults]setObject:_contactDict forKey:@"contactlist"];
    }
    [self reloadContactList];
    [self.tableView reloadData];
}

- (IBAction)addContactAction:(id)sender {
    edittype = 0;
    [self performSegueWithIdentifier:@"gotoEditContactVC" sender:self];
}
@end