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
}
@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@end

@implementation EditGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    oldGroup = self.groupmodel.groupname;
    contactModel = [[ContactModel alloc]init];

    NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"group"];
    groupArr = [[NSMutableArray alloc]initWithArray:temp];
    if (_editType == 0) {
        
    }
    //Delete the old one and add new one
    else if (_editType ==1){
        _groupNameTextField.text = _groupmodel.groupname;
        _imageview.image = [UIImage imageNamed:_groupmodel.groupimage];
        for (int i=0 ;i<groupArr.count;i++) {
            NSDictionary *tmp = [groupArr objectAtIndex:i];
            NSString *key = [tmp valueForKey:@"groupname"];
            if ([_groupmodel.groupname isEqualToString:key]) {
                [groupArr removeObject:tmp];
            }
        }
    }
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)savaAction:(id)sender {
    if ([_groupNameTextField.text isEqual:@""]||_imageview.image == nil) {
        [LeafNotification showInController:self withText:@"画像或いはグループ名を設定してください"];
        return;
    }
     _groupmodel.groupname = _groupNameTextField.text;
    contactModel.groupType = _groupNameTextField.text;

    if (_editType == 0) {
        //Add new one ->group
        NSMutableDictionary *itemdict = [[NSMutableDictionary alloc]init];
        [itemdict setValue:_groupmodel.groupname forKey:@"groupname"];
        [itemdict setValue:_groupmodel.groupimage forKey:@"image"];
        [groupArr addObject:itemdict];
        [[NSUserDefaults standardUserDefaults]setObject:groupArr forKey:@"group"];
    }else if (_editType == 1){
        //Delete the old one and add new one (at viewDidLoad)-> group
         NSMutableDictionary *itemdict = [[NSMutableDictionary alloc]init];
        [itemdict setValue:_groupmodel.groupname forKey:@"groupname"];
        [itemdict setValue:_groupmodel.groupimage forKey:@"image"];
        [groupArr addObject:itemdict];
        NSLog(@"%@",groupArr);
        [[NSUserDefaults standardUserDefaults]setObject:groupArr forKey:@"group"];
        
        
        //Delete the contact key and values
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contact"];
        contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
        NSArray *keysArr = [contactDict allKeys];
        for (int i = 0; i<keysArr.count; i++) {
            NSDictionary *dict = [contactDict objectForKey:keysArr[i]];
            ContactModel *model = [[ContactModel alloc]init];
            model.groupType = [dict valueForKey:@"group"];
            model.name = [dict valueForKey:@"name"];
            if ([oldGroup isEqualToString:model.groupType]) {
                contactModel.name = [dict valueForKey:@"name"];
                contactModel.email = [dict valueForKey:@"email"];
                contactModel.worryType = [dict valueForKey:@"worrytype"];
                contactModel.emergencyType = [dict valueForKey:@"emergencytype"];
                //contactModel.groupType = [dict valueForKey:@"group"];
                [contactDict removeObjectForKey:model.name];
                
                //Add new key and values in "contact"
                NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                [temp setValue:contactModel.name forKey:@"name"];
                [temp setValue:contactModel.email forKey:@"email"];
                [temp setValue:contactModel.worryType forKey:@"worrytype"];
                [temp setValue:contactModel.emergencyType forKey:@"emergencytype"];
                [temp setValue:contactModel.groupType forKey:@"group"];
                
                [contactDict setObject:temp forKey:contactModel.name];
                NSLog(@"tempname:%@",contactModel.name);
            }
        }

        [[NSUserDefaults standardUserDefaults]setObject:contactDict forKey:@"contact"];
    }
    [self.navigationController popViewControllerAnimated:YES];
   
}

- (IBAction)selectImageAction:(id)sender {
    [self performSegueWithIdentifier:@"gotoPersonImageTVC" sender:self];
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
