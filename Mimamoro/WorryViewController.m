//
//  WorryViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "WorryViewController.h"
#import "worryTableViewCell.h"
@interface WorryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    worryTableViewCell *cell;
    NSMutableDictionary *worryDict;
    NSMutableArray *worryArray;
    NSArray *famtitl;
    NSDictionary *famtitl2;
}
@property (weak, nonatomic) IBOutlet UITableView *contactListTableView;
@property (strong, nonatomic) IBOutlet UISlider *healthSlider;
@property (strong, nonatomic) IBOutlet UISlider *spiritSlider;
@property (strong, nonatomic) IBOutlet UISlider *happinessSlider;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtai;

@end

@implementation WorryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contactListTableView.delegate = self;
    _contactListTableView.dataSource = self;
    //_healthSlider = [[UISlider alloc]init];
    _healthSlider.minimumValue = 0.0;
    _healthSlider.maximumValue = 255.0;
    _healthSlider.value = 255.0;
    //_zhuangtai.text = 255.0;
    [_healthSlider setMinimumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    [_healthSlider setMaximumTrackTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    [_healthSlider setThumbTintColor:[UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1]];
    famtitl = [[NSArray alloc]init];
    worryArray = [[NSMutableArray alloc]init];
    worryDict = [[NSMutableDictionary alloc]init];
    famtitl2 = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
    famtitl = [famtitl2 allKeys];
    for (int i = 0; i<famtitl.count; i++) {
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:famtitl[i]];
        worryDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
        NSArray *keysArr = [worryDict allKeys];
        for (int i = 0; i<keysArr.count; i++) {
            NSDictionary *tempDict = [worryDict objectForKey:keysArr[i]];
            NSString *type = [tempDict valueForKey:@"contacttype"];
                if ([type isEqualToString:@"1"]) {
                    [worryArray addObject:tempDict];
            }
        }
    }
}
-(IBAction)updateValue:(id)sender{
    float f = _healthSlider.value; //读取滑块的值
    [_healthSlider setMinimumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:f/255.0 blue:1.0/255.0 alpha:1]];
    [_healthSlider setMaximumTrackTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:f/255.0 blue:1.0/255.0 alpha:1]];
    [_healthSlider setThumbTintColor:[UIColor colorWithRed:(255.0-f)/255.0 green:f/255.0 blue:1.0/255.0 alpha:1]];
    NSLog(@"%f",f);
    self.zhuangtai.text = [NSString stringWithFormat:@"%0.f",f];
    
}
- (IBAction)updateValue2:(id)sender {
}
- (IBAction)updateValue23:(id)sender {
}



-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
    [_contactListTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return worryArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"worrycell" forIndexPath:indexPath];
    if (cell == nil) {
        cell =  (worryTableViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"worryTableViewCell" owner:self options:nil] lastObject];
    }
    NSDictionary *temp = [worryArray objectAtIndex:indexPath.row];
    cell.wname.text = [temp valueForKey:@"name"];
    cell.wmail.text = [temp valueForKey:@"email"];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
