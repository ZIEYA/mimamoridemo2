//
//  GroupTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "GroupTableViewController.h"
#import "EditGroupTableViewController.h"
#import "GroupModel.h"

@interface GroupTableViewController (){
    NSMutableArray *_groupArray;
    int edittype;//0:新規　1:編集
    NSString *groupname;
}

@end

@implementation GroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_groupArray) {
        _groupArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadGroups];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    NSLog(@"group array:%@",_groupArray);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _groupArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupcell" forIndexPath:indexPath];
    GroupModel *model = [_groupArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.groupname;
    cell.imageView.image = [UIImage imageNamed:model.groupimage];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;//編集
    groupname = [_groupArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"gotoEditGroupTVC" sender:self];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditGroupTableViewController *editTVC = segue.destinationViewController;
    editTVC.tempname = groupname;
}

@end
