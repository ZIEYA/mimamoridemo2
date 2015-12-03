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


@interface EditGroupTableViewController ()<UITextFieldDelegate,imageDelegate>{
    GroupModel *groupmodel;
}
@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@end

@implementation EditGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    groupmodel = [[GroupModel alloc]init];
    groupmodel.groupname = self.tempname;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)savaAction:(id)sender {
    groupmodel.groupname = _groupNameTextField.text;
}

- (IBAction)selectImageAction:(id)sender {
    [self performSegueWithIdentifier:@"gotoPersonImageTVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PersonImageCollectionViewController *perVC = segue.destinationViewController;
    perVC.imagedelegate = self;
}

-(void)setSelectedImage:(NSString *)imagename{
    self.imageview.image = [UIImage imageNamed:imagename];
    groupmodel.groupimage = imagename;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
