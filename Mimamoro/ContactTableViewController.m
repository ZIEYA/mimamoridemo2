//
//  ContactTableViewController.m
//  Mimamoro
//
//  Created by totyu3 on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactTableViewController.h"
#import "SeeContactTableViewController.h"
#import "EditContactViewController.h"
#import "AddContViewController.h"

@interface ContactTableViewController ()
@property (strong, nonatomic) NSMutableArray *contactArr;
@property (strong, nonatomic) NSMutableArray *spouse;//配偶
@property (strong, nonatomic) NSMutableArray *son;
@property (strong, nonatomic) NSMutableArray *daughter;
@property (strong, nonatomic) NSMutableArray *others;

@property (strong, nonatomic) NSMutableArray *valueArr;
@end

@implementation ContactTableViewController
@synthesize contactArr,spouse,son,daughter,others;

-(void)viewWillAppear:(BOOL)animated
{
    if (!contactArr) {
        contactArr = [[NSMutableArray alloc]init];
        self.valueArr = [[NSMutableArray alloc]init];
    }
    contactArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"root"];
    self.valueArr =[[NSUserDefaults standardUserDefaults]objectForKey:@"rootName"];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"root"];
//    [user synchronize];
//    //初始化数组
//    spouse = [[NSMutableArray alloc]init];
//    son = [[NSMutableArray alloc]init];
//    
//    self.valueArr = [[NSMutableArray alloc]initWithObjects:@"配偶",@"儿子", nil];
//    //配偶数据
//    NSMutableDictionary *spouse1 = [[NSMutableDictionary alloc]init];
//    [spouse1 setValue:@"张三" forKey:@"name"];
//    [spouse1 setValue:@"3424234324@qq.com" forKey:@"email"];
//    [spouse addObject:spouse1];
//    //儿子数据
//    NSMutableDictionary *son1 = [[NSMutableDictionary alloc]init];
//    [son1 setValue:@"a" forKey:@"name"];
//    [son1 setValue:@"23123" forKey:@"email"];
//    [son addObject:son1];
//    NSMutableDictionary *son2 = [[NSMutableDictionary alloc]init];
//    [son2 setValue:@"b" forKey:@"name"];
//    [son2 setValue:@"sdfsdsf" forKey:@"email"];
//    [son addObject:son2];
//    //女儿数据
//    //其它数据
//    
//    if (!contactArr) {
//        contactArr = [[NSMutableArray alloc]init];
//    }
//    
//    [contactArr addObject:spouse];
//    [contactArr addObject:son];
//    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
//    [userdefult setObject:contactArr forKey:@"root"];
//    [userdefult setObject:self.valueArr forKey:@"rootName"];
//    [userdefult synchronize];
    
    
    UIBarButtonItem *add =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = add;
}
#pragma mark - 增加联系人组
-(void)addAction
{
    AddContViewController *add =[[AddContViewController alloc]init];
    add.valueName = self.valueArr;
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

    return contactArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"contactlist.png"];

    cell.textLabel.text = self.valueArr[indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = contactArr[indexPath.row];
    if (arr.count<=1) {
        EditContactViewController *edit = [[EditContactViewController alloc]init];
        edit.type = 1;
        //edit.editdata = arr;
        edit.indexRow = indexPath.row;
        edit.rootData = contactArr;
        [self.navigationController pushViewController:edit animated:YES];
    }else{
        SeeContactTableViewController *see = [[SeeContactTableViewController alloc]init];
        see.type = 2;
        //see.seedata = arr;
        see.indexRow = indexPath.row;
        see.rootData = contactArr;
        [self.navigationController pushViewController:see animated:YES];
    }
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
