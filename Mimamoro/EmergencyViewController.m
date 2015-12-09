//
//  EmergencyViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EmergencyViewController.h"
#import "EmergencyTableViewCell.h"
@interface EmergencyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    EmergencyTableViewCell *cell;
    NSMutableDictionary *EmergencyDict;
    NSMutableArray *EmergencyArray;
    NSArray *famtitl;
    NSDictionary *famtitl2;
}
@property (weak, nonatomic) IBOutlet UITableView *contactListTableView2;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    _contactListTableView2.delegate = self;
    _contactListTableView2.dataSource = self;
    famtitl = [[NSArray alloc]init];
    EmergencyArray = [[NSMutableArray alloc]init];
    EmergencyDict = [[NSMutableDictionary alloc]init];
    famtitl2 = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
    famtitl = [famtitl2 allKeys];
    for (int i = 0; i<famtitl.count; i++) {
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:famtitl[i]];
        EmergencyDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
        NSArray *keysArr = [EmergencyDict allKeys];
        for (int i = 0; i<keysArr.count; i++) {
            NSDictionary *tempDict = [EmergencyDict objectForKey:keysArr[i]];
            NSString *type = [tempDict valueForKey:@"emergencytype"];
            if ([type isEqualToString:@"1"]) {
                [EmergencyArray addObject:tempDict];
            }
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
    [_contactListTableView2 reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return EmergencyArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"emergencycell" forIndexPath:indexPath];
    if (cell == nil) {
        cell =  (EmergencyTableViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"EmergencyTableViewCell" owner:self options:nil] lastObject];
    }
    NSDictionary *temp = [EmergencyArray objectAtIndex:indexPath.row];
    cell.ename.text = [temp valueForKey:@"name"];
    cell.email.text = [temp valueForKey:@"email"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
