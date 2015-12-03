//
//  EditContactTableViewController.h
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditContactTableViewController : UITableViewController
@property int editType;//0:追加  1:編集
@property NSString *tempName;
@property NSString *gruopname;
@end
