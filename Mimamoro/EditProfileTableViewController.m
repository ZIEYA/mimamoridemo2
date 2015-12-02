//
//  EditProfileTableViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/20.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditProfileTableViewController.h"
//#import "PickerView.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface EditProfileTableViewController ()<CNContactPickerDelegate,UITextFieldDelegate>{
    UserProfileModel *_userprofilemodel;
    NSMutableDictionary *_userDefaultDict;
}
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sexTextField;
@property (strong, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *hospitalTextField;
@property (strong, nonatomic) IBOutlet UITextField *doctorTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *hostnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *severportTextField;

@end

@implementation EditProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userprofilemodel = [[UserProfileModel alloc]init];
    _userDefaultDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
    _nameTextField.text = [temp valueForKey:@"name"];
    _sexTextField.text = [temp valueForKey:@"sex"];
    _birthdayTextField.text = [temp valueForKey:@"birthday"];
    _addressTextField.text = [temp valueForKey:@"address"];
    _emailTextField.text = [temp valueForKey:@"email"];
    _hospitalTextField.text = [temp valueForKey:@"hospital"];
    _doctorTextField.text = [temp valueForKey:@"doctor"];
    _passwordTextField.text = [temp valueForKey:@"password"];
    _hostnameTextField.text = [temp valueForKey:@"hostname"];
    _severportTextField.text = [temp valueForKey:@"severport"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveAction:(id)sender {
    //Save data as userprofile model
    _userprofilemodel.name = _nameTextField.text;
    _userprofilemodel.sex = _sexTextField.text;
    _userprofilemodel.birthday = _birthdayTextField.text;
    _userprofilemodel.address = _addressTextField.text;
    _userprofilemodel.email = _emailTextField.text;
    _userprofilemodel.hospital=_hospitalTextField.text;
    _userprofilemodel.doctor = _doctorTextField.text;
    _userprofilemodel.password = _passwordTextField.text;
    _userprofilemodel.hostname = _hostnameTextField.text;
    _userprofilemodel.severport = _severportTextField.text;
    
    //Sava data as user default
    [_userDefaultDict setValue:_nameTextField.text forKey:@"name"];
    [_userDefaultDict setValue:_sexTextField.text forKey:@"sex"];
    [_userDefaultDict setValue:_birthdayTextField.text forKey:@"birthday"];
    [_userDefaultDict setValue:_addressTextField.text forKey:@"address"];
    [_userDefaultDict setValue:_emailTextField.text forKey:@"email"];
    [_userDefaultDict setValue:_hospitalTextField.text forKey:@"hospital"];
    [_userDefaultDict setValue:_doctorTextField.text forKey:@"doctor"];
    [_userDefaultDict setValue:_passwordTextField.text forKey:@"password"];
    [_userDefaultDict setValue:_hostnameTextField.text forKey:@"hostname"];
    [_userDefaultDict setValue:_severportTextField.text forKey:@"severport"];
    [[NSUserDefaults standardUserDefaults]setObject:_userDefaultDict forKey:@"userprofile"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)addFromIphpne:(id)sender {
    CNContactStore *cstore = [[CNContactStore alloc]init];
    
    [cstore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"Granted Permission");
        }else{
            NSLog(@"Denied Permission");
        }
        if (error) {
            NSLog(@"Error");
        }
    }];
    
    CNContactPickerViewController *cvc = [[CNContactPickerViewController alloc]init];
    cvc.displayedPropertyKeys = @[CNContactPhoneNumbersKey,CNContactEmailAddressesKey];
    [cvc setDelegate:self];
    [self presentViewController:cvc animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    _nameTextField.text =[NSString stringWithFormat:@"%@ %@",contact.familyName,contact.givenName];
    _birthdayTextField.text = [NSString stringWithFormat:@"%ld/%ld/%ld",contact.birthday.year,contact.birthday.month,contact.birthday.day];
    _addressTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[contact.postalAddresses firstObject].value.state,[contact.postalAddresses firstObject].value.city,[contact.postalAddresses firstObject].value.street];
    _emailTextField.text = [NSString stringWithFormat:@"%@",[contact.emailAddresses firstObject].value];
    NSLog(@"name:%@,birthday:%@,address:%@,email:%@",_userprofilemodel.name,_userprofilemodel.birthday,_userprofilemodel.address,_userprofilemodel.email);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}



@end
