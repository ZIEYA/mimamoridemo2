//
//  ContactTableViewController.m
//  Mimamoro
//
//  Created by totyu3 on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactTableViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"


@interface ContactTableViewController ()
@property (strong, nonatomic) NSMutableArray *rootArr;
@property (strong, nonatomic) NSMutableArray *addData;
@end

@implementation ContactTableViewController
@synthesize rootArr;

-(void)viewWillAppear:(BOOL)animated
{
   // [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"root"];
   // rootArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"root"];
    NSArray *viewArr = [[NSUserDefaults standardUserDefaults]valueForKey:@"root"];
    if (viewArr.count==0) {
        rootArr = [[NSMutableArray alloc]init];
    }else{
        rootArr = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"root"]];
        [self.tableView reloadData];
    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
    UIBarButtonItem *add =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = add;
}
#pragma mark - 增加联系人组
-(void)addAction
{
    AddViewController *add = [[AddViewController alloc]init];
    
   // add.rootArr = rootArr;
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
   
    NSArray *number = [[NSUserDefaults standardUserDefaults]objectForKey:@"root"];
    return number.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"contactlist.png"];
    
    NSArray *root = [[NSUserDefaults standardUserDefaults]valueForKey:@"root"];
    NSArray *nameA = root[indexPath.row];
    cell.textLabel.text = [nameA valueForKey:@"name"];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EditViewController *edit = [[EditViewController alloc]init];
    edit.indexRow = indexPath.row;
    edit.viewDic = rootArr[indexPath.row];
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
