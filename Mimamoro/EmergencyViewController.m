//
//  EmergencyViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EmergencyViewController.h"
#import <MailCore/MailCore.h>
#import "LeafNotification.h"

@interface EmergencyViewController ()
{
    NSString *userEmail;
    NSString *password;
    NSString *hostname;
    int port;

}
@property (strong, nonatomic) UITableView *contactListTableView;
@property (strong, nonatomic) UITextView *messageTextView;
//@property (strong, nonatomic) UIButton *emergencybtn;
@property (strong, nonatomic) UILabel *emyLabel;

@property (strong, nonatomic) NSMutableArray *contactArr;

@property (strong, nonatomic)ABFillButton *emergencybtn;
@end

@implementation EmergencyViewController
@synthesize contactArr;
- (void)viewDidLoad {
    [super viewDidLoad];

    //设置数组数据
    if (!contactArr) {
        contactArr = [[NSMutableArray alloc]init];
    }
    NSString*message = [[NSUserDefaults standardUserDefaults]objectForKey:@"message"];
    if (message) {
        self.messageTextView.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"message"];
    }
    self.messageTextView.text=@"紧急！！";
    //设置控件
    //label
    self.emyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.14, self.view.bounds.size.width*0.4, self.view.bounds.size.width*0.1)];
    self.emyLabel.text = @"ながおしっ!";
    //self.emyLabel.text = @"送信完了！！";
    self.emyLabel.textAlignment = NSTextAlignmentCenter;
    //self.emyLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.emyLabel];
    //button
    UIImage *emyimg = [UIImage imageNamed:@"emergencybtn.png"];
    self.emergencybtn = [[ABFillButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.2, self.view.bounds.size.width*0.4, self.view.bounds.size.width*0.4)];
    [self.emergencybtn addTarget:self action:@selector(time:) forControlEvents:UIControlEventTouchUpInside];
    [self.emergencybtn setImage:emyimg forState:UIControlStateNormal];
    [self.view addSubview:self.emergencybtn];
    self.emergencybtn.delegate =self;
    [self.emergencybtn setFillPercent:1.0];
    [self.emergencybtn configureButtonWithHightlightedShadowAndZoom:YES];
    [self.emergencybtn setEmptyButtonPressing:YES];
    //title
    UILabel *message1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.42, self.view.bounds.size.width*0.3, self.view.bounds.size.width*0.1)];
    message1.text = @"•通知先";
    [self.view addSubview:message1];
    
    self.contactListTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.48, self.view.bounds.size.width*0.9, self.view.bounds.size.width*0.3)];
    //self.contactListTableView.backgroundColor = [UIColor redColor];
    self.contactListTableView.dataSource =self;
    [self.view addSubview:self.contactListTableView];
    
    UILabel *message2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.65, self.view.bounds.size.width*0.3, self.view.bounds.size.width*0.1)];
    message2.text = @"•メッセージ";
    [self.view addSubview:message2];
    
    self.messageTextView = [[UITextView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.70, self.view.bounds.size.width*0.9, self.view.bounds.size.width*0.3)];
   // self.messageTextView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.messageTextView];
    
    
    self.contactListTableView.dataSource = self;
    //uitextview delegate
    self.messageTextView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setData];
    [self.contactListTableView reloadData];
}

#pragma mark - button动画事件
-(void)time:(id)sender
{
    [self.emergencybtn setFillPercent:1.0];
}
- (void) buttonIsEmpty: (ABFillButton *)button;
{
    NSLog(@"button is pressed");
    [self emergencyAction];
}

-(void)setData{
    //get email address who will send email
    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
    userEmail = [temp valueForKey:@"email"];
    password = [temp valueForKey:@"password"];
    hostname = [temp valueForKey:@"hostname"];
    port = [[temp valueForKey:@"severport"]intValue];
    //check email setting
    if (userEmail ==nil ||[userEmail isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
    if (password ==nil ||[password isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
    if (hostname ==nil ||[hostname isEqualToString:@""]) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
    if (!port) {
        [LeafNotification showInController:self withText:@"メール設定してください"];
        return;
    }
    
    //get email address who send to
    //配置邮箱参数
    NSDictionary *user = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
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
    
    //设置接受人邮箱
    NSDictionary *tempdict =[[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
    NSLog(@"dic is:%@",tempdict);
    NSArray *temparr = [tempdict allKeys];
    self.contactArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<temparr.count; i++) {
        NSDictionary *tempd = [[NSUserDefaults standardUserDefaults]objectForKey:temparr[i]];;
        NSLog(@"tempd:%@",tempd);
        NSArray *groupArr = [tempd allKeys];
        for (int j = 0; j<groupArr.count; j++) {
            NSDictionary *groupInside = [tempd objectForKey:groupArr[j]];
            NSLog(@"groupInside:%@",groupInside);
            NSString *type = [groupInside valueForKey:@"emergencytype"];
            NSString *name = [groupInside valueForKey:@"name"];
            NSString *email = [groupInside valueForKey:@"email"];
            NSMutableDictionary *tocontact = [[NSMutableDictionary alloc]init];
            [tocontact setValue:name forKey:@"toname"];
            [tocontact setValue:email forKey:@"toemail"];
            if ([type isEqualToString:@"1"]) {
                [self.contactArr addObject:tocontact];
            }
        }
    }
    
    self.emyLabel.text = @"ながおしっ!";
}


#pragma mark - uitextview delegate(避免键盘覆盖textview)
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSUserDefaults *messageSet = [NSUserDefaults standardUserDefaults];
    [messageSet removeObjectForKey:@"message"];
    [messageSet setObject:self.messageTextView.text forKey:@"message"];
    [messageSet synchronize];
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    CGRect frame = textView.frame;
    int offset = frame.origin.y +180 - (self.view.frame.size.height - 216);
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"RessizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if (offset >0) {
        self.view.frame =CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - emergrncy button

-(void)emergencyAction{
    NSLog(@"chick me !");
    MCOSMTPSession *session = [[MCOSMTPSession alloc]init];
    session.username = userEmail;
    session.password = password;
    session.hostname = hostname;
    session.port = port;
    session.connectionType = MCOConnectionTypeTLS;
    //构建邮件头
    MCOMessageBuilder *build = [[MCOMessageBuilder alloc]init];
    //设置邮件头
    [[build header]setFrom:[MCOAddress addressWithDisplayName:nil mailbox:userEmail]];
    NSMutableArray *to = [[NSMutableArray alloc]init];
    for (int i = 0; i<contactArr.count; i++) {
        NSDictionary *toemailDic = [contactArr objectAtIndex:i];
        MCOAddress *toAddress = [MCOAddress addressWithDisplayName:nil mailbox:[toemailDic valueForKey:@"toemail"]];
        [to addObject:toAddress];
    }
    [[build header]setTo:to];//who is send to
    //设置邮件标题
    [[build header]setSubject:@"緊急通報メールです"];
    //设置邮件正文
    NSString *messageSend = self.messageTextView.text;
    [build setTextBody:messageSend];
    //发送构建好的邮件体
    NSData *sendData = [build data];
    MCOSMTPOperation *sendOpertion = [session sendOperationWithData:sendData];
    [sendOpertion start:^(NSError *_Nullable error) {
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
            self.emyLabel.text = @"送信完了！！";
        }
    }];
    
}

#pragma mark - tableview datedource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.contactArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    }
    //cell.accessoryType = UITableViewCellStyleValue1;
    NSDictionary *cellname = contactArr[indexPath.row];
    cell.textLabel.text = [cellname valueForKey:@"toname"];
    cell.detailTextLabel.text = [cellname valueForKey:@"toemail"];
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
