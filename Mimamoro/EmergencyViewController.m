//
//  EmergencyViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EmergencyViewController.h"
#import <MailCore/MailCore.h>
@interface EmergencyViewController ()
{
    NSString *userEmail;
    NSString *password;
    NSString *hostname;
    int port;
    int buttonid;
    BOOL isSoftbank;
    BOOL isEzweb;
    BOOL isGmail;
    BOOL isDocomo;
    BOOL is163;
}
@property (strong, nonatomic) UITableView *contactListTableView;
@property (strong, nonatomic) UITextView *messageTextView;
@property (strong, nonatomic) UIButton *emergencybtn;
@property (strong, nonatomic) UILabel *emyLabel;

@property (strong, nonatomic) NSArray *contactArr;
@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //设置数组数据
    self.contactArr = @[@"one",@"two",@"three"];
    //设置控件
    //label
    self.emyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.14, self.view.bounds.size.width*0.4, self.view.bounds.size.width*0.1)];
    self.emyLabel.text = @"ながおしっ!";
    //self.emyLabel.text = @"送信完了！！";
    self.emyLabel.textAlignment = NSTextAlignmentCenter;
    self.emyLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.emyLabel];
    //button
    UIImage *emyimg = [UIImage imageNamed:@"emergencybtn.png"];
    self.emergencybtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.2, self.view.bounds.size.width*0.4, self.view.bounds.size.width*0.4)];
    [self.emergencybtn addTarget:self action:@selector(emergencyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.emergencybtn setImage:emyimg forState:UIControlStateNormal];
    [self.view addSubview:self.emergencybtn];
    
    //title
    UILabel *message1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.42, self.view.bounds.size.width*0.3, self.view.bounds.size.width*0.1)];
    message1.text = @"•通知先";
    [self.view addSubview:message1];
    
    self.contactListTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.48, self.view.bounds.size.width*0.9, self.view.bounds.size.width*0.3)];
    self.contactListTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.contactListTableView];
    
    UILabel *message2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.65, self.view.bounds.size.width*0.3, self.view.bounds.size.width*0.1)];
    message2.text = @"•メッセージ";
    [self.view addSubview:message2];
    
    self.messageTextView = [[UITextView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.05, self.view.bounds.size.height*0.70, self.view.bounds.size.width*0.9, self.view.bounds.size.width*0.3)];
    self.messageTextView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.messageTextView];
    
    
    self.contactListTableView.dataSource = self;
    //uitextview delegate
    self.messageTextView.delegate = self;
}
-(void)setEmailClass:(NSString*)email{
    NSRange range = [email rangeOfString:@"ezweb.ne.jp"];
    if (range.location == NSNotFound) {
        NSLog(@"is not ezweb");
    }else{
        NSLog(@"is ezweb");
        isEzweb = YES;
        return;
    }

    range = [email rangeOfString:@"docomo.ne.jp"];
    if (range.location == NSNotFound) {
        NSLog(@"is not docomo");
    }else{
        NSLog(@"is docomo");
        isDocomo = YES;
        return;
    }

    range = [email rangeOfString:@"gmail.com"];
    if (range.location == NSNotFound) {
        NSLog(@"is not gmail");
    }else{
        NSLog(@"is gmail");
        isGmail = YES;
        return;
    }

    range = [email rangeOfString:@"i.softbank.jp"];
    if (range.location == NSNotFound) {
        NSLog(@"is not softbank");
    }else{
        NSLog(@"is softbank");
        isSoftbank = YES;
        return;
    }

    //user 163.com test email
    range = [email rangeOfString:@"163.com"];
    if (range.location == NSNotFound) {
        NSLog(@"is not 163");
    }else{
        NSLog(@"is 163");
        is163 = YES;
        return;
    }

}
-(void)setHostNamePort{
    if (isEzweb == YES) {
        hostname = @"smtp.ezweb.co.jp";
        port = 587;
        return;
    }else if (isSoftbank == YES){
        hostname = @"smtp.softbank.jp";
        port = 587;
        return;
    }else if (isDocomo == YES){
        hostname = @"smtp.spmode.ne.jp";
        port = 587;
        return;
    }else if (isGmail == YES){
        hostname = @"smtp.gmail.com";
        port = 587;
        return;
    }else if(is163 == YES){
        hostname = @"smtp.163.com";
        port = 465;
    }
    NSLog(@"%@",hostname);
}
//-(void)getEmail{
//    //get email address who will send email
//    NSDictionary *temp = [[NSUserDefaults standardUserDefaults]objectForKey:@"userprofile"];
//    userEmail = [temp valueForKey:@"email"];
//    password = [temp valueForKey:@"password"];
//    hostname = [temp valueForKey:@"hostname"];
//    port = [[temp valueForKey:@"severport"]intValue];
//    //check email setting
//    if (userEmail ==nil ||[userEmail isEqualToString:@""]) {
//        [LeafNotification showInController:self withText:@"メール設定してください"];
//        return;
//    }
//    if (password ==nil ||[password isEqualToString:@""]) {
//        [LeafNotification showInController:self withText:@"メール設定してください"];
//        return;
//    }
//    if (hostname ==nil ||[hostname isEqualToString:@""]) {
//        [LeafNotification showInController:self withText:@"メール設定してください"];
//        return;
//    }
//    if (!port) {
//        [LeafNotification showInController:self withText:@"メール設定してください"];
//        return;
//    }

    //get email address who send to
//    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contactlist"];
//    NSArray *temparr = [tempdict allKeys];
//    for (int i = 0; i<temparr.count; i++) {
//        NSDictionary *tempd = [tempdict objectForKey:temparr[i]];
//        NSString *type = [tempd valueForKey:@"contacttype"];
//        if ([type isEqualToString:@"0"]) {
//            [familyContactArray addObject:[tempd valueForKey:@"email"]];
//        }else if ([type isEqualToString:@"1"]){
//            [otherContactArray addObject:[tempd valueForKey:@"email"]];
//        }
//    }
//    
//}
//-(void)sendEmail:(BOOL)emergency{
//    MCOSMTPSession *session = [[MCOSMTPSession alloc]init];
//    [session setHostname:hostname];
//    [session setPort:port];
//    [session setUsername:userEmail];
//    [session setPassword:password];
//    [session setConnectionType:MCOConnectionTypeTLS];
//
//    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc]init];
//    [[builder header]setFrom:[MCOAddress addressWithDisplayName:nil mailbox:userEmail]];
//    //设置收件人
//    NSMutableArray *to = [[NSMutableArray alloc]init];
//    if (emergency == YES) {
//        for (NSString *toAddress in otherContactArray) {
//            MCOAddress *newAddress = [MCOAddress addressWithMailbox:toAddress];
//            [to addObject:newAddress];
//        }
//    }else if (emergency == NO){
//        for (NSString *toAddress in familyContactArray) {
//            MCOAddress *newAddress = [MCOAddress addressWithMailbox:toAddress];
//            [to addObject:newAddress];
//        }
//    }
//    [[builder header]setTo:to];
//
//    //设置邮件标题
//    [[builder header]setSubject:@"This is a test email from Mimamori Application"];
//    //设置邮件正文
//    [builder setTextBody:@"test email from Mimamori"];
//
//    //发送构建好的邮件体
//    NSData *rfc822Data=[builder data];
//    MCOSMTPSendOperation *sendOperation = [session sendOperationWithData:rfc822Data];
//    [sendOperation start:^(NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error sending email:%@",error);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [LeafNotification showInController:self withText:@"メール送信が失敗しました！"];
//            });
//        }else{
//            NSLog(@"Successfully send email!");
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //[LeafNotification showInController:self withText:@"メール送信が成功しました！"];
//                [LeafNotification showInController:self withText:@"メール送信が成功しました！" type:LeafNotificationTypeSuccess];
//            });
//
//        }
//    }];
//
//}





#pragma mark - uitextview delegate(避免键盘覆盖textview)
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
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
    //配置邮箱参数
    MCOSMTPSession *session = [[MCOSMTPSession alloc]init];
    session.username = @"email";
    session.password = @"password";
    session.hostname = @"smtp.qq.com";
    session.port = 465;
    session.connectionType = MCOConnectionTypeTLS;
    //构建邮件头
    MCOMessageBuilder *build = [[MCOMessageBuilder alloc]init];
    //设置邮件头
    [[build header]setFrom:[MCOAddress addressWithDisplayName:nil mailbox:@"email"]];
    //设置接受人
    NSMutableArray *to = [[NSMutableArray alloc]init];
    
    //数据
    
    [[build header]setTo:to];
    //设置邮件标题
    [[build header]setSubject:@"This is a test email "];
    //设置邮件正文
    
    //数据

    [build setTextBody:@"zhengwen"];
    //发送构建好的邮件体
    NSData *sendData = [build data];
    MCOSMTPOperation *sendOpertion = [session sendOperationWithData:sendData];
    [sendOpertion start:^(NSError * _Nullable error) {
        if (error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [NSNotification showInController:self withText:@"メール送信が失敗しました！"];
       
    }else{
        
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.textLabel.text = self.contactArr[indexPath.row];
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
