//
//  GuardTableViewCell.h
//  Mimamoro
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *guardTitle;

@property (weak, nonatomic) IBOutlet UISwitch *guardType;

@end
