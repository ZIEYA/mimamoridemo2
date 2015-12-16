//
//  SettingTableViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/16.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"gotoProfileVC" sender:self];
    }else if (indexPath.row ==1){
        [self performSegueWithIdentifier:@"gotoListVC" sender:self];
    }else if (indexPath.row ==2){
        [self performSegueWithIdentifier:@"gotoPersonaDataVC" sender:self];
    }else if (indexPath.row == 3){
        [self performSegueWithIdentifier:@"gotoGroupTVC" sender:self];
    }else if (indexPath.row == 4){
        [self performSegueWithIdentifier:@"gotoTaisetsuListTVC" sender:self];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
