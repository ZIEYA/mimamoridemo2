//
//  SeeContactTableViewController.h
//  Mimamoro
//
//  Created by totyu3 on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeeContactTableViewController : UITableViewController
@property (strong, nonatomic) NSArray * seedata;
@property long indexRow;
@property int type;
@property (strong, nonatomic) NSMutableArray *rootArr;
@property (strong, nonatomic) NSMutableArray *rootData;
@end
