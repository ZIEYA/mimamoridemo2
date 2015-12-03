//
//  EditContactTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditContactTableViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "ContactModel.h"

@interface EditContactTableViewController ()<UITextFieldDelegate,CNContactPickerDelegate>{
    ContactModel *contactModel;
    NSMutableDictionary *_cotactDict;
    NSMutableDictionary *_exitDict;
}
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emaiTextField;
@property (strong, nonatomic) IBOutlet UISwitch *worrySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *emergencySwitch;

@end

@implementation EditContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    contactModel = [[ContactModel alloc]init];
    contactModel.groupType = self.gruopname;
    if (!_cotactDict) {
        _cotactDict = [[NSMutableDictionary alloc]init];
    }
    _cotactDict = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"contact"]];
    
    if(_editType == 0){
        contactModel.worryType = [NSString stringWithFormat:@"0"];
        contactModel.emergencyType = [NSString stringWithFormat:@"0"];
        [_worrySwitch setOn:NO];
        [_emergencySwitch setOn:NO];
    }else if (_editType == 1){
        _exitDict = [_cotactDict objectForKey:_tempName];
        _nameTextField.text = _tempName;
        contactModel.name = _tempName;
        _emaiTextField.text = [_exitDict valueForKey:@"email"];
        contactModel.email = [_exitDict valueForKey:@"email"];
        contactModel.worryType = [_exitDict valueForKey:@"worrytype"];
        contactModel.emergencyType = [_exitDict valueForKey:@"emergencytype"];
        if ([contactModel.worryType isEqualToString:@"1"]) {
            [_worrySwitch setOn:YES];
        }else{
            [_worrySwitch setOn:NO];
        }
        if ([contactModel.emergencyType isEqualToString:@"1"]) {
            [_emergencySwitch setOn:YES];
        }else{
            [_emergencySwitch setOn:NO];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)saveAction:(id)sender {
    if (_editType == 0) {
        
    }
    else if (_editType == 1){
        [_cotactDict removeObjectForKey:_tempName];
    }
    contactModel.name = _nameTextField.text;
    contactModel.email = _emaiTextField.text;
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    [temp setValue:contactModel.name forKey:@"name"];
    [temp setValue:contactModel.email forKey:@"email"];
    [temp setValue:contactModel.worryType forKey:@"worrytype"];
    [temp setValue:contactModel.emergencyType forKey:@"emergencytype"];
    [temp setValue:contactModel.groupType forKey:@"group"];
    
    [_cotactDict setObject:temp forKey:contactModel.name];
    [[NSUserDefaults standardUserDefaults]setObject:_cotactDict forKey:@"contact"];
    
    [self.navigationController popViewControllerAnimated:YES];
}


//Open contact list in iphone
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
    NSString *email = contactProperty.value;
    contactModel.name = name;
    contactModel.email = email;
    _nameTextField.text = name;
    _emaiTextField.text = email;
    NSLog(@"name:%@ email:%@",name,email);
}

#pragma mark - UISwitch Action
- (IBAction)worryTypeChanged:(id)sender {
    BOOL setting = _worrySwitch.isOn;
    if (setting == YES) {
        contactModel.worryType = [NSString stringWithFormat:@"%d",1];
    }else if (setting == NO){
        contactModel.worryType = [NSString stringWithFormat:@"%d",0];
    }
}

- (IBAction)emergencyTypeChanged:(id)sender {
    BOOL setting = _emergencySwitch.isOn;
    if (setting == YES) {
        contactModel.emergencyType = [NSString stringWithFormat:@"%d",1];
    }else if (setting == NO){
        contactModel.emergencyType = [NSString stringWithFormat:@"%d",0];
    }
}


#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
