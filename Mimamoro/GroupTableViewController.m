//
//  GroupTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "GroupTableViewController.h"
#import "ContactModel.h"
#import "EditGroupTableViewController.h"

@interface GroupTableViewController (){

    int edittype;//0:新規　1:編集
    
    NSMutableArray *contArr;
    ContactModel *contModel;
    NSDictionary *contDic;
    long index;
}

@end

@implementation GroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (contArr==nil) {
        contArr =[[NSMutableArray alloc]init];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
   // [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"contacts"];
    contModel = [[ContactModel alloc]init];
    contArr = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"contacts"]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//-(void)reloadGroups{
//    for (NSDictionary *tmp in contArr) {
//        contModel.name = [tmp valueForKey:@"name"];
//        contModel.imageName = [tmp valueForKey:@"image"];
//    }
//    
//    
//    [_groupArray removeAllObjects];
//    NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"group"];
//    _groArray = [[NSMutableArray alloc]initWithArray:temp];
//    for (NSDictionary *tmpdict in temp) {
//        GroupModel *model = [[GroupModel alloc]init];
//        model.groupname = [tmpdict valueForKey:@"groupname"];
//        model.groupimage = [tmpdict valueForKey:@"image"];
//        [_groupArray addObject:model];
//        NSLog(@"%@",tmpdict);
//    }
//    //NSLog(@"group array:%@",_groupArray);
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return contArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupcell" forIndexPath:indexPath];
    
    NSDictionary *contant = [contArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [contant valueForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[contant valueForKey:@"img"]]];
    return cell;
}

//編集
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;//編集
    index = indexPath.row;
    contDic = [contArr objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"gotoeditVC" sender:self];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ContactModel *deleteItem = [contArr objectAtIndex:indexPath.row];
        [contArr removeObject:deleteItem];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"contacts"];
        [[NSUserDefaults standardUserDefaults]setObject:contArr forKey:@"contacts"];
        [self.tableView reloadData];
    }
}

//新規
- (IBAction)addAction:(id)sender {
    edittype = 0;
    [self performSegueWithIdentifier:@"gotoeditVC" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditGroupTableViewController *editTVC = segue.destinationViewController;
    editTVC.contdic = contDic;
    editTVC.editType = edittype;
    editTVC.index =index;
}

@end
