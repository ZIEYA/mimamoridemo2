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
    NSArray* sex;
    NSString *birthdayText;
    NSString *sexText;
}
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *sexPickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayDatePicker;



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
    
    sex = [NSArray arrayWithObjects:@"男",@"女",nil];
    
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userprofile"];
    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
    _nameTextField.text = [temp valueForKey:@"name"];
    sexText = [temp valueForKey:@"sex"];
    birthdayText = [temp valueForKey:@"birthday"];
    _addressTextField.text = [temp valueForKey:@"address"];
    _emailTextField.text = [temp valueForKey:@"email"];
    _hospitalTextField.text = [temp valueForKey:@"hospital"];
    _doctorTextField.text = [temp valueForKey:@"doctor"];
    _passwordTextField.text = [temp valueForKey:@"password"];
    _hostnameTextField.text = [temp valueForKey:@"hostname"];
    _severportTextField.text = [temp valueForKey:@"severport"];
 
    
    
    
    if (sexText == nil) {
        sexText = @"男";
    }else{
        NSUInteger i = [sex indexOfObject:sexText];
        [self.sexPickerView selectRow:i inComponent:0 animated:NO];
    }
    
    if (birthdayText == nil) {
        NSTimeZone *zone = [NSTimeZone defaultTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
        NSDate *nowDate=[NSDate dateWithTimeIntervalSinceNow:interval];
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日"];
        birthdayText = [pickerFormatter stringFromDate:nowDate];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [dateFormatter dateFromString:birthdayText];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.birthdayDatePicker.locale = locale;
    // 设置当前显示时间
    [self.birthdayDatePicker setDate:date animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [self.birthdayDatePicker setMaximumDate:[NSDate date]];
    // 设置UIDatePicker的显示模式
    [self.birthdayDatePicker setDatePickerMode:UIDatePickerModeDate];
    // 当值发生改变的时候调用的方法
    [self.birthdayDatePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        

}
-(void)dateChanged:(id)sender{
    NSDate *pickerDate = [self.birthdayDatePicker date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    [pickerFormatter setDateFormat:@"yyyy年MM月dd日"];
    birthdayText = [pickerFormatter stringFromDate:pickerDate];
    NSLog(@"%@",birthdayText);

}




//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//行数
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return sex.count;
}
//行的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return  self.sexPickerView.frame.size.height;
}
//行的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.sexPickerView.frame.size.width;
}
//每行显示
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view) {
        view=[[UIView alloc]init];
    }
    UILabel *text=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.sexPickerView.frame.size.width, self.sexPickerView.frame.size.height)];
    text.textColor = [UIColor blackColor];
    text.textAlignment = NSTextAlignmentLeft;
    text.font = [UIFont fontWithName:@"Arial" size:20.0f];
    text.text = [sex objectAtIndex:row];
    [view addSubview:text];
    return view;
}
//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    sexText = [sex objectAtIndex:row];
    NSLog(@"pickerView选中%@",[sex objectAtIndex:row]);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveAction:(id)sender {
    //Save data as userprofile model
    _userprofilemodel.name = _nameTextField.text;
    _userprofilemodel.sex = sexText;
    _userprofilemodel.birthday = birthdayText;
    _userprofilemodel.address = _addressTextField.text;
    _userprofilemodel.email = _emailTextField.text;
    _userprofilemodel.hospital=_hospitalTextField.text;
    _userprofilemodel.doctor = _doctorTextField.text;
    _userprofilemodel.password = _passwordTextField.text;
    _userprofilemodel.hostname = _hostnameTextField.text;
    _userprofilemodel.severport = _severportTextField.text;

    //Sava data as user default
    [_userDefaultDict setValue:_nameTextField.text forKey:@"name"];
    [_userDefaultDict setValue:sexText forKey:@"sex"];
    [_userDefaultDict setValue:birthdayText forKey:@"birthday"];
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
    birthdayText = [NSString stringWithFormat:@"%ld年%ld月%ld日",contact.birthday.year,contact.birthday.month,contact.birthday.day];
    _addressTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[contact.postalAddresses firstObject].value.state,[contact.postalAddresses firstObject].value.city,[contact.postalAddresses firstObject].value.street];
    _emailTextField.text = [NSString stringWithFormat:@"%@",[contact.emailAddresses firstObject].value];
    NSLog(@"name:%@,birthday:%@,address:%@,email:%@",_userprofilemodel.name,_userprofilemodel.birthday,_userprofilemodel.address,_userprofilemodel.email);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}



@end
