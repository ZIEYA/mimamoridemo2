//
//  CustomPickerView.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/16.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView ()
@property(strong, nonatomic)NSArray *pvArray;
@property(strong, nonatomic)NSString *resultString;


@end

@implementation CustomPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initPickview:(NSArray*)array{
    self = [super init];
    if (self) {
        self.pvArray = array;
    }
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pvArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pvArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _resultString = _pvArray[row];
    if ([self.PVDelegate respondsToSelector:@selector(selectedOneItem:)]) {
        [self.PVDelegate selectedOneItem:_resultString];
    }

}

@end
