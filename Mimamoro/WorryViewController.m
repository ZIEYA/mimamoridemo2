//
//  WorryViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "WorryViewController.h"

@interface WorryViewController ()
@property (strong, nonatomic) IBOutlet UITextView *contactListTextView;
@property (strong, nonatomic) IBOutlet UISlider *healthSlider;
@property (strong, nonatomic) IBOutlet UISlider *spiritSlider;
@property (strong, nonatomic) IBOutlet UISlider *happinessSlider;

@end

@implementation WorryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
