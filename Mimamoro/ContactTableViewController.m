//
//  ContactTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactTableViewController.h"
#import "EditContactTableViewController.h"
#import "ContactModel.h"

@interface ContactTableViewController ()<UITextFieldDelegate>{
    int edittype; //0:追加 1:編集
    NSMutableArray *_currentArray;
    NSMutableDictionary *_contactDict;
    NSString *tempname;
}

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_groupid);
    if (!_currentArray) {
        _currentArray = [[NSMutableArray alloc]init];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContact];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadContact{
    [_currentArray removeAllObjects];
    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contact"];
    if (!tempdict) {
        [LeafNotification showInController:self.navigationController withText:@"連絡人を追加してみてください"];
        return;
    }
    _contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
    NSLog(@"contact:%@",tempdict);
    NSArray *keysArr = [tempdict allKeys];
    //Models
//    for (int i = 0; i<keysArr.count; i++) {
//        NSDictionary *dict = [tempdict objectForKey:keysArr[i]];
//        ContactModel *model = [[ContactModel alloc]init];
//        model.name = [dict valueForKey:@"name"];
//        model.email = [dict valueForKey:@"email"];
//        model.groupType = [dict valueForKey:@"group"];
//        if ([_groupid isEqualToString:model.groupType]) {
//            [_currentArray addObject:model];
//        }
//        NSLog(@"%@",model.groupType);

    }
//    NSLog(@"%lu",(unsigned long)_currentArray.count);
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return _currentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"contactCell"];
    }
    
    ContactModel *contactmodel = [_currentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = contactmodel.name;
    cell.detailTextLabel.text = contactmodel.email;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;
    ContactModel *contactmodel = [_currentArray objectAtIndex:indexPath.row];
    tempname = contactmodel.name;
    [self performSegueWithIdentifier:@"gotoEditContactVC" sender:self];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ContactModel *model = [_currentArray objectAtIndex:indexPath.row];
        [_contactDict removeObjectForKey:model.name];
        [[NSUserDefaults standardUserDefaults]setObject:_contactDict forKey:@"contact"];
        
        [self reloadContact];
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}     

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditContactTableViewController *editVC = segue.destinationViewController;
    if (edittype == 0) {
        editVC.editType = 0;
    }else if (edittype == 1){
        editVC.editType = 1;
        editVC.tempName = tempname;
    }
    editVC.gruopname = self.groupid;
};


- (IBAction)addContactAction:(id)sender {
    edittype = 0;
    [self performSegueWithIdentifier:@"gotoEditContactVC" sender:self];
}

@end
