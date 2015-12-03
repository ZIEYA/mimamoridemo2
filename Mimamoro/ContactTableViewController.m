//
//  ContactTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactTableViewController.h"
#import "EditContactTableViewController.h"

@interface ContactTableViewController (){
    int edittype; //0:追加 1:編集
    NSMutableArray *_contactArray;
}

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadContact{
    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"contact"];
    NSLog(@"contact:%@",tempdict);
    NSArray *keysArr = [tempdict allKeys];
    for (int i = 0; i<keysArr.count; i++) {
        NSDictionary *tempDict = [tempdict objectForKey:keysArr[i]];
        [_contactArray addObject:tempDict];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"contactCell"];
    }
    
    cell.textLabel.text = @"test";
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    edittype = 1;
    [self performSegueWithIdentifier:@"gotoEditContactVC" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditContactTableViewController *editVC = segue.destinationViewController;
    if (edittype == 0) {
        editVC.editType = 0;
    }else if (edittype == 1){
        editVC.editType = 1;
    }
    editVC.gruopname = self.groupid;
}


- (IBAction)addContactAction:(id)sender {
    edittype = 0;
    [self performSegueWithIdentifier:@"gotoEditContactVC" sender:self];
}

@end
