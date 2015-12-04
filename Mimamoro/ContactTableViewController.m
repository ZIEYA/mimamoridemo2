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

@interface ContactTableViewController ()
@property (strong, nonatomic) NSMutableArray *contactArr;
@property (strong, nonatomic) NSMutableArray *spouse;//配偶
@property (strong, nonatomic) NSMutableArray *son;
@property (strong, nonatomic) NSMutableArray *daughter;
@property (strong, nonatomic) NSMutableArray *others;

@property (strong, nonatomic) NSArray *valueArr;
@end

@implementation ContactTableViewController
@synthesize contactArr,spouse,son,daughter,others;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    //初始化数组
    spouse = [[NSMutableArray alloc]init];
    son = [[NSMutableArray alloc]init];
    daughter =[[NSMutableArray alloc]init];
    others = [[NSMutableArray alloc]init];
    
    self.valueArr = @[@"配偶",@"儿子"];
    //配偶数据
    NSMutableDictionary *spouse1 = [[NSMutableDictionary alloc]init];
    [spouse1 setObject:@"张三" forKey:@"name"];
    [spouse1 setObject:@"3424234324@qq.com" forKey:@"email"];
    [spouse addObject:spouse1];
    //儿子数据
    NSMutableDictionary *son1 = [[NSMutableDictionary alloc]init];
    [son1 setObject:@"a" forKey:@"name"];
    [son1 setObject:@"23123" forKey:@"email"];
    [son addObject:son1];
    NSMutableDictionary *son2 = [[NSMutableDictionary alloc]init];
    [son2 setObject:@"b" forKey:@"name"];
    [son2 setObject:@"sdfsdsf" forKey:@"email"];
    [son addObject:son2];
    //女儿数据
    //其它数据
    
    
    
    
    contactArr= [[NSMutableArray alloc]initWithObjects:spouse,son, nil];
   // NSLog(@"is:%@",contactArr);
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
    NSArray * arr = contactArr[indexPath.row];
    if (arr.count<=1) {
        EditContactViewController *edit = [[EditContactViewController alloc]init];
        edit.editdata = arr;
        [self.navigationController pushViewController:edit animated:YES];
    }else{
        SeeContactTableViewController *see = [[SeeContactTableViewController alloc]init];
        see.seedata = arr;
        [self.navigationController pushViewController:see animated:YES];
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

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
