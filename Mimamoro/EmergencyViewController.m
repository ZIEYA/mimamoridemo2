//
//  EmergencyViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EmergencyViewController.h"
#import "ContactModel.h"
#import "LeafNotification.h"
#import "ABFillButton.h"
#import <MailCore/MailCore.h>
#import "AppDelegate.h"

@interface EmergencyViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,ABFillButtonDelegate>{
    NSMutableArray *_contactArr;
    NSMutableArray *_currentArray;
    NSString *userEmail;
    NSString *password;
    NSString *hostname;
    int port;
    NSString *message;
    NSString *latitude;
    NSString *longitude;
}
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet ABFillButton *button;

@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button.delegate = self;
    [_button setFillPercent:1.0];
    [_button configureButtonWithHightlightedShadowAndZoom:YES];
    [_button setEmptyButtonPressing:YES];
    if (!_currentArray) {
        _currentArray = [[NSMutableArray alloc]init];
    }
    NSString *tmp = [[NSUserDefaults standardUserDefaults]valueForKey:@"message1"];
    if (tmp) {
        message = [[NSUserDefaults standardUserDefaults]valueForKey:@"message1"];
        _messageTextView.text = message;
    };
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContact];
    [self settingEmail];
}

-(void)viewWillDisappear:(BOOL)animated{
     message = _messageTextView.text;
    [[NSUserDefaults standardUserDefaults]setValue:message forKey:@"message1"];
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
    //Models
    for (int i = 0; i<_contactArr.count; i++) {
        NSDictionary *dict = [_contactArr objectAtIndex:i];
        ContactModel *model = [[ContactModel alloc]init];
        model.emergencyType = [dict valueForKey:@"emergencytype"];
        model.name = [dict valueForKey:@"name"];
        model.email = [dict valueForKey:@"email"];
        if ([model.emergencyType intValue] == 1) {
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
    NSLog(@"useremail:%@ password:%@ hostname:%@ port:%d",userEmail,password,hostname,port);
}

-(void)sendEmail:(NSString*)mes{
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
    [[builder header]setSubject:@"!!「見守りアプリ」の緊急通報メールです"];
    //メールの本体
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.loco.yahoo.co.jp/maps?lat=%@&%@&ei=utf-8&v=2&sc=3&datum=wgs&gov=13108.30#",latitude,longitude];
    [builder setTextBody:[NSString stringWithFormat:@"▼メッセージ:\n \n　　%@ \n \n▼送信者の位置情報はこちらで確認できる⇨\n　%@\n\n *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.\n◎＜見守りアプリ＞で緊急ボタンが押されてメール送信しました。\n \n＊このメールには返信しないでください。\n\n＊このメールに覚えがない場合は、お手数ですが削除してください。",mes,urlStr]];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"procell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"procell"];
    }
    ContactModel *contactmodel = [_currentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : ",contactmodel.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"    %@",contactmodel.email];
    return cell;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    message = _messageTextView.text;
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return  YES;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)btnAction:(id)sender {
    [_button setFillPercent:1.0];
}

-(void)buttonIsEmpty:(ABFillButton *)button{
    NSLog(@"button is pressedd");
    [self sendEmail:message];
}

@end
