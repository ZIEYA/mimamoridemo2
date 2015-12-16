//
//  AddItemTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/16.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "AddItemTableViewController.h"

@interface AddItemTableViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray *categoryArr;
    NSArray *shikiiArr;
    NSArray *categoryArr2;
    NSString *category;
    int shikii1;
    NSString *category2;
    int shikii2;
    NSString *category3;
}
@property (strong, nonatomic) IBOutlet UIPickerView *categoryPickview;
@property (strong, nonatomic) IBOutlet UIPickerView *shikii1Pickview;
@property (strong, nonatomic) IBOutlet UIPickerView *shikii2Pickview;
@property (strong, nonatomic) IBOutlet UIPickerView *category2Pickview;
@property (strong, nonatomic) IBOutlet UIPickerView *category3Pickview;

@end

@implementation AddItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    categoryArr = @[@"電気見守り",@"ポケットドクター"];
    shikiiArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];
    categoryArr2 = @[@"検値なし",@"連続検値"];

}

-(void)viewWillAppear:(BOOL)animated{
    [self clearSeparatorWithView:_categoryPickview];
    [self clearSeparatorWithView:_shikii1Pickview];
    [self clearSeparatorWithView:_shikii2Pickview];
    [self clearSeparatorWithView:_category2Pickview];
    [self clearSeparatorWithView:_category3Pickview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag ==101) {
        return categoryArr.count;
    }else if (pickerView.tag == 102||pickerView.tag == 104){
        return shikiiArr.count;
    }else if (pickerView.tag == 103 ||pickerView.tag == 105){
        return categoryArr2.count;
    }else{
        return 1;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag ==101) {
        return categoryArr[row];
    }else if (pickerView.tag == 102||pickerView.tag == 104){
        return shikiiArr[row];
    }else if (pickerView.tag == 103 ||pickerView.tag == 105){
        return categoryArr2[row];
    }else{
        return nil;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag ==101) {
        category = categoryArr[row];
    }else if (pickerView.tag == 102){
        shikii1 = [shikiiArr[row]intValue];;
    }else if (pickerView.tag ==103){
        category2 = categoryArr2[row];
    }else if (pickerView.tag == 104){
        shikii2 = [shikiiArr[row]intValue];
    }
    else if (pickerView.tag == 105){
        category3 =  categoryArr2[row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(void)clearSeparatorWithView:(UIView *)view{
    if (view.subviews !=0) {
        view.backgroundColor = [UIColor clearColor];
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
}


@end
