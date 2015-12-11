//
//  WorryViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "WorryViewController.h"
#import "LeafNotification.h"
#import <MailCore/MailCore.h>
@interface WorryViewController ()
{
    NSString *userEmail;
    NSString *password;
    NSString *hostname;
    int port;
}
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
@property (strong, nonatomic) NSMutableArray *contArr;
@property (strong, nonatomic) NSString *emailMessage;
@end

@implementation WorryViewController
@synthesize healthyValue,spiritValue,happinessValue,contArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置数组数据
    if (!contArr) {
        contArr = [[NSMutableArray alloc]init];
    }
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
    //uitableview
    self.contactListTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.43, self.view.bounds.size.width*0.9, self.view.bounds.size.height*0.18)];
    self.contactListTableView.layer.borderWidth = 4.0;
    self.contactListTableView.layer.borderColor = [[UIColor orangeColor]CGColor];
    [self.view addSubview:self.contactListTableView];
    
    //title
    UILabel * state = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.63, self.view.bounds.size.width*0.75, 10)];
    state.text = @"•状態";
    [self.view addSubview:state];
    
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
-(void)viewWillAppear:(BOOL)animated
{
    [self setData];
    [self setData2];
    [self.contactListTableView reloadData];
}
-(void)setData
{
    //配置邮箱参数
    NSDictionary *user = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
    NSLog(@"user:%@",user);
    userEmail = [user valueForKey:@"email"];
    password = [user valueForKey:@"password"];
    hostname = [user valueForKey:@"hostname"];
    port = [[user valueForKey:@"severport"]intValue];
    if ([userEmail isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メールアドレス未設定"];
        return;
    }if ([password isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メールアドレス未設定"];
        return;
    }if ([hostname isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"ホスト未設定"];
        return;
    }if (!port) {
        [LeafNotification showInController:self withText:@"サーバポート未設定"];
        return;
    }
}
-(void)setData2{
    //设置接受人邮箱
    NSDictionary *tempdict =[[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
    NSLog(@"dic is:%@",tempdict);
    NSArray *temparr = [tempdict allKeys];
    self.contArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<temparr.count; i++) {
        NSDictionary *tempd = [[NSUserDefaults standardUserDefaults]objectForKey:temparr[i]];;
        NSLog(@"tempd:%@",tempd);
        NSArray *groupArr = [tempd allKeys];
        for (int j = 0; j<groupArr.count; j++) {
            NSDictionary *groupInside = [tempd objectForKey:groupArr[j]];
            NSLog(@"groupInside:%@",groupInside);
            NSString *type = [groupInside valueForKey:@"contacttype"];
            NSString *name = [groupInside valueForKey:@"name"];
            NSString *email = [groupInside valueForKey:@"email"];
            NSMutableDictionary *tocontact = [[NSMutableDictionary alloc]init];
            [tocontact setValue:name forKey:@"toname"];
            [tocontact setValue:email forKey:@"toemail"];
            if ([type isEqualToString:@"1"]) {
                [self.contArr addObject:tocontact];
            }
        }
    }

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
    //发送邮件
    MCOSMTPSession *session = [[MCOSMTPSession alloc]init];
    if (userEmail ==nil || password == nil || hostname ==nil || !port) {
        [LeafNotification showInController:self withText:@"自分の情報の未完成"];
    }else{
        session.username = userEmail;
        session.password = password;
        session.hostname = hostname;
        session.port = port;
        session.connectionType = MCOConnectionTypeTLS;
        session.authType = MCOAuthTypeSASLPlain;
        //构建邮件头
        MCOMessageBuilder *build = [[MCOMessageBuilder alloc]init];
        //设置发送人
        [[build header]setFrom:[MCOAddress addressWithDisplayName:nil mailbox:userEmail]];
        //设置接受人
        NSMutableArray *to = [[NSMutableArray alloc]init];
        for (int i = 0; i<contArr.count; i++) {
            NSDictionary *toemailDic = [contArr objectAtIndex:i];
            MCOAddress *toAddress = [MCOAddress addressWithDisplayName:nil mailbox:[toemailDic valueForKey:@"toemail"]];
            [to addObject:toAddress];
        }
        if (to.count ==0) {
            [LeafNotification showInController:self withText:@"通信の人がない"];
        }else {
            [[build header]setTo:to];//who is send to
            //[to release];
            //设置邮件标题
            [[build header]setSubject:@"worry Email "];
            //设置邮件正文
            self.emailMessage = [NSString stringWithFormat:@"身体状态：%@,精神状态：%@,幸せわ：%@",self.healthyValue,self.spiritValue,self.happinessValue];
            NSString *messageSend = self.emailMessage;
            [build setTextBody:messageSend];
            //发送构建好的邮件体
            NSData *rfc822Data = [build data];
            MCOSMTPOperation *sendOpertion = [session sendOperationWithData:rfc822Data];
            [sendOpertion start:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error sending email:%@",error);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [LeafNotification showInController:self withText:@"メール送信が失敗しました！"];
                    });
                }else{
                    NSLog(@"Successfully send email!");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [LeafNotification showInController:self withText:@"メール送信が成功しました！" type:LeafNotificationTypeSuccess];
                    });
                }
            }];
        }
    }
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    }
    NSDictionary *cellvalue = contArr[indexPath.row];
    cell.textLabel.text = [cellvalue valueForKey:@"toname"];
    cell.detailTextLabel.text =[cellvalue valueForKey:@"toemail"];
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
