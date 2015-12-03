//
//  AddGroupTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "AddGroupTableViewController.h"
#import "PersonImageCollectionViewController.h"

@interface AddGroupTableViewController ()<UITextFieldDelegate,imageDelegate>{
    NSString *groupname;
}
@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation AddGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)savaAction:(id)sender {
    groupname = _groupNameTextField.text;
}

- (IBAction)selectImageAction:(id)sender {
    [self performSegueWithIdentifier:@"gotoPersonImageVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PersonImageCollectionViewController *perVC = segue.destinationViewController;
    perVC.imagedelegate = self;
}

-(void)setSelectedImage:(UIImage *)image{
    self.imageview.image = image;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
