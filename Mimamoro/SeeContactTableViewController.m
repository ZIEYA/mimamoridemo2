//
//  SeeContactTableViewController.m
//  Mimamoro
//
//  Created by totyu3 on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "SeeContactTableViewController.h"
#import "EditContactViewController.h"
#import "AddContactViewController.h"
@interface SeeContactTableViewController ()

@end

@implementation SeeContactTableViewController

//-(void)viewDidAppear:(BOOL)animated
//{
//    [self.tableView reloadData];
//}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    self.rootArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"root"];
    self.seedata = self.rootArr[self.indexRow];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddContact)];
    self.navigationItem.rightBarButtonItem = add;
    
}
-(void)AddContact
{
    AddContactViewController *add = [[AddContactViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  
    return self.seedata.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    NSDictionary *nameDic = (self.rootArr[self.indexRow])[indexPath.row];
    NSString *nameStr = [nameDic valueForKey:@"name"];
    cell.textLabel.text = nameStr;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditContactViewController *edit = [[EditContactViewController alloc]init];
    
    edit.type =2;
    edit.oldIndexRow = self.indexRow;
    edit.indexRow = indexPath.row;
    edit.rootData = self.rootData;
    [self.navigationController pushViewController:edit animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
