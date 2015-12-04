//
//  EmergencyViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()
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
