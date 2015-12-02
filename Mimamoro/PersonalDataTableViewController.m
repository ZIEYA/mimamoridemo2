//
//  PersonalDataTableViewController.m
//  Mimamori
//
//  Created by totyu1 on 2015/11/23.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "PersonalDataTableViewController.h"
//#import "EditKusuriTtyouTableViewController.h"
#import "EditKennkoTableViewController.h"
#import "EditKusiriTableViewController.h"

@interface PersonalDataTableViewController (){
    NSInteger segmentIndex;
    NSMutableDictionary *kusuriDict;
    NSMutableDictionary *kennkoDict;
    NSMutableArray *kusuriArray;
    NSMutableArray *kennkoArray;
    int edittype; //0:追加 1:編集
    NSString *tempname;//Deliver a key(name)to edit view controller(kusuri)
    NSString *tempkey;//Deliver a key(name)to edit view controller(kennko)
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation PersonalDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect farme = self.segmentControl.frame;
    farme.size.height = 45;
    self.segmentControl.frame = farme;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SnellRoundhand-Bold" size:17],NSFontAttributeName,nil];
    [self.segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentIndex = 0;
    
    kusuriArray = [[NSMutableArray alloc]init];
    kennkoArray = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadContent];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadContent{
    if (segmentIndex == 0) {
        [kusuriArray removeAllObjects];
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"kusurilist"];
        kusuriDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
        kusuriArray = [[NSMutableArray alloc]initWithArray:[kusuriDict allKeys]];
    }else if (segmentIndex == 1){
        [kennkoArray removeAllObjects];
        NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"kennkolist"];
        kennkoDict = [[NSMutableDictionary alloc]initWithDictionary:tempdict];
        kennkoArray =[[NSMutableArray alloc]initWithArray:[kennkoDict allKeys]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    if (segmentIndex == 0) {
        count = kusuriArray.count;
    }else if (segmentIndex == 1){
        count = kennkoArray.count;
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (segmentIndex == 0) {
        return @"お薬手帳";
    }else if (segmentIndex == 1){
        return @"健康診断の結果";
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    if (segmentIndex == 0) {
        cell.textLabel.text = kusuriArray[indexPath.row];
        
    }else if (segmentIndex == 1){
         cell.textLabel.text = kennkoArray[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;
    if (segmentIndex==0) {
        tempname = kusuriArray[indexPath.row];
        [self performSegueWithIdentifier:@"gotoEditKusuriVC" sender:self];
    }else if (segmentIndex == 1){
        tempkey = kennkoArray[indexPath.row];
        [self performSegueWithIdentifier:@"gotoEditKennkoVC" sender:self];
    }
    
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (segmentIndex == 0) {
            NSArray *temp = [kusuriDict allKeys];
            [kusuriDict removeObjectForKey:temp[indexPath.row]];
            [[NSUserDefaults standardUserDefaults]setObject:kusuriDict forKey:@"kusurilist"];
        }else if (segmentIndex ==1){
            NSArray *temp = [kennkoDict allKeys];
            [kennkoDict removeObjectForKey:temp[indexPath.row]];
            [[NSUserDefaults standardUserDefaults]setObject:kennkoDict forKey:@"kennkolist"];
        }
        
    }
    [self reloadContent];
    [self.tableView reloadData];

}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (segmentIndex == 0) {
        EditKusiriTableViewController *kusuriVC = segue.destinationViewController;
        kusuriVC.editType = edittype;
        kusuriVC.tempPillname = tempname;
    }else if (segmentIndex == 1){
        EditKennkoTableViewController *kennkoVC = segue.destinationViewController;
        kennkoVC.editType = edittype;
        kennkoVC.tempkey = tempkey;
    }
}

-(void)segmentAction:(UISegmentedControl*)seg{
    if (seg.selectedSegmentIndex == 0) {
        segmentIndex = 0;
    }else if (seg.selectedSegmentIndex == 1){
        segmentIndex = 1;
    }
    [self reloadContent];
    [self.tableView reloadData];
}


- (IBAction)addAction:(id)sender {
    edittype = 0;
    if (segmentIndex == 0) {
         [self performSegueWithIdentifier:@"gotoEditKusuriVC" sender:self];
    }else if (segmentIndex == 1){
         [self performSegueWithIdentifier:@"gotoEditKennkoVC" sender:self];
    }
   
}

@end
