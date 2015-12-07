//
//  AddContViewController.m
//  Mimamoro
//
//  Created by totyu3 on 15/12/7.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "AddContViewController.h"

@interface AddContViewController ()
@property(strong, nonatomic) UITextField *group;
@end

@implementation AddContViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    UILabel *groupName = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1, self.view.bounds.size.height*0.2, self.view.bounds.size.width*0.6, self.view.bounds.size.width*0.2)];
    groupName.font =[UIFont fontWithName:@"Helvetica" size:18];
    groupName.text = @"联系人组名：";
    groupName.backgroundColor = [UIColor redColor];
    
    
     self.group = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1, self.view.bounds.size.height*0.35, self.view.bounds.size.width*0.7, self.view.bounds.size.width*0.2)];
    self.group.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:_group];
    [self.view addSubview:groupName];
    
    //button
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveContact)];
    self.navigationItem.rightBarButtonItem = save;
    
    
}
-(void)saveContact
{
    NSString *rootNameStr = self.group.text;
    [self.valueName addObject:rootNameStr];
    NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
    [userDefult setObject:self.valueName forKey:@"rootName"];
    [userDefult synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
