//
//  CustomPickerView.h
//  Mimamoro
//
//  Created by totyu1 on 2015/12/16.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickerViewDelegate <NSObject>

-(void)selectedOneItem:(NSString*)resultstring;

@end

@interface CustomPickerView : UIPickerView
@property (nonatomic,strong) id<PickerViewDelegate>PVDelegate;
-(instancetype)initPickview:(NSArray*)array;
@end
