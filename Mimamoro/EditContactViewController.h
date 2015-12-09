//
//  EditContactViewController.h
//  Mimamori
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditContactViewController : UITableViewController
@property int editType;//0:追加  1:編集
@property NSString *tempName;
@property NSString *familytype;
@end
