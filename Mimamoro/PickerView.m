//
//  PickerView.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/19.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "PickerView.h"

@interface PickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(strong, nonatomic)NSArray *pvArray;
@property(strong, nonatomic)NSString *resultString;
@property(strong, nonatomic)UIPickerView *pickerview;

@end

@implementation PickerView


-(instancetype)initPickerViewWithArray:(NSArray*)array{
    self=[super init];
    if (self) {
        self.pvArray=array;
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-200, [UIScreen mainScreen].bounds.size.width, 200);
        [self setUpPickerView];
        
    }
    return self;
}

-(void)setUpPickerView{
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    [pickerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    _pickerview = pickerView;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self addSubview:pickerView];
    
}

-(void)remove{
    [self removeFromSuperview];
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pvArray.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pvArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _resultString = _pvArray[row];
    if ([self.PVDelegate respondsToSelector:@selector(selectedOneItem:)]) {
        [self.PVDelegate selectedOneItem:_resultString];
    }
    //[self.pvdelegate selectOneItem:_resultString];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
