//
//  WorryViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "WorryViewController.h"

@interface WorryViewController ()
@property (strong, nonatomic)  UITableView *contactListTableView;
@property (strong, nonatomic)  UISlider *healthSlider;
@property (strong, nonatomic)  UISlider *spiritSlider;
@property (strong, nonatomic)  UISlider *happinessSlider;
@property (strong, nonatomic) UIButton *worrybtn;
@property (strong, nonatomic) NSString *healthyValue;
@property (strong, nonatomic) NSString *spiritValue;
@property (strong, nonatomic) NSString *happinessValue;


@property (strong, nonatomic) UILabel *Lab1;
@property (strong, nonatomic) UILabel *Lab2;
@property (strong, nonatomic) UILabel *Lab3;
@property (strong, nonatomic) NSArray *contArr;
@end

@implementation WorryViewController
@synthesize healthyValue,spiritValue,happinessValue;
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置数组数据
    self.contArr = @[@"one",@"two",@"three",@"four"];
    
    //页面控件的设置
    //button
    UIImage * worrybgimg = [UIImage imageNamed:@"worrybtn.png"];
    self.worrybtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.13, self.view.bounds.size.width*0.4, self.view.bounds.size.width*0.4)];
    [self.worrybtn addTarget:self action:@selector(upsetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.worrybtn setBackgroundImage:worrybgimg forState:UIControlStateNormal];
    [self.view addSubview:self.worrybtn];
    //title
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.40, self.view.bounds.size.width*0.75, 10)];
    message.text = @"•通知先";
    [self.view addSubview:message];
    //uitextview
    self.contactListTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.1, self.view.bounds.size.height*0.43, self.view.bounds.size.width*0.8, self.view.bounds.size.height*0.18)];
    self.contactListTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.contactListTableView];
    
    //title
    UILabel * state = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.63, self.view.bounds.size.width*0.75, 10)];
    state.text = @"•状態";
    [self.view addSubview:state];
    
//    UILabel * good = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2, self.view.bounds.size.height*0.66, self.view.bounds.size.width*0.2, 10)];
//    good.text = @"悪い";
//    [self.view addSubview:good];
//    UILabel * bad = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.85, self.view.bounds.size.height*0.66, self.view.bounds.size.width*0.2, 10)];
//    bad.text = @"良い";
//    [self.view addSubview:bad];
    
    
    //UISlider设置
    UILabel *health = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.73, self.view.bounds.size.width*0.2, 10)];
    health.text = @"身体";
    [self.view addSubview:health];
    self.healthSlider = [[UISlider alloc]init];
    [self.healthSlider setMinimumValue:0];
    [self.healthSlider setMaximumValue:5];
    [self.healthSlider setValue:2.5];
    healthyValue = @"适中";
    
    _Lab1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.16, self.view.bounds.size.height*0.73, self.view.bounds.size.width*0.2, 10)];
    _Lab1.text = healthyValue;
    _Lab1.font = [UIFont fontWithName:@"AmericanTypewriter" size:12];
    [self.view addSubview:_Lab1];
    
    self.healthSlider.frame = CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.73, self.view.bounds.size.width*0.65, 5);
    //身体sliderAction
    [self.healthSlider addTarget:self action:@selector(healthSliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.healthSlider];
    
    UILabel *spirit = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.80, self.view.bounds.size.width*0.2, 10)];
    spirit.text = @"精神";
    _Lab2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.16, self.view.bounds.size.height*0.8, self.view.bounds.size.width*0.2, 10)];
    _Lab2.text = healthyValue;
    _Lab2.font = [UIFont fontWithName:@"AmericanTypewriter" size:12];
    [self.view addSubview:_Lab2];
    [self.view addSubview:spirit];
    self.spiritSlider = [[UISlider alloc]init];
    self.spiritSlider.frame = CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.80, self.view.bounds.size.width*0.65, 5);
    [self.spiritSlider setMinimumValue:0];
    [self.spiritSlider setMaximumValue:5];
    [self.spiritSlider setValue:2.5];
    spiritValue = @"适中";
    NSLog(@"%@",spiritValue);
    //健康sliderAction
    [self.spiritSlider addTarget:self action:@selector(spiritSliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.spiritSlider];
    
    UILabel *happiness = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.87, self.view.bounds.size.width*0.2, 10)];
    happiness.text = @"幸せ";
    _Lab3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.16, self.view.bounds.size.height*0.87, self.view.bounds.size.width*0.2, 10)];
    _Lab3.text = healthyValue;
    _Lab3.font = [UIFont fontWithName:@"AmericanTypewriter" size:12];
    [self.view addSubview:_Lab3];
    [self.view addSubview:happiness];
    self.happinessSlider = [[UISlider alloc]init];
    self.happinessSlider.frame = CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.87, self.view.bounds.size.width*0.65, 5);
    [self.happinessSlider setMinimumValue:0];
    [self.happinessSlider setMaximumValue:5];
    [self.happinessSlider setValue:2.5];
    happinessValue = @"适中";
    //幸せsliderAction
    [self.happinessSlider addTarget:self action:@selector(happinessSliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.happinessSlider];
    
    //delegate
    self.contactListTableView.dataSource = self;
    
}
#pragma mark - sliderAction

-(void)healthSliderChange:(UISlider *)sender
{
    if (sender.value<1) {
        healthyValue = @"悪い";
    }if (sender.value>=1 && sender.value<2) {
        healthyValue = @"少し悪い";
    }if (sender.value>=2 && sender.value<3) {
        healthyValue = @"适中";
    }if (sender.value>=3 && sender.value<4) {
        healthyValue = @"良い";
    }if (sender.value>=4 && sender.value<=5) {
        healthyValue = @"優秀";
    }
    self.Lab1.text = healthyValue;
    NSLog(@"身体状态：%@",healthyValue);
}
-(void)spiritSliderChange:(UISlider *)sender
{
    if (sender.value<1) {
        spiritValue = @"悪い";
    }if (sender.value>=1 && sender.value<2) {
        spiritValue = @"少し悪い";
    }if (sender.value>=2 && sender.value<3) {
        spiritValue = @"适中";
    }if (sender.value>=3 && sender.value<4) {
        spiritValue = @"良い";
    }if (sender.value>=4 && sender.value<=5) {
        spiritValue = @"優秀";
    }
    self.Lab2.text = spiritValue;
    NSLog(@"精神状态：%@",spiritValue);
}
-(void)happinessSliderChange:(UISlider*)sender
{
    if (sender.value<1) {
        happinessValue = @"悪い";
    }if (sender.value>=1 && sender.value<2) {
        happinessValue = @"少し悪い";
    }if (sender.value>=2 && sender.value<3) {
        happinessValue = @"适中";
    }if (sender.value>=3 && sender.value<4) {
        happinessValue = @"良い";
    }if (sender.value>=4 && sender.value<=5) {
        happinessValue = @"優秀";
    }
    self.Lab3.text = happinessValue;
    NSLog(@"幸せわ：%@",happinessValue);
}
#pragma mark - buttonAction
- (void)upsetAction {
    
    NSLog(@"chick me!");
}
#pragma mark - uitableview datesource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.textLabel.text = self.contArr[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
