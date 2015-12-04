//
//  PickerView.h
//  Mimamori
//
//  Created by totyu1 on 2015/11/19.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PickerView;

@protocol PickerViewDelegate <NSObject>

-(void)selectedOneItem:(NSString*)resultstring;

@end

@interface PickerView : UIView

@property (nonatomic,strong) id<PickerViewDelegate>PVDelegate;

-(instancetype)initPickerViewWithArray:(NSArray*)array;

//Move pickerview
-(void)remove;

//Show pickerview
-(void)show;

@end
