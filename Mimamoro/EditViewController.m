//
//  EditViewController.m
//  Mimamoro
//
//  Created by totyu3 on 15/12/8.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (strong, nonatomic) UITextField *groupName;
@property (strong, nonatomic) UIImage *groupImage;
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = save;
    
    self.groupName = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 300, 40)];
    self.groupName.text = [self.viewDic valueForKey:@"name"];
    [self.view addSubview:self.groupName];
}

-(void)saveAction
{
    NSMutableDictionary * group = [[NSMutableDictionary alloc]init];
    [group setValue:self.groupName.text forKey:@"name"];
    NSMutableArray *root = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"root"]];
    [root replaceObjectAtIndex:self.indexRow withObject:group];
    NSUserDefaults *rootuser = [NSUserDefaults standardUserDefaults];
    [rootuser removeObjectForKey:@"root"];
    [rootuser setObject:root forKey:@"root"];
    [rootuser synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
