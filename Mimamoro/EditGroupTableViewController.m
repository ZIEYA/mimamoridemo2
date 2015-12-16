//
//  EditGroupTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditGroupTableViewController.h"
#import "PersonImageCollectionViewController.h"
#import "ContactModel.h"
#import "LeafNotification.h"


@interface EditGroupTableViewController ()<UITextFieldDelegate,imageDelegate>{
    ContactModel *contactModel;
    NSMutableArray *contArr;
    int n;
}
@property (weak, nonatomic) IBOutlet UISwitch *upsetSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *emergencySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *alertSwitch;

@property (weak, nonatomic) IBOutlet UITextField *contNameText;
@property (weak, nonatomic) IBOutlet UIButton *addFromphone;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@end

@implementation EditGroupTableViewController
@synthesize contdic;


- (void)viewDidLoad {
    [super viewDidLoad];
//    if (_editType==1) {
//        _addFromphone.hidden=YES;
//    }else{
//        _addFromphone.hidden = NO;
//    }
    contactModel = [[ContactModel alloc]init];
    contArr = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"contacts"]];
    if (_editType == 0) {
        
    }
    //Delete the old one and add new one
    else if (_editType ==1){
        _emailText.text = [contdic valueForKey:@"email"];
        _contNameText.text = [contdic valueForKey:@"name"];
        _imageview.image = [UIImage imageNamed:[contdic valueForKey:@"img"]];
        
        if ([[contdic valueForKey:@"worrytype"] isEqualToString:@"1"]) {
            _upsetSwitch.on =YES;
        }else{
            _upsetSwitch.on = NO;
        }
        if ([[contdic valueForKey:@"emergencytype"] isEqualToString:@"1"]) {
            _emergencySwitch.on =YES;
        }else{
            _emergencySwitch.on = NO;
        }
        if ([[contdic valueForKey:@"alerttype"] isEqualToString:@"1"]) {
            _alertSwitch.on =YES;
        }else{
            _alertSwitch.on = NO;
        }
        for (int i=0 ;i<contArr.count;i++) {
            NSDictionary *tmp = [contArr objectAtIndex:i];
            NSString *key = [tmp valueForKey:@"email"];
            if ([_contNameText.text isEqualToString:key]) {
                [contArr removeObject:tmp];
            }
        }
    }
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)savaAction:(id)sender {
    if ([_contNameText.text isEqual:@""]) {
        [LeafNotification showInController:self.navigationController withText:@"グループ名を入力してください"];
        return;
    }
    if (_emailText.text == nil ||[_emailText.text isEqualToString:@""]) {
        [LeafNotification showInController:self.navigationController withText:@"メールアドレスを設定してください"];
        return;
    }
    
    if (n !=1) {
        if (_editType==0) {
            [LeafNotification showInController:self.navigationController withText:@"イメージを設定してください"];
            return;
        }else{
        contactModel.imageName = [contdic valueForKey:@"img"];
        }
    }
    contactModel.email = _emailText.text;
    contactModel.name = _contNameText.text;
    
    if (_upsetSwitch.on ==YES) {
        contactModel.worryType = @"1";
    }else{
        contactModel.worryType = @"0";
    }
    if (_emergencySwitch.on ==YES) {
        contactModel.emergencyType = @"1";
    }else{
        contactModel.emergencyType = @"0";
    }
    if (_alertSwitch.on == YES) {
        contactModel.alertType = @"1";
    }else{
        contactModel.alertType = @"0";
    }
    NSMutableDictionary *itemdict = [[NSMutableDictionary alloc]init];
    [itemdict setValue:contactModel.name forKey:@"name"];
    [itemdict setValue:contactModel.imageName forKey:@"img"];
    [itemdict setValue:contactModel.email forKey:@"email"];
    [itemdict setValue:contactModel.emergencyType forKey:@"emergencytype"];
    [itemdict setValue:contactModel.worryType forKey:@"worrytype"];
    [itemdict setValue:contactModel.alertType forKey:@"alerttype"];
    [contArr addObject:itemdict];
    NSLog(@"the ar  is ::%@",contArr);
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"contacts"];
    [[NSUserDefaults standardUserDefaults]setObject:contArr forKey:@"contacts"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)selectImageAction:(id)sender {
    [self performSegueWithIdentifier:@"gotoPersonImageTVC" sender:self];
}

#pragma mark - switch
- (IBAction)upsetSwitch:(id)sender {
    BOOL setting = _upsetSwitch.isOn;
    if (setting == YES) {
        contactModel.worryType = [NSString stringWithFormat:@"%d",1];
    }else if (setting ==NO){
        contactModel.worryType = [NSString stringWithFormat:@"%d",0];
    }
}
- (IBAction)emergencySwitch:(id)sender {
    BOOL setting = _emergencySwitch.isOn;
    if (setting == YES) {
        contactModel.emergencyType = [NSString stringWithFormat:@"%d",1];
    }else if (setting ==NO){
        contactModel.emergencyType = [NSString stringWithFormat:@"%d",0];
    }
}
- (IBAction)alertSwitch:(id)sender {
    BOOL setting = _alertSwitch.isOn;
    if (setting == YES) {
        contactModel.alertType = [NSString stringWithFormat:@"%d",1];
    }else if (setting ==NO){
        contactModel.alertType = [NSString stringWithFormat:@"%d",0];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PersonImageCollectionViewController *perVC = segue.destinationViewController;
    perVC.imagedelegate = self;
}

-(void)setSelectedImage:(NSString *)imagename{
    n = 1;
    _imageview.image = [UIImage imageNamed:imagename];
    contactModel.imageName = imagename;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)phoneSelect:(id)sender {
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
    _contNameText.text =[NSString stringWithFormat:@"%@ %@",contact.familyName,contact.givenName];
    _emailText.text = [NSString stringWithFormat:@"%@",[contact.emailAddresses firstObject].value];
    NSLog(@"name:%@,email:%@",_contNameText.text,_emailText.text);
    
}


@end
