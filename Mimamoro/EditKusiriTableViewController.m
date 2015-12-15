//
//  EditKusiriTableViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/23.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditKusiriTableViewController.h"
#import "KusuriModel.h"
#import "LeafNotification.h"
@interface EditKusiriTableViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    KusuriModel *kusurimodel;
    NSMutableDictionary *kusuriDict;
    NSMutableDictionary *exitDict;
}
@property (strong, nonatomic) IBOutlet UITextField *pillnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) IBOutlet UITextField *pharmacyTextField;
@property (strong, nonatomic) IBOutlet UITextView *directionsTextView;
@property (strong, nonatomic) IBOutlet UITextView *sideeffectTextView;
@property (strong, nonatomic) IBOutlet UITextView *allergyTextView;
@property (strong, nonatomic) IBOutlet UITextView *previousillnessTextView;
@end

@implementation EditKusiriTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kusurimodel = [[KusuriModel alloc]init];
    if (!kusuriDict) {
        kusuriDict = [[NSMutableDictionary alloc]init];
    }
    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"kusurilist"];
    kusuriDict = [[NSMutableDictionary alloc]initWithDictionary:temp];
    if (_editType == 0) {
        
    }else if (_editType == 1){
        exitDict = [kusuriDict objectForKey:_tempPillname];
        _pillnameTextField.text = [exitDict valueForKey:@"pillname"];
        _dateTextField.text = [exitDict valueForKey:@"date"];
        _pharmacyTextField.text = [exitDict valueForKey:@"pharmacy"];
        _directionsTextView.text = [exitDict valueForKey:@"directions"];
        _sideeffectTextView.text = [exitDict valueForKey:@"sideeffect"];
        _allergyTextView.text = [exitDict valueForKey:@"allergy"];
        _previousillnessTextView.text =[exitDict valueForKey:@"previousillness"];
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
        [kusuriDict removeObjectForKey:_tempPillname];
    }
    if ([_pillnameTextField.text isEqualToString:@""]){
     [LeafNotification showInController:self withText:[NSString stringWithFormat:@"どうぞ足を付ける薬剤名"]];   
    }else{
    kusurimodel.pillname = _pillnameTextField.text;
    kusurimodel.date = _dateTextField.text;
    kusurimodel.pharmacy = _pharmacyTextField.text;
    kusurimodel.directions = _directionsTextView.text;
    kusurimodel.sideeffect = _sideeffectTextView.text;
    kusurimodel.allergy = _allergyTextView.text;
    kusurimodel.previousillness = _previousillnessTextView.text;
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    [temp setValue:kusurimodel.pillname forKey:@"pillname"];
    [temp setValue:kusurimodel.date forKey:@"date"];
    [temp setValue:kusurimodel.pharmacy forKey:@"pharmacy"];
    [temp setValue:kusurimodel.directions forKey:@"directions"];
    [temp setValue:kusurimodel.sideeffect forKey:@"sideeffect"];
    [temp setValue:kusurimodel.allergy forKey:@"allergy"];
    [temp setValue:kusurimodel.previousillness forKey:@"previousillness"];
    
    [kusuriDict setObject:temp forKey:kusurimodel.pillname];
    [[NSUserDefaults standardUserDefaults]setObject:kusuriDict forKey:@"kusurilist"];
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
