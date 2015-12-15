//
//  EditGroupTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditGroupTableViewController.h"
#import "PersonImageCollectionViewController.h"
#import "GroupModel.h"
#import "ContactModel.h"
#import "LeafNotification.h"


@interface EditGroupTableViewController ()<UITextFieldDelegate,imageDelegate>{
    NSMutableArray *groupArr;
    NSMutableDictionary *contactDict;
    ContactModel *contactModel;
    NSString *oldGroup;
    
    NSMutableArray *contArr;
    
}
@property (weak, nonatomic) IBOutlet UISwitch *upsetSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *emergencySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *alertSwitch;

@property (weak, nonatomic) IBOutlet UITextField *contNameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@end

@implementation EditGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    oldGroup = self.groupmodel.groupname;
    contactModel = [[ContactModel alloc]init];
    
    contArr = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@""]];
    if (_editType == 0) {
        
    }
    //Delete the old one and add new one
    else if (_editType ==1){
        _contNameText.text = contactModel.name;
        _imageview.image = [UIImage imageNamed:contactModel.imageName];
        for (int i=0 ;i<contArr.count;i++) {
            NSDictionary *tmp = [groupArr objectAtIndex:i];
            NSString *key = [tmp valueForKey:@"name"];
            if ([contactModel.name isEqualToString:key]) {
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
        [LeafNotification showInController:self.navigationController withText:@"イメージを設定してください"];
        return;
    }
    contactModel.email = _emailText.text;
    contactModel.name = _contNameText.text;
    
    NSMutableDictionary *itemdict = [[NSMutableDictionary alloc]init];
    [itemdict setValue:contactModel.name forKey:@"name"];
    [itemdict setValue:contactModel.imageName forKey:@"image"];
    [itemdict setValue:contactModel.email forKey:@"email"];
    [itemdict setValue:contactModel.emergencyType forKey:@"emergencytype"];
    [itemdict setValue:contactModel.worryType forKey:@"worrytype"];
    [itemdict setValue:contactModel.alertType forKey:@"alerttype"];
    [contArr addObject:itemdict];
    NSLog(@"%@",contArr);
    [[NSUserDefaults standardUserDefaults]setObject:groupArr forKey:@"contact"];
    
    
//    //Delete the contact key and values
//    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contact"];
//    contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
//    NSArray *keysArr = [contactDict allKeys];
//    for (int i = 0; i<keysArr.count; i++) {
//        NSDictionary *dict = [contactDict objectForKey:keysArr[i]];
//        ContactModel *model = [[ContactModel alloc]init];
//        model.groupType = [dict valueForKey:@"group"];
//        model.name = [dict valueForKey:@"name"];
//        if ([oldGroup isEqualToString:model.groupType]) {
//            contactModel.name = [dict valueForKey:@"name"];
//            contactModel.email = [dict valueForKey:@"email"];
//            contactModel.worryType = [dict valueForKey:@"worrytype"];
//            contactModel.emergencyType = [dict valueForKey:@"emergencytype"];
//            //contactModel.groupType = [dict valueForKey:@"group"];
//            [contactDict removeObjectForKey:model.name];
//            
//            //Add new key and values in "contact"
//            NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
//            [temp setValue:contactModel.name forKey:@"name"];
//            [temp setValue:contactModel.email forKey:@"email"];
//            [temp setValue:contactModel.worryType forKey:@"worrytype"];
//            [temp setValue:contactModel.emergencyType forKey:@"emergencytype"];
//            [temp setValue:contactModel.groupType forKey:@"group"];
//            
//            [contactDict setObject:temp forKey:contactModel.name];
//            NSLog(@"tempname:%@",contactModel.name);
    
//        }
        
    [[NSUserDefaults standardUserDefaults]setObject:contactDict forKey:@"contact"];
    
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
    _imageview.image = [UIImage imageNamed:imagename];
    _groupmodel.groupimage = imagename;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
