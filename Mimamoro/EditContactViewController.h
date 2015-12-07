//
//  EditContactViewController.h
//  Mimamoro
//
//  Created by totyu3 on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditContactViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) NSArray *editdata;
@property long indexRow;
@property long oldIndexRow;
@property int type;
@property (strong, nonatomic) NSMutableArray *rootArr;
@property (strong, nonatomic) NSMutableArray *rootData;
@end
