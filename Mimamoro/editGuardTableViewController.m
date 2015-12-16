//
//  editGuardTableViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "editGuardTableViewController.h"
#import "LeafNotification.h"
@interface editGuardTableViewController ()
{
    NSMutableArray*tool;
    NSArray*hour;
    NSArray*frequency;
    
    NSArray*sheding1;
    NSArray*sheding2;
    
    NSString*toolData;
    NSString*hourData1;
    NSString*hourData2;
    NSString*frequencyData1;
    NSString*frequencyData2;
    
    NSMutableDictionary*guardData;
    NSMutableDictionary*anybodyData;
    NSMutableDictionary*exitDict;
}
@property (weak, nonatomic) IBOutlet UIPickerView *toolPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *hourpickerView1;
@property (weak, nonatomic) IBOutlet UIPickerView *hourpickerView2;
@property (weak, nonatomic) IBOutlet UIPickerView *frequencyPickerView1;
@property (weak, nonatomic) IBOutlet UIPickerView *frequencyPickerView2;
@property (weak, nonatomic) IBOutlet UITextField *idText;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation editGuardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"anybody"];
    tool = [[NSMutableArray alloc]init];
    exitDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    if (!anybodyData) {
        anybodyData = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    anybodyData = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"anybody"]];
    if (!guardData) {
        guardData = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    guardData = [[NSMutableDictionary alloc]initWithDictionary:[anybodyData objectForKey:_anybodyNamee]];
    NSLog(@"guardData1%@",guardData);
    self.navigationItem.title = _anybodyNamee;
    
    _saveButton.layer.cornerRadius = 6;
    
    NSMutableArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"item"];
    for (NSDictionary *tmpdict in temp) {

        [tool addObject:[tmpdict valueForKey:@"name"]];
    }
    
    
//    tool = [NSArray arrayWithObjects:@"电器管理",@"口袋医生1",@"口袋医生2",@"口袋医生3",@"口袋医生4",@"口袋医生5",nil];
    hour = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",nil];
    frequency = [NSArray arrayWithObjects:@"連続使用",@"使用なし",nil];
    
    
    if (_edittype == 0) {
            toolData = tool[0];
            hourData1 = hour[0];
            hourData2 = hour[0];
            frequencyData1 = frequency[0];
            frequencyData2 = frequency[0];

    }else if (_edittype == 1){
        exitDict = [guardData objectForKey:_Guardidd];
        
        _idText.text = _Guardidd;
        
        
        NSArray * hour3 = [[NSArray alloc]initWithArray:[exitDict valueForKey:@"sheding1"]];
        NSArray * hour4 =[[NSArray alloc]initWithArray:[exitDict valueForKey:@"sheding2"]];
        toolData=[exitDict valueForKey:@"toolData"];
        hourData1=hour3[0];
        hourData2=hour4[0];
        frequencyData1=hour3[1];
        frequencyData2=hour4[1];
        
        NSUInteger i = [tool indexOfObject:toolData];
        [self.toolPickerView selectRow:i inComponent:0 animated:NO];
        
        NSUInteger ii = [hour indexOfObject:hourData1];
        [self.hourpickerView1 selectRow:ii inComponent:0 animated:NO];
        NSUInteger iii = [frequency indexOfObject:frequencyData1];
        [self.frequencyPickerView1 selectRow:iii inComponent:0 animated:NO];
        
        
        NSUInteger iiii = [hour indexOfObject:hourData2];
        [self.hourpickerView2 selectRow:iiii inComponent:0 animated:NO];
        NSUInteger iiiii = [frequency indexOfObject:frequencyData2];
        [self.frequencyPickerView2 selectRow:iiiii inComponent:0 animated:NO];
        
    }

    
}
//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}
//行数
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView == _toolPickerView)
    {
        return tool.count;
    }else if(pickerView == _hourpickerView1||pickerView == _hourpickerView2)
    {
        return hour.count;
    }else{
        return frequency.count;
    }
    
}
//行的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    if(pickerView == _toolPickerView)
    {
        return  30;
    }else if(pickerView == _hourpickerView1||pickerView == _hourpickerView2)
    {
        return  _hourpickerView1.frame.size.height*0.6;
    }else{
        return  _frequencyPickerView1.frame.size.height*0.6;
    }
    
}
//行的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if(pickerView == _toolPickerView)
    {
        return  _toolPickerView.frame.size.width;
    }else if(pickerView == _hourpickerView1||pickerView == _hourpickerView2)
    {
        return  _hourpickerView1.frame.size.width;
    }else{
        return  _frequencyPickerView1.frame.size.width;
    }
}
//每行显示
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view) {
        view=[[UIView alloc]init];
    }
    if(pickerView == _toolPickerView)
    {
        UILabel *text=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _toolPickerView.frame.size.width,30)];
        text.backgroundColor = [UIColor lightGrayColor];
        text.textColor = [UIColor blackColor];
        text.textAlignment = NSTextAlignmentCenter;
        text.font = [UIFont fontWithName:@"Arial" size:20.0f];
        text.text = [tool objectAtIndex:row];
        [view addSubview:text];
        return view;

    }else if(pickerView == _hourpickerView1||pickerView == _hourpickerView2)
    {
        UILabel *text=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _hourpickerView1.frame.size.width, _hourpickerView1.frame.size.height*0.6)];
        text.backgroundColor = [UIColor lightGrayColor];
        text.textColor = [UIColor blackColor];
        text.textAlignment = NSTextAlignmentCenter;
        text.font = [UIFont fontWithName:@"Arial" size:17.0f];
        text.text = [hour objectAtIndex:row];
        [view addSubview:text];
        return view;

    }else{
        UILabel *text=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _frequencyPickerView1.frame.size.width,_frequencyPickerView1.frame.size.height*0.6)];
        text.backgroundColor = [UIColor lightGrayColor];
        text.textColor = [UIColor blackColor];
        text.textAlignment = NSTextAlignmentCenter;
        text.font = [UIFont fontWithName:@"Arial" size:17.0f];
        text.text = [frequency objectAtIndex:row];
        [view addSubview:text];
        return view;

    }
    }
//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView == _toolPickerView)
    {
        toolData = [tool objectAtIndex:row];
        NSLog(@"tool选中%@",toolData);
    }else if(pickerView == _hourpickerView1)
    {
        hourData1 = [hour objectAtIndex:row];
        NSLog(@"hourData1选中%@",hourData1);
    }else if(pickerView == _hourpickerView2)
    {
        hourData2 = [hour objectAtIndex:row];
        NSLog(@"hourData2选中%@",hourData2);
    }else if(pickerView == _frequencyPickerView1)
    {
        frequencyData1 = [frequency objectAtIndex:row];
        NSLog(@"frequencyData1选中%@",frequencyData1);
    }else if(pickerView == _frequencyPickerView2)
    {
        frequencyData2 = [frequency objectAtIndex:row];
        NSLog(@"frequencyData2选中%@",frequencyData2);
    }
}

- (IBAction)saveBtn:(id)sender {
    if (_edittype == 0) {
    }else if (_edittype == 1){
        [guardData removeObjectForKey:_Guardidd];
    }
    if([_idText.text isEqualToString: @""]){
        [LeafNotification showInController:self withText:[NSString stringWithFormat:@"idは空にできません"]];
    }else{
    sheding1 = [[NSArray alloc]initWithObjects:hourData1,frequencyData1, nil];
    sheding2 = [[NSArray alloc]initWithObjects:hourData2,frequencyData2, nil];
    NSMutableDictionary*guardd = [[NSMutableDictionary alloc]init];
    [guardd setValue:toolData forKey:@"toolData"];
    [guardd setValue:_idText.text forKey:@"id"];
    [guardd setValue:sheding1 forKey:@"sheding1"];
    [guardd setValue:sheding2 forKey:@"sheding2"];
    [guardd setValue:@"1" forKey:@"type"];
    [guardData setObject:guardd forKey:_idText.text];
    [anybodyData setObject:guardData forKey:_anybodyNamee];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults]setObject:anybodyData forKey:@"anybody"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
