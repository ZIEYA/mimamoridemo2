//
//  EditContactViewController.m
//  Mimamoro
//
//  Created by totyu3 on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditContactViewController.h"

@interface EditContactViewController ()
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UISwitch *contactTypeSwitch;
@property (strong, nonatomic) UISwitch *emergencySwitch;
@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.1,20,20)];
    nameLabel.text = @"氏名";
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.12,self.view.bounds.size.width*0.6,40)];
    //self.nameTextField.text = [self.editdata valueForKey:@"name"];
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.2,20,20)];
    emailLabel.text = @"メールアドレス";
    
    self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.22,self.view.bounds.size.width*0.6,40)];
    //self.emailTextField.text = [self.editdata valueForKey:@"email"];
    
    self.contactTypeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(5, 5, 5, 5)];
    [self.contactTypeSwitch addTarget:self action:@selector(contchange:) forControlEvents:UIControlEventValueChanged];
    
    self.emergencySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(6, 6, 6, 6)];
    [self.emergencySwitch addTarget:self action:@selector(emerchange:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:emailLabel];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.contactTypeSwitch];
    [self.view addSubview:self.emergencySwitch];
}
-(void)contchange:(UISwitch *)sender
{
    
}
-(void)emerchange:(UISwitch *)sender
{
    
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
