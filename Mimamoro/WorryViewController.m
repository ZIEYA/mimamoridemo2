//
//  WorryViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "WorryViewController.h"
#import "LeafNotification.h"
#import "ContactModel.h"
#import "ABFillButton.h"
#import <MailCore/MailCore.h>
#import "AppDelegate.h"

@interface WorryViewController ()<UITableViewDelegate,UITableViewDataSource,ABFillButtonDelegate>{
    NSMutableArray *_contactArr;
    NSMutableArray *_currentArray;
    NSString *_health;
    NSString *_spirit;
    NSString *_happiness;
    
    NSString *userEmail;
    NSString *password;
    NSString *hostname;
    int port;
    
    NSString *latitude;
    NSString *longitude;
}

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UISlider *healthSlider;
@property (strong, nonatomic) IBOutlet UISlider *spiritSlider;
@property (strong, nonatomic) IBOutlet UISlider *happinessSlider;
@property (strong, nonatomic) IBOutlet UILabel *sliderValue1;
@property (strong, nonatomic) IBOutlet UILabel *sliderValue2;
@property (strong, nonatomic) IBOutlet UILabel *sliderValue3;
@property (strong, nonatomic) IBOutlet ABFillButton *worryBtn;

@end

@implementation WorryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_currentArray) {
        _currentArray = [[NSMutableArray alloc]init];
    }
    _worryBtn.delegate = self;
    [_worryBtn setFillPercent:1.0];
    [_worryBtn configureButtonWithHightlightedShadowAndZoom:YES];
    [_worryBtn setEmptyButtonPressing:YES];
    //Setting default value
    _sliderValue1.text = @"大丈夫";
    _sliderValue2.text = @"大丈夫";
    _sliderValue3.text = @"大丈夫";
    _health = @"大丈夫";
    _spirit = @"大丈夫";
    _happiness = @"大丈夫";
    _healthSlider.value = 0;
    _spiritSlider.value = 0;
    _happinessSlider.value = 0;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContact];
    [self settingEmail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)reloadContact{
    [_currentArray removeAllObjects];
    NSArray *tempArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"contacts"];
    if (!tempArr) {
        [LeafNotification showInController:self withText:@"連絡人を追加してください"];
        return;
    }
    _contactArr = [[NSMutableArray alloc]initWithArray:tempArr];
    for (int i=0 ; i<_contactArr.count; i++) {
        NSDictionary *dict = [_contactArr objectAtIndex:i];
        ContactModel *model = [[ContactModel alloc]init];
        model.worryType = [dict valueForKey:@"worrytype"];
        model.name = [dict valueForKey:@"name"];
        model.email = [dict valueForKey:@"email"];
        if ([model.worryType intValue] == 1) {
            [_currentArray addObject:model];
        }
    }
    [_tableview reloadData];
    
}

-(void)settingEmail{
    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
    if (!temp) {
        [LeafNotification showInController:self withText:@"自分のメールを設定してください"];
        return;
    }
    userEmail = [temp valueForKey:@"email"];
    password = [temp valueForKey:@"password"];
    hostname = [temp valueForKey:@"hostname"];
    port = [[temp valueForKey:@"severport"]intValue];
    //check email setting
    if (userEmail ==nil ||[userEmail isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メールアドレス未設定"];
        return;
    }
    if (password ==nil ||[password isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"パスワード未設定"];
        return;
    }
    if (hostname ==nil ||[hostname isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"ホスト未設定"];
        return;
    }
    if (!port) {
        [LeafNotification showInController:self withText:@"サーバポート未設定"];
        return;
    }
    
}

-(void)sendEmail:(NSString*)value value2:(NSString*)value2 value3:(NSString*)value3{
    if (userEmail ==nil ||[userEmail isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メールアドレス未設定"];
        return;
    }
    if (password ==nil ||[password isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"パスワード未設定"];
        return;
    }
    if (hostname ==nil ||[hostname isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"ホスト未設定"];
        return;
    }
    if (!port) {
        [LeafNotification showInController:self withText:@"サーバポート未設定"];
        return;
    }
    
    //get current location
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    latitude = myDelegate.latitude;
    longitude = myDelegate.longitude;

    MCOSMTPSession *session = [[MCOSMTPSession alloc]init];
    [session setHostname:hostname];
    [session setPort:port];
    [session setUsername:userEmail];
    [session setPassword:password];
    [session setConnectionType:MCOConnectionTypeTLS];
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc]init];
    [[builder header]setFrom:[MCOAddress addressWithDisplayName:nil mailbox:userEmail]];
    //宛先
    NSMutableArray *to = [[NSMutableArray alloc]init];
    for (int i = 0; i<_currentArray.count; i++) {
        ContactModel *model = [_currentArray objectAtIndex:i];
        NSString *toAddress = model.email;
        MCOAddress *newAddress = [MCOAddress addressWithMailbox:toAddress];
        [to addObject:newAddress];
    }
    
    [[builder header]setTo:to];
    
    //メールのタイトル
    [[builder header]setSubject:@"!!「見守りアプリ」の不安通報メールです"];
    //メールの本体
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.loco.yahoo.co.jp/maps?lat=%@&%@&ei=utf-8&v=2&sc=3&datum=wgs&gov=13108.30#",latitude,longitude];
    [builder setTextBody:[NSString stringWithFormat:@"▼メッセージ:\n \n　　◎身体： %@\n　　◎精神： %@ \n　　◎幸せ： %@ \n\n▼送信者の位置情報はこちらで確認できる⇨\n　　　%@\n\n*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.\n▼見守りアプリで不安ボタンが押されてメール送信しました。\n \n＊このメールには返信しないでください。\n＊このメールに覚えがない場合は、お手数ですが削除してください。",value,value2,value3,urlStr]];
    
    //send mail
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
                [LeafNotification showInController:self withText:@"メール送信完了！！" type:LeafNotificationTypeSuccess];
            });
            
        }
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _currentArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"procell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"procell"];
    }
    ContactModel *contactmodel = [_currentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ :",contactmodel.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"    %@",contactmodel.email];
    return cell;
}
- (IBAction)healthValueChanged:(id)sender {
    int proggressAsInt = (int)(_healthSlider.value+1);
    if (proggressAsInt >=1 & proggressAsInt <=2) {
        _health = @"大丈夫";
    }else if (proggressAsInt>=3 && proggressAsInt <=4){
        _health = @"少し不安";
    }else if (proggressAsInt>=5 && proggressAsInt <=6){
        _health=@"不安";
    }else if (proggressAsInt >=7 && proggressAsInt <=8){
        _health = @"かなり不安";
    }
    _sliderValue1.text = _health;
}

- (IBAction)spiritValueChanged:(id)sender {
    int proggressAsInt = (int)(_spiritSlider.value+1);
    if (proggressAsInt >=1 & proggressAsInt <=2) {
        _spirit = @"大丈夫";
    }else if (proggressAsInt>=3 && proggressAsInt <=4){
        _spirit = @"少し不安";
    }else if (proggressAsInt>=5 && proggressAsInt <=6){
        _spirit=@"不安";
    }else if (proggressAsInt >=7 && proggressAsInt <=8){
        _spirit = @"かなり不安";
    }
    _sliderValue2.text = _spirit;
}

- (IBAction)happinessValueChanged:(id)sender {
    int proggressAsInt = (int)(_happinessSlider.value+1);
    if (proggressAsInt >=1 & proggressAsInt <=2) {
        _happiness = @"大丈夫";
    }else if (proggressAsInt>=3 && proggressAsInt <=4){
        _happiness = @"少し不安";
    }else if (proggressAsInt>=5 && proggressAsInt <=6){
        _happiness=@"不安";
    }else if (proggressAsInt >=7 && proggressAsInt <=8){
        _happiness = @"かなり不安";
    }
    _sliderValue3.text = _happiness;
}

- (IBAction)btnAction:(id)sender {
    [_worryBtn setFillPercent:1.0];
}

-(void)buttonIsEmpty:(ABFillButton *)button{
    NSLog(@"button is pressedd");
    [self sendEmail:_health value2:_spirit value3:_happiness];
}

@end
