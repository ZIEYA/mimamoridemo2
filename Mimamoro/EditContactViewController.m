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
@synthesize rootData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.18,self.view.bounds.size.width*0.6,40)];
    nameLabel.text = @"氏名:";
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.25,self.view.bounds.size.width*0.8,40)];
    self.nameTextField.backgroundColor = [UIColor redColor];

    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.35,self.view.bounds.size.width*0.6,60)];
    emailLabel.text = @"メールアドレス:";
    
    self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.43,self.view.bounds.size.width*0.8,40)];
    self.emailTextField.backgroundColor = [UIColor redColor];

    UILabel *conLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.59,self.view.bounds.size.width*0.7,40)];
    conLab.text = @"*体調不安時にメール送付の宛先";
    conLab.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    self.contactTypeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.75,self.view.bounds.size.height*0.6,self.view.bounds.size.width*0.2,40)];
    
    [self.contactTypeSwitch addTarget:self action:@selector(contchange:) forControlEvents:UIControlEventValueChanged];
    
    
    UILabel *emeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1,self.view.bounds.size.height*0.69,self.view.bounds.size.width*0.7,40)];
    emeLab.text = @"*緊急時にメール送付の宛先";
    emeLab.font = [UIFont fontWithName:@"Helvetica" size:14];
    self.emergencySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.75,self.view.bounds.size.height*0.7,self.view.bounds.size.width*0.2,40)];
    [self.emergencySwitch addTarget:self action:@selector(emerchange:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:emailLabel];
    [self.view addSubview:emeLab];
    [self.view addSubview:conLab];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.contactTypeSwitch];
    [self.view addSubview:self.emergencySwitch];
    
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    
    //赋值
    self.rootArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"root"];
    if (self.type==1) {
        self.editdata = self.rootArr[self.indexRow];
        self.nameTextField.text = [self.editdata[0] valueForKey:@"name"];
        self.emailTextField.text = [self.editdata[0] valueForKey:@"email"];
    }if (self.type==2) {
        self.editdata = self.rootArr[self.oldIndexRow];
        self.nameTextField.text = [self.editdata[self.indexRow] valueForKey:@"name"];
        self.emailTextField.text = [self.editdata[self.indexRow] valueForKey:@"email"];
    }
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveContact)];
    self.navigationItem.rightBarButtonItem = save;
}
-(void)contchange:(UISwitch *)sender
{
    
}
-(void)emerchange:(UISwitch *)sender
{
    
}

#pragma mark - saveAction
-(void)saveContact
{
    NSString *contactNameStr = self.nameTextField.text;
    NSString *emailStr = self.emailTextField.text;
    NSMutableDictionary *saveData = [[NSMutableDictionary alloc]init];
    [saveData setValue:contactNameStr forKey:@"name"];
    [saveData setValue:emailStr forKey:@"email"];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    [data addObject:saveData];
    NSLog(@"1:%@ 2:%@",self.rootArr,data);
    
    
    if (self.type==1) {
        [rootData replaceObjectAtIndex:self.indexRow withObject:data];
    }if (self.type==2) {
        [rootData[self.oldIndexRow] replaceObjectAtIndex:self.indexRow withObject:saveData];
    }
    NSUserDefaults *userdefult= [NSUserDefaults standardUserDefaults];
    [userdefult removeObjectForKey:@"root"];
    [userdefult setObject:rootData forKey:@"root"];
    [userdefult synchronize];
    NSLog(@"spouseDef:%@",rootData);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 关闭键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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