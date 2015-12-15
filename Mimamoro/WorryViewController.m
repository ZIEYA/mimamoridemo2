//
//  WorryViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "WorryViewController.h"
#import "worryCollectionViewCell.h"
#import "LeafNotification.h"
#import <MailCore/MailCore.h>
@interface WorryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    worryCollectionViewCell *cell;
    NSMutableDictionary *worryDict;
    NSMutableArray *worryArray;
    NSMutableArray *worryEmailArray;
    NSArray *famtitl;
    NSDictionary *famtitl2;
    
    NSString *userEmail1;
    NSString *password1;
    NSString *hostname1;
    int port1;
}
@property (weak, nonatomic) IBOutlet UICollectionView *contactListTableView;

@property (strong, nonatomic) IBOutlet UISlider *healthSlider;
@property (strong, nonatomic) IBOutlet UISlider *spiritSlider;
@property (strong, nonatomic) IBOutlet UISlider *happinessSlider;
@property (weak, nonatomic) IBOutlet UILabel *state1;
@property (weak, nonatomic) IBOutlet UILabel *state2;
@property (weak, nonatomic) IBOutlet UILabel *state3;
@property (weak, nonatomic) IBOutlet UILabel *backgroundlabel;

@property (weak, nonatomic) IBOutlet UIButton *worrybutton;

@end

@implementation WorryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contactListTableView.delegate = self;
    _contactListTableView.dataSource = self;
    _contactListTableView.layer.cornerRadius = 10;
    _backgroundlabel.layer.cornerRadius = 10;
    [_worrybutton addTarget:self action:@selector(getEmaill) forControlEvents:UIControlEventTouchUpInside];

    _healthSlider.minimumValue = 0.0;
    _healthSlider.maximumValue = 255.0;
    _healthSlider.value = 255.0;
    _spiritSlider.minimumValue = 0.0;
    _spiritSlider.maximumValue = 255.0;
    _spiritSlider.value = 255.0;
    _happinessSlider.minimumValue = 0.0;
    _happinessSlider.maximumValue = 255.0;
    _happinessSlider.value = 255.0;
    
    famtitl = [[NSArray alloc]init];
    worryArray = [[NSMutableArray alloc]init];
    worryEmailArray = [[NSMutableArray alloc]init];
    worryDict = [[NSMutableDictionary alloc]init];
    famtitl2 = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
    famtitl = [famtitl2 allKeys];
    for (int i = 0; i<famtitl.count; i++) {
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:famtitl[i]];
        worryDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
        NSArray *keysArr = [worryDict allKeys];
        for (int i = 0; i<keysArr.count; i++) {
            NSDictionary *tempDict = [worryDict objectForKey:keysArr[i]];
            NSString *type = [tempDict valueForKey:@"contacttype"];
                if ([type isEqualToString:@"1"]) {
                    [worryArray addObject:tempDict];
                    [worryEmailArray addObject:[tempDict valueForKey:@"email"]];
            }
        }
    }
    if (worryEmailArray.count == 0) {
        [LeafNotification showInController:self withText:@"どうぞ足を付ける送り人"];
    }
    [_healthSlider setMinimumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    [_healthSlider setMaximumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    [_spiritSlider setMinimumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    [_spiritSlider setMaximumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    [_happinessSlider setMinimumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    [_happinessSlider setMaximumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
//    [_healthSlider setThumbTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
}

-(void)getEmaill{
    NSLog(@"Btn is pressed");
    if (worryEmailArray.count == 0) {
        [LeafNotification showInController:self withText:@"どうぞ足を付ける送り人"];
    }else{
    if ([self.state1.text isEqualToString: @"とても良い"]&&[self.state2.text isEqualToString: @"とても良い"]&&[self.state3.text isEqualToString: @"とても幸せ"]) {
        [LeafNotification showInController:self withText:@"体の状況を選択してください" type:LeafNotificationTypeSuccess];
    }else{
    [LeafNotification showInController:self withText:@"送信している" type:LeafNotificationTypeSuccess];
    [self sendEmail:YES];
    }
    }
}

-(IBAction)updateValue:(id)sender{
    float f = _healthSlider.value; //读取滑块的值
    [_healthSlider setMinimumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:(f-f/255.0)/255.0 blue:1.0/255.0 alpha:1]];
    [_healthSlider setMaximumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:(f-f/255.0)/255.0 blue:1.0/255.0 alpha:1]];
    
    if ((_healthSlider.value>225)) {
        self.state1.text = @"とても良い";
    }else if((_healthSlider.value<225)&&(_healthSlider.value>115)){
        self.state1.text = @"元気がない";
    }else if((_healthSlider.value<115)&&(_healthSlider.value>50)){
        self.state1.text = @"病気です";
    }else if((_healthSlider.value<50)){
        self.state1.text = @"深刻な病気";
    }
}
- (IBAction)updateValue2:(id)sender {
    float f = _spiritSlider.value; //读取滑块的值
    [_spiritSlider setMinimumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:f/255.0 blue:1.0/255.0 alpha:1]];
    [_spiritSlider setMaximumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:f/255.0 blue:1.0/255.0 alpha:1]];

    if ((_spiritSlider.value>225)) {
        self.state2.text = @"とても良い";
    }else if((_spiritSlider.value<225)&&(_spiritSlider.value>115)){
        self.state2.text = @"良い";
    }else if((_spiritSlider.value<225)&&(_spiritSlider.value>50)){
        self.state2.text = @"よくない";
    }else if((_spiritSlider.value<50)){
        self.state2.text = @"非常に悪い";
    }
}
- (IBAction)updateValue23:(id)sender {
    float f = _happinessSlider.value; //读取滑块的值
    [_happinessSlider setMinimumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:f/255.0 blue:1.0/255.0 alpha:1]];
    [_happinessSlider setMaximumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:f/255.0 blue:1.0/255.0 alpha:1]];

    if ((_happinessSlider.value>225)) {
        self.state3.text = @"とても幸せ";
    }else if((_happinessSlider.value<225)&&(_happinessSlider.value>115)){
        self.state3.text = @"幸せ";
    }else if((_happinessSlider.value<225)&&(_happinessSlider.value>50)){
        self.state3.text = @"幸せではない";
    }else if((_happinessSlider.value<50)){
        self.state3.text = @"切なくて";
    }
}


-(void)viewWillAppear:(BOOL)animated{
    if (worryEmailArray) {
        [worryEmailArray removeAllObjects];
    }
    [self getEmail];
    [self viewDidLoad];
    [_contactListTableView reloadData];
}
-(void)getEmail{
    //get email address who will send email
    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
    userEmail1 = [temp valueForKey:@"email"];
    password1 = [temp valueForKey:@"password"];
    hostname1 = [temp valueForKey:@"hostname"];
    port1 = [[temp valueForKey:@"severport"]intValue];
    //check email setting
    if (userEmail1 ==nil ||[userEmail1 isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
    if (password1 ==nil ||[password1 isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
    if (hostname1 ==nil ||[hostname1 isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
    if (!port1) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
}

-(void)sendEmail:(BOOL)emergency{
    MCOSMTPSession *session = [[MCOSMTPSession alloc]init];
    [session setHostname:hostname1];
    [session setPort:port1];
    [session setUsername:userEmail1];
    [session setPassword:password1];
    [session setConnectionType:MCOConnectionTypeTLS];
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc]init];
    [[builder header]setFrom:[MCOAddress addressWithDisplayName:nil mailbox:userEmail1]];
    //设置收件人
    NSMutableArray *to = [[NSMutableArray alloc]init];
    if (emergency == YES) {
        for (NSString *toAddress in worryEmailArray) {
            MCOAddress *newAddress = [MCOAddress addressWithMailbox:toAddress];
            [to addObject:newAddress];
        }
    }
    [[builder header]setTo:to];
    
    //设置邮件标题
    [[builder header]setSubject:@"家族不安通知"];
    //设置邮件正文
    [builder setTextBody:[NSString stringWithFormat:@"今の私には%@,精神は%@,%@",self.state1.text,self.state2.text,self.state3.text]];
    NSLog(@"%@",[NSString stringWithFormat:@"今の私には%@,精神は%@,%@",self.state1.text,self.state2.text,self.state3.text]);
    //发送构建好的邮件体
    NSData *rfc822Data=[builder data];
    MCOSMTPSendOperation *sendOperation = [session sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError * _Nullable error) {
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

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return worryArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"worrycell";
    cell = [_contactListTableView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *temp = [worryArray objectAtIndex:indexPath.row];
    cell.wname.text = [temp valueForKey:@"name"];
    cell.wmail.text = [temp valueForKey:@"email"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
