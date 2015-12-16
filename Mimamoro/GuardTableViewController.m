//
//  GuardTableViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "GuardTableViewController.h"
#import "GuardTableViewCell.h"
#import "editGuardTableViewController.h"
@interface GuardTableViewController ()
{
    
    NSMutableArray*guardArray;
    NSMutableArray*guardTypeArray;
    NSMutableArray*idArray;
    
    NSMutableDictionary*anybodyData1;
    NSMutableDictionary*guardData1;
    
    int edittype;
    NSString *GuardId;
}
@end

@implementation GuardTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _GuardName;
    
    //guardArray = [[NSArray alloc]initWithObjects:@"1111",@"2222",@"3333", nil];
    //guardTypeArray = [[NSArray alloc]initWithObjects:@"1", @"0",@"1",nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self reloadList];
    [self.tableView reloadData];
    
}
-(void)reloadList{
    [guardArray removeAllObjects];
    [guardTypeArray removeAllObjects];
    guardArray = [[NSMutableArray alloc]init];
    guardTypeArray = [[NSMutableArray alloc]init];
    idArray = [[NSMutableArray alloc]init];
    anybodyData1 = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"anybody"]];
    guardData1 = [[NSMutableDictionary alloc]initWithDictionary:[anybodyData1 objectForKey:_GuardName]];
    NSArray*allkey = [guardData1 allKeys];
    for (int i = 0; i<allkey.count; i++) {
        NSDictionary *tempDict = [guardData1 objectForKey:allkey[i]];
        [guardArray addObject:[tempDict valueForKey:@"toolData"]];
        [guardTypeArray addObject:[tempDict valueForKey:@"type"]];
        [idArray addObject:[tempDict valueForKey:@"id"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return guardArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuardTableViewCell*cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"guardCell" forIndexPath:indexPath];
    
    cell.guardType.tag = indexPath.row;
    cell.guardTitle.text = guardArray[indexPath.row];
    if ([guardTypeArray[indexPath.row] isEqualToString: @"1"]) {
        [cell.guardType setOn:YES];
    }else{
        [cell.guardType setOn:NO];
    }

    
    return cell;
}

- (IBAction)typeBtn:(UISwitch*)sender {

    BOOL setting = sender.isOn;
    
    if (setting == YES) {
        NSMutableDictionary * temp =[[NSMutableDictionary alloc]initWithDictionary:[guardData1 objectForKey:idArray[sender.tag]]];
        
        [temp setValue:@"1" forKey:@"type"];
        [guardData1 setObject:temp forKey:idArray[sender.tag]];
        [anybodyData1 setObject:guardData1 forKey:_GuardName];
        [[NSUserDefaults standardUserDefaults]setObject:anybodyData1 forKey:@"anybody"];
    }else if(setting == NO){
    NSMutableDictionary * temp =[[NSMutableDictionary alloc]initWithDictionary:[guardData1 objectForKey:idArray[sender.tag]]];
        [temp setValue:@"0" forKey:@"type"];
        [guardData1 setObject:temp forKey:idArray[sender.tag]];
        [anybodyData1 setObject:guardData1 forKey:_GuardName];
        [[NSUserDefaults standardUserDefaults]setObject:anybodyData1 forKey:@"anybody"];
    }
    
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *temp = [guardData1 allKeys];
        [guardData1 removeObjectForKey:temp[indexPath.row]];
        [anybodyData1 setObject:guardData1 forKey:_GuardName];
        [[NSUserDefaults standardUserDefaults]setObject:anybodyData1 forKey:@"anybody"];
        [self reloadList];
        [self.tableView reloadData];
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;
    
    GuardId = [idArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"editGuardPush" sender:self];
}
- (IBAction)ediebtn:(id)sender {
    edittype = 0;
    //[self performSegueWithIdentifier:@"editGuardPush" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"editGuardPush"])
    {
        editGuardTableViewController *editGuardTableView = segue.destinationViewController;
        editGuardTableView.anybodyNamee = _GuardName;
            if (edittype == 0) {
                editGuardTableView.edittype = 0;
            }else if (edittype == 1){
                editGuardTableView.edittype = 1;
                editGuardTableView.Guardidd = GuardId;
            }
    }
}
@end
