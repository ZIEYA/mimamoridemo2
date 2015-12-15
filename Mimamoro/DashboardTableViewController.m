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
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation DashboardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DashBoardTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardCell"];
    xNum = 0;
    //Get test data from plist files
    [self getPlistWithName:@"testdata1"];
    
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)getPlistWithName:(NSString*)name{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:name ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    dayarray =[[NSArray alloc]initWithArray:[dict objectForKey:@"day"]];
    weekarray = [[NSArray alloc]initWithArray:[dict objectForKey:@"week"]];
    montharray = [[NSArray alloc]initWithArray:[dict objectForKey:@"month"]];
    yeararray = [[NSArray alloc]initWithArray:[dict objectForKey:@"year"]];
    NSLog(@"dayarray->%@ weekarray->%@ montharray->%@ yeararray->%@",dayarray,weekarray,montharray,yeararray);
    
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
    if (indexPath.section ==0) {
        switch (xNum) {
            case 0:
                [cell configUI:indexPath type:1 unit:0 yArray:dayarray];
            case 1:
                [cell configUI:indexPath type:1 unit:1 yArray:weekarray];
            case 2:
                [cell configUI:indexPath type:1 unit:2 yArray:montharray];
            case 3:
                [cell configUI:indexPath type:1 unit:3 yArray:yeararray];
            default:
                break;
        }
    }
    else if (indexPath.section ==1) {
        switch (xNum) {
            case 0:
                [cell configUI:indexPath type:2 unit:0 yArray:dayarray];
            case 1:
                [cell configUI:indexPath type:2 unit:1 yArray:weekarray];
            case 2:
                [cell configUI:indexPath type:2 unit:2 yArray:montharray];
            case 3:
                [cell configUI:indexPath type:2 unit:3 yArray:yeararray];
            default:
                break;
        }
    }
    
    return cell;
}


-(void)segmentAction:(UISegmentedControl*)seg{
    if (seg.selectedSegmentIndex == 0){
        xNum = 0;
        NSLog(@"日");
    }else if(seg.selectedSegmentIndex == 1){
        xNum = 1;
        NSLog(@"週");
    }else if(seg.selectedSegmentIndex == 2){
        xNum = 2;
        NSLog(@"月");
    }else if(seg.selectedSegmentIndex == 3){
        xNum = 3;
        NSLog(@"年");
    }
}


@end
