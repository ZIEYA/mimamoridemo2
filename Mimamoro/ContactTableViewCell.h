//
//  ContactTableViewCell.h
//  Mimamoro
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ctvName;
@property (weak, nonatomic) IBOutlet UILabel *ctvEmail;
@property (weak, nonatomic) IBOutlet UIImageView *ctvState;

@end
