//
//  GroupTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "GroupTableViewController.h"
#import "EditGroupTableViewController.h"

@interface GroupTableViewController (){
    NSMutableArray *_groupArray;//model array
    NSMutableArray *_groArray;
    int edittype;//0:新規　1:編集
    NSString *groupname;
    GroupModel *tmpmodel;
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
    tmpmodel = [[GroupModel alloc]init];
    [self reloadGroups];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)reloadGroups{
    [_groupArray removeAllObjects];
    NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"group"];
    _groArray = [[NSMutableArray alloc]initWithArray:temp];
    for (NSDictionary *tmpdict in temp) {
        GroupModel *model = [[GroupModel alloc]init];
        model.groupname = [tmpdict valueForKey:@"groupname"];
        model.groupimage = [tmpdict valueForKey:@"image"];
        [_groupArray addObject:model];
        NSLog(@"%@",tmpdict);
    }
    //NSLog(@"group array:%@",_groupArray);
    [self.tableView reloadData];
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

//編集
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;//編集
    //groupname = [_groupArray objectAtIndex:indexPath.row];
    tmpmodel = [_groupArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"gotoEditGroupTVC" sender:self];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GroupModel *deleteItem = [_groupArray objectAtIndex:indexPath.row];
        [_groupArray removeObject:deleteItem];
        for (int i=0; i<_groArray.count; i++) {
            NSString *tmpname = [[_groArray objectAtIndex:i]valueForKey:@"groupname"];
            if ([deleteItem.groupname isEqualToString:tmpname]) {
                [_groArray removeObjectAtIndex:i];
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:_groArray forKey:@"group"];
        [self reloadGroups];
        //Delete group's contacts
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contact"];
        if (tempdict) {
            NSMutableDictionary *contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
            for (int i = 0; i<tempdict.allKeys.count; i++) {
                NSString *tmpstr = [tempdict.allKeys objectAtIndex:i];
                NSDictionary *tmp = [tempdict objectForKey:tmpstr];
                NSString *name = [tmp valueForKey:@"name"];
                NSString *tmpgname = [tmp valueForKey:@"group"];
                if ([deleteItem.groupname isEqualToString:tmpgname]) {
                    [contactDict removeObjectForKey:name];
                }
            }
            [[NSUserDefaults standardUserDefaults]setObject:contactDict forKey:@"contact"];
        }

    }
}

//新規
- (IBAction)addAction:(id)sender {
    edittype = 0;
    //groupname = @"";
    [self performSegueWithIdentifier:@"gotoEditGroupTVC" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditGroupTableViewController *editTVC = segue.destinationViewController;
    editTVC.groupmodel = tmpmodel;
    editTVC.editType = edittype;
}

@end
