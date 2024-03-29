//
//  TabBarController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.tabBar.items objectAtIndex:0]setImage:[[UIImage imageNamed:@"contactlist-0.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[self.tabBar.items objectAtIndex:1]setImage:[[UIImage imageNamed:@"emergency-0.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[self.tabBar.items objectAtIndex:2]setImage:[[UIImage imageNamed:@"worry-0.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[self.tabBar.items objectAtIndex:3]setImage:[[UIImage imageNamed:@"setting-0.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [[self.tabBar.items objectAtIndex:0]setSelectedImage:[[UIImage imageNamed:@"contactlist.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[self.tabBar.items objectAtIndex:1]setSelectedImage:[[UIImage imageNamed:@"emergency.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[self.tabBar.items objectAtIndex:2]setSelectedImage:[[UIImage imageNamed:@"worry.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[self.tabBar.items objectAtIndex:3]setSelectedImage:[[UIImage imageNamed:@"setting.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:130.0/255.0 alpha:1.0f]} forState:UIControlStateSelected];
    
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
