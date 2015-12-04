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

@interface EmergencyViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    NSMutableDictionary *_contactDict;
    NSMutableArray *_currentArray;
}
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_currentArray) {
        _currentArray = [[NSMutableArray alloc]init];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContact];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)reloadContact{
    [_currentArray removeAllObjects];
    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contact"];
    if (!tempdict) {
        [LeafNotification showInController:self withText:@"連絡人を追加してみてください"];
        return;
    }
    _contactDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
    NSArray *keysArr = [tempdict allKeys];
    //Models
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *dict = [tempdict objectForKey:keysArr[i]];
        ContactModel *model = [[ContactModel alloc]init];
        model.emergencyType = [dict valueForKey:@"emergencytype"];
        model.name = [dict valueForKey:@"name"];
        model.email = [dict valueForKey:@"email"];
        if ([model.emergencyType intValue] == 1) {
            [_currentArray addObject:model];
        }
        NSLog(@"%@",model.name);
        
    }
    [_tableview reloadData];
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

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
