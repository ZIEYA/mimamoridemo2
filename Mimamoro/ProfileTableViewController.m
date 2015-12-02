//
//  ProfileTableViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/19.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "UserProfileModel.h"

@interface ProfileTableViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailTextField;
@property (strong, nonatomic) IBOutlet UILabel *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (strong, nonatomic) IBOutlet UILabel *doctorLabel;
@property(strong, nonatomic) NSMutableDictionary *userdefaultdict;

@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    
//    UserProfileModel *temp=[[NSUserDefaults standardUserDefaults]objectForKey:@"userprofilemodel"];
//    _nameLabel.text = temp.name;
    
    if (!_userdefaultdict) {
        _userdefaultdict = [[NSMutableDictionary alloc]init];
    }
    _userdefaultdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
    _nameLabel.text = [_userdefaultdict valueForKey:@"name"];
    _sexLabel.text=[_userdefaultdict valueForKey:@"sex"];
    _birthdayLabel.text=[_userdefaultdict valueForKey:@"birthday"];
    _addressLabel.text=[_userdefaultdict valueForKey:@"address"];
    _emailTextField.text = [_userdefaultdict valueForKey:@"email"];
    _hospitalLabel.text=[_userdefaultdict valueForKey:@"hospital"];
    _doctorLabel.text = [_userdefaultdict valueForKey:@"doctor"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
