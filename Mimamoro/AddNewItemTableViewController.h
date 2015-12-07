//
//  AddNewItemTableViewController.h
//  Mimamoro
//
//  Created by totyu1 on 2015/12/07.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewItemTableViewController : UITableViewController
@property (nonatomic, strong)NSString *tmpitemName;
@property (nonatomic, strong)NSString *tmpitemImage;
@property (nonatomic, assign)int edittype;
@end
