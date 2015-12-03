//
//  AddGroupTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "AddGroupTableViewController.h"

@interface AddGroupTableViewController (){
    NSString *groupname;
}
@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;

@end

@implementation AddGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)savaAction:(id)sender {
    groupname = _groupNameTextField.text;
}


@end
