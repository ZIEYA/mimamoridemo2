//
//  EditContactViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditContactViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "contactAddressModel.h"
#import "LeafNotification.h"
@interface EditContactViewController ()<UITextFieldDelegate,CNContactPickerDelegate>{
    contactAddressModel *contactModel;
    NSMutableDictionary *_contactDict;
    NSMutableDictionary *_exitDict;
}
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UISwitch *contactTypeSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *emergencySwitch;
@property (weak, nonatomic) IBOutlet UIButton *lanlaku;
@property (weak, nonatomic) IBOutlet UIButton *baoc;


@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"_jiarentype%@",_familytype);
    _nameTextField.delegate = self;
    _emailTextField.delegate = self;
    _baoc.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _baoc.layer.borderWidth = 3;
    contactModel = [[contactAddressModel alloc]init];
    //contactModel.familyName = _familytype;
    _exitDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    if (!_contactDict) {
        _contactDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    _contactDict = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:_familytype]];
    
    // If add a new contact
    if (_editType == 0) {
        contactModel.contactType = @"0";
        [_contactTypeSwitch setOn:NO];
        contactModel.emergencyType = @"0";
        [_emergencySwitch setOn:NO];
        
        // If edit an existed contact
    }else if (_editType == 1){
        _exitDict = [_contactDict objectForKey:_tempName];
        
        _nameTextField.text = _tempName;
        contactModel.name = _tempName;
        _emailTextField.text = [_exitDict valueForKey:@"email"];
        
        contactModel.contactType = [_exitDict valueForKey:@"contacttype"];
        //是否不安
        if ([contactModel.contactType isEqualToString:@"0"]) {
            [_contactTypeSwitch setOn:NO];
        }else if([contactModel.contactType isEqualToString:@"1"]){
            [_contactTypeSwitch setOn:YES];
        }
        //是否警急
        contactModel.emergencyType = [_exitDict valueForKey:@"emergencytype"];
        if ([contactModel.emergencyType isEqualToString:@"0"]) {
            [_emergencySwitch setOn:NO];
        }else if([contactModel.emergencyType isEqualToString:@"1"]){
            [_emergencySwitch setOn:YES];
        }
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Whether emergency contact or not
- (IBAction)valueChanged:(id)sender {
    BOOL setting = _emergencySwitch.isOn;
    if (setting == YES) {
        contactModel.emergencyType = [NSString stringWithFormat:@"%d",1];
    }else if(setting == NO){
        contactModel.emergencyType = [NSString stringWithFormat:@"%d",0];
    }
}

//Whether family contact or not
- (IBAction)contantTypeChanged:(id)sender {
    BOOL setting = _contactTypeSwitch.isOn;
    if (setting == YES) {
        contactModel.contactType = [NSString stringWithFormat:@"%d",1];
    }else if(setting == NO){
        contactModel.contactType = [NSString stringWithFormat:@"%d",0];
    }
}


- (IBAction)saveAction:(id)sender {
    contactModel.name =_nameTextField.text;
    contactModel.emailaddress = _emailTextField.text;
    NSArray *famtitl = [[NSArray alloc]init];
    NSMutableArray*EmergencyEmailArray = [[NSMutableArray alloc]init];
    NSMutableDictionary*EmergencyDict = [[NSMutableDictionary alloc]init];
    if (_editType == 0) {
        NSLog(@"222;");
    }else if (_editType == 1){
        [_contactDict removeObjectForKey:_tempName];
    }
    if ([_nameTextField.text isEqualToString:@""]||[_emailTextField.text isEqualToString:@""] ) {
        [LeafNotification showInController:self withText:[NSString stringWithFormat:@"保存しないので、足を付ける名前とメールアドレス"]];
    }else{
        if (_editType == 0){
            NSDictionary* famtitl2 = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
            famtitl = [famtitl2 allKeys];
            for (int i = 0; i<famtitl.count; i++) {
                NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:famtitl[i]];
                EmergencyDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
                NSArray *keysArr = [EmergencyDict allKeys];
                for (int i = 0; i<keysArr.count; i++){
                    NSDictionary *tempDict = [EmergencyDict objectForKey:keysArr[i]];
                    NSLog(@"%@",tempDict);
                    NSString *type = [tempDict valueForKey:@"emergencytype"];
                    if ([type isEqualToString:@"1"]) {
                        [EmergencyEmailArray addObject:[tempDict valueForKey:@"email"]];
                    }
                }
            }
            if([EmergencyEmailArray indexOfObject: contactModel.emailaddress] != NSNotFound){
                [LeafNotification showInController:self withText:[NSString stringWithFormat:@"メールアドレス存在していた"]];
            }else{
                NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                [temp setValue:contactModel.name forKey:@"name"];
                [temp setValue:contactModel.emailaddress forKey:@"email"];
                [temp setValue:contactModel.emergencyType forKey:@"emergencytype"];
                [temp setValue:contactModel.contactType forKey:@"contacttype"];
                [_contactDict setObject:temp forKey:contactModel.name];
                [self.navigationController popViewControllerAnimated:YES];
                [[NSUserDefaults standardUserDefaults]setObject:_contactDict forKey:_familytype];
            }
        }else if (_editType == 1){
            NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
            [temp setValue:contactModel.name forKey:@"name"];
            [temp setValue:contactModel.emailaddress forKey:@"email"];
            [temp setValue:contactModel.emergencyType forKey:@"emergencytype"];
            [temp setValue:contactModel.contactType forKey:@"contacttype"];
            [_contactDict setObject:temp forKey:contactModel.name];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults]setObject:_contactDict forKey:_familytype];
        }
    }

    //Save data as model
        //Save data as model
    //    contactModel.name =_nameTextField.text;
    //    contactModel.emailaddress = _emailTextField.text;
    //    if (_editType == 0 && ![contactModel.name isEqualToString:@""]) {
    //        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    //        [temp setValue:contactModel.name forKey:@"name"];
    //        [temp setValue:contactModel.emailaddress forKey:@"email"];
    //        [temp setValue:contactModel.emergencyType forKey:@"emergencytype"];
    //        [temp setValue:contactModel.contactType forKey:@"contacttype"];
    //        [_contactDict setObject:temp forKey:contactModel.name];
    //        [[NSUserDefaults standardUserDefaults]setObject:_contactDict forKey:_familytype];
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }else if (_editType == 1 && ![contactModel.name isEqualToString:@""]){
    //        [_contactDict removeObjectForKey:_tempName];
    //        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    //        [temp setValue:contactModel.name forKey:@"name"];
    //        [temp setValue:contactModel.emailaddress forKey:@"email"];
    //        [temp setValue:contactModel.emergencyType forKey:@"emergencytype"];
    //        [temp setValue:contactModel.contactType forKey:@"contacttype"];
    //        [_contactDict setObject:temp forKey:contactModel.name];
    //        [self.navigationController popViewControllerAnimated:YES];
    //        [[NSUserDefaults standardUserDefaults]setObject:_contactDict forKey:_familytype];
    //    }else{
    //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"message" message:@"请输入姓名" preferredStyle:UIAlertControllerStyleAlert];
    //        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //        }]];
    //        [self presentViewController:alert animated:true completion:nil];
    //    }
    
    
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)open_Contacts:(id)sender {
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

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    NSString *name = contactProperty.contact.familyName;
    contactModel.name = name;
    _nameTextField.text = name;
    
    NSString *email = contactProperty.value;
    NSString*selectName= contactProperty.key;
    if ([selectName isEqualToString:@"emailAddresses"]) {
        contactModel.emailaddress = email;
        _emailTextField.text = email;
    }else{
        _emailTextField.text = @"";
    }
    
    // NSLog(@"name:%@ email:%@",name,email);
}


@end
