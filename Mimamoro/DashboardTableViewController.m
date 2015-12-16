//
//  DashboardTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/15.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "DashboardTableViewController.h"
#import "DashBoardTableViewCell.h"

@interface DashboardTableViewController (){
    int xNum;//0:1~24時 1:1~7日 2:１〜３０日 　3:１〜１２月
    NSArray *dayarray;
    NSArray *weekarray;
    NSArray *montharray;
    NSArray *yeararray;
    NSArray *dayarray2;
    NSArray *weekarray2;
    NSArray *montharray2;
    NSArray *yeararray2;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation DashboardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DashBoardTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardCell"];
    xNum = 0;
    //Get test data from plist files
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self getPlistWithName:@"testdata1"];
    [self getPlistWithName:@"testdata2"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)getPlistWithName:(NSString*)name{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:name ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    if ([name isEqualToString:@"testdata1"]) {
        dayarray =[[NSArray alloc]initWithArray:[dict objectForKey:@"day"]];
        weekarray = [[NSArray alloc]initWithArray:[dict objectForKey:@"week"]];
        montharray = [[NSArray alloc]initWithArray:[dict objectForKey:@"month"]];
        yeararray = [[NSArray alloc]initWithArray:[dict objectForKey:@"year"]];
    }else if([name isEqualToString:@"testdata2"]){
        dayarray2=[[NSArray alloc]initWithArray:[dict objectForKey:@"day"]];
        weekarray2 = [[NSArray alloc]initWithArray:[dict objectForKey:@"week"]];
        montharray2 = [[NSArray alloc]initWithArray:[dict objectForKey:@"month"]];
        yeararray2 = [[NSArray alloc]initWithArray:[dict objectForKey:@"year"]];
        NSLog(@"dayarr->%@",dayarray2);
    }

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DashBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dashboardCell"];
    if (cell ==nil) {
        [[[NSBundle mainBundle]loadNibNamed:@"DashBoardTableViewCell" owner:nil options:nil]firstObject];
    }
    if (indexPath.section == 0) {
        [cell configUI:indexPath type:1 unit:xNum day:dayarray week:weekarray month:montharray year:yeararray];
    }else if (indexPath.section == 1){
        [cell configUI:indexPath type:2 unit:xNum day:dayarray2 week:weekarray2 month:montharray2 year:yeararray2];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    label.text = section ?@"ベッド":@"電気使用量";
    label.textColor = [UIColor colorWithRed:0.257 green:0.650 blue:0.478 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


-(void)segmentAction:(UISegmentedControl*)seg{
    if (seg.selectedSegmentIndex == 0){
        xNum = 0;
        [self.tableView reloadData];
    }else if(seg.selectedSegmentIndex == 1){
        xNum = 1;
        [self.tableView reloadData];
    }else if(seg.selectedSegmentIndex == 2){
        xNum = 2;
        [self.tableView reloadData];
    }else if(seg.selectedSegmentIndex == 3){
        xNum = 3;
        [self.tableView reloadData];
    }
}


@end
