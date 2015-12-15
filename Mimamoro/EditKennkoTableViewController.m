//
//  EditKennkoTableViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/23.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditKennkoTableViewController.h"
#import "KennkoModel.h"
#import "LeafNotification.h"
@interface EditKennkoTableViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    KennkoModel *kennkomodel;
    NSMutableDictionary *kennkoDict;
    NSMutableDictionary *exitDict;
}
@property (strong, nonatomic) IBOutlet UITextField *checkdateTextField;
@property (strong, nonatomic) IBOutlet UITextField *clinicnameTextField;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;
@property (strong, nonatomic) IBOutlet UITextView *bloodTextView;
@property (strong, nonatomic) IBOutlet UITextView *liverfunctionTextView;
@property (strong, nonatomic) IBOutlet UITextView *lipidTextView;
@property (strong, nonatomic) IBOutlet UITextView *kidneyTextView;
@property (strong, nonatomic) IBOutlet UITextView *bloodsugarTextView;

@end

@implementation EditKennkoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kennkomodel = [[KennkoModel alloc]init];
    if (!kennkoDict) {
        kennkoDict = [[NSMutableDictionary alloc]init];
    }
    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"kennkolist"];
    kennkoDict = [[NSMutableDictionary alloc]initWithDictionary:temp];
    if (_editType == 0) {
        
    }else if (_editType == 1){
        exitDict = [kennkoDict objectForKey:_tempkey];
        _checkdateTextField.text = [exitDict valueForKey:@"checkdate"];
        _clinicnameTextField.text = [exitDict valueForKey:@"clinicname"];
        _resultTextView.text = [exitDict valueForKey:@"result"];
        _bloodTextView.text = [exitDict valueForKey:@"blood"];
        _liverfunctionTextView.text = [exitDict valueForKey:@"liverfunction"];
        _lipidTextView.text = [exitDict valueForKey:@"lipid"];
        _kidneyTextView.text =[exitDict valueForKey:@"kidney"];
        _bloodsugarTextView.text = [exitDict valueForKey:@"bloodsugar"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return  YES;
}

- (IBAction)saveAction:(id)sender {
    if (_editType == 0) {
        
    }else if (_editType == 1){
        [kennkoDict removeObjectForKey:_tempkey];
    }
    if ([_checkdateTextField.text isEqualToString:@""]){
     [LeafNotification showInController:self withText:[NSString stringWithFormat:@"どうぞ足を付ける検査日"]];   
    }else{
    kennkomodel.checkdate = _checkdateTextField.text;
    kennkomodel.clinicname = _clinicnameTextField.text;
    kennkomodel.result = _resultTextView.text;
    kennkomodel.blood = _bloodTextView.text;
    kennkomodel.liverfunction = _liverfunctionTextView.text;
    kennkomodel.lipid = _lipidTextView.text;
    kennkomodel.kidney = _kidneyTextView.text;
    kennkomodel.bloodsugar = _bloodsugarTextView.text;
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    [temp setValue:kennkomodel.checkdate forKey:@"checkdate"];
    [temp setValue:kennkomodel.clinicname forKey:@"clinicname"];
    [temp setValue:kennkomodel.result forKey:@"result"];
    [temp setValue:kennkomodel.blood forKey:@"blood"];
    [temp setValue:kennkomodel.liverfunction forKey:@"liverfunction"];
    [temp setValue:kennkomodel.lipid forKey:@"lipid"];
    [temp setValue:kennkomodel.kidney forKey:@"kidney"];
    [temp setValue:kennkomodel.bloodsugar forKey:@"bloodsugar"];
    [kennkoDict setObject:temp forKey:kennkomodel.checkdate];
    [[NSUserDefaults standardUserDefaults]setObject:kennkoDict forKey:@"kennkolist"];
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
