//
//  EmergencyViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EmergencyViewController.h"
#import "EmergencyCollectionViewCell.h"
#import "LeafNotification.h"
#import "ABFillButton.h"
#import <MailCore/MailCore.h>
@interface EmergencyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ABFillButtonDelegate,UITextViewDelegate>
{
    EmergencyCollectionViewCell *cell;
    NSMutableDictionary *EmergencyDict;
    NSMutableArray *EmergencyArray;
    NSArray *famtitl;
    NSDictionary *famtitl2;
    NSMutableArray *EmergencyEmailArray;
    
    NSString *userEmail;
    NSString *password;
    NSString *hostname;
    int port;
    int buttonid;
}
@property (weak, nonatomic) IBOutlet UICollectionView *contactListTableView2;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet ABFillButton *emergencyBtn;
@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _emergencyBtn.delegate = self;
    _messageTextView.delegate = self;
    _messageTextView.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"messageTextView"];
    _contactListTableView2.layer.cornerRadius = 10;
    _messageTextView.layer.cornerRadius = 10;
    [_emergencyBtn setFillPercent:1.0];
    [_emergencyBtn configureButtonWithHightlightedShadowAndZoom:YES];
    [_emergencyBtn setEmptyButtonPressing:YES];
    _contactListTableView2.delegate = self;
    _contactListTableView2.dataSource = self;
    
    
    famtitl = [[NSArray alloc]init];
    EmergencyArray = [[NSMutableArray alloc]init];
    EmergencyEmailArray = [[NSMutableArray alloc]init];
    EmergencyDict = [[NSMutableDictionary alloc]init];
    
    
    famtitl2 = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
    famtitl = [famtitl2 allKeys];
    for (int i = 0; i<famtitl.count; i++) {
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:famtitl[i]];
        EmergencyDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
        NSArray *keysArr = [EmergencyDict allKeys];
        for (int i = 0; i<keysArr.count; i++){
            NSDictionary *tempDict = [EmergencyDict objectForKey:keysArr[i]];
            NSLog(@"%@",tempDict);
            NSString *type = [tempDict valueForKey:@"emergencytype"];
            if ([type isEqualToString:@"1"]) {
                [EmergencyArray addObject:tempDict];
                [EmergencyEmailArray addObject:[tempDict valueForKey:@"email"]];
            }
        }
    }
    
    NSLog(@"EmergencyEmailArray%@",EmergencyEmailArray);
    
    
    if (EmergencyEmailArray.count == 0) {
        [LeafNotification showInController:self withText:@"どうぞ足を付ける送り人"];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    [super viewWillAppear:YES];
    if (EmergencyEmailArray) {
        [EmergencyEmailArray removeAllObjects];
    }
    [self getEmail];
    [self viewDidLoad];
    //NSLog(@"%@",EmergencyEmailArray);
    [_contactListTableView2 reloadData];
}
-(void)getEmail{
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
}

-(void)sendEmail:(BOOL)emergency{
    MCOSMTPSession *session = [[MCOSMTPSession alloc]init];
    [session setHostname:hostname];
    [session setPort:port];
    [session setUsername:userEmail];
    [session setPassword:password];
    [session setConnectionType:MCOConnectionTypeTLS];
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc]init];
    [[builder header]setFrom:[MCOAddress addressWithDisplayName:nil mailbox:userEmail]];
    //设置收件人
    NSMutableArray *to = [[NSMutableArray alloc]init];
    if (emergency == YES) {
        for (NSString *toAddress in EmergencyEmailArray) {
            MCOAddress *newAddress = [MCOAddress addressWithMailbox:toAddress];
            [to addObject:newAddress];
        }
    }
    [[builder header]setTo:to];
    
    //设置邮件标题
    [[builder header]setSubject:@"家族の緊急通知"];
    //设置邮件正文
    [builder setTextBody:self.messageTextView.text];
    
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
    return EmergencyArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"emergencycell";
    cell = [_contactListTableView2 dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *temp = [EmergencyArray objectAtIndex:indexPath.row];
    cell.ename.text = [temp valueForKey:@"name"];
    cell.email.text = [temp valueForKey:@"email"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//When mergency button was pushed
- (IBAction)emergencyAction:(id)sender {
    buttonid = 0;
    [_emergencyBtn setFillPercent:1.0];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [[NSUserDefaults standardUserDefaults]setObject:_messageTextView.text forKey:@"messageTextView"];
        NSLog(@"保存OK");
        return NO;
    }
    [[NSUserDefaults standardUserDefaults]setObject:_messageTextView.text forKey:@"messageTextView"];
    NSLog(@"保存OK");
    return YES;
}


//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    if (keyboardRect.size.height<217) {
    
    _messageTextView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
    NSLog(@"%f",keyboardRect.size.height);
        }
}

- (void)handleKeyboardDidHidden
{
    _messageTextView.contentInset=UIEdgeInsetsZero;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)buttonIsEmpty:(ABFillButton *)button{
    NSLog(@"Btn is pressed");
    if (buttonid == 0) {
        if (EmergencyEmailArray.count == 0) {
            [LeafNotification showInController:self withText:@"どうぞ足を付ける送り人"];
        }else{
        if(![self.messageTextView.text isEqualToString: @""]){
            [LeafNotification showInController:self withText:@"送信している" type:LeafNotificationTypeSuccess];
            [self sendEmail:YES];
        }else if([self.messageTextView.text isEqualToString: @""]){
            [LeafNotification showInController:self withText:@"情報発信を記入してください" type:LeafNotificationTypeSuccess];
        }
        }
        [_emergencyBtn setFillPercent:1.0];
    }
}
@end
