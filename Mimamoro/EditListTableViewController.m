//
//  EditListTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/07.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "EditListTableViewController.h"
#import "ListModel.h"

@interface EditListTableViewController ()<UITextViewDelegate>{
    NSMutableDictionary *listDict;
    NSMutableDictionary *exitDict;
    ListModel *listmodel;
}
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UISwitch *minomawariSwitch;

@end

@implementation EditListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    listmodel = [[ListModel alloc]init];
    
    listDict = [[NSMutableDictionary alloc]init];
    NSDictionary *tempdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"listcontent"];
    if (tempdict) {
        listDict = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"listcontent"]];
    }
    if (_editType == 0) {
        listmodel.type = [NSString stringWithFormat:@"%d",1];
        [_minomawariSwitch setOn:NO];
    }else if (_editType == 1){
        exitDict = [[NSMutableDictionary alloc]init];
        exitDict = [listDict objectForKey:_tempContent];
        _contentTextView.text = [exitDict valueForKey:@"content"];
        listmodel.content = _contentTextView.text;
        listmodel.type = [exitDict valueForKey:@"type"];
        if ([listmodel.type isEqualToString:@"0"]) {
            [_minomawariSwitch setOn:YES];
        }else if ([listmodel.type isEqualToString:@"1"]){
            [_minomawariSwitch setOn:NO];
        }
    }
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)typeValueChanged:(id)sender {
    BOOL setting = _minomawariSwitch.isOn;
    if (setting == YES) {
        listmodel.type = [NSString stringWithFormat:@"%d",0];
    }else if (setting == NO){
        listmodel.type = [NSString stringWithFormat:@"%d",1];
    }
}


- (IBAction)saveAction:(id)sender {
    if (_editType == 0) {
        
    }else if (_editType == 1){
        [listDict removeObjectForKey:_tempContent];
    }
    listmodel.content = _contentTextView.text;
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    [temp setValue:listmodel.content forKey:@"content"];
    [temp setValue:listmodel.type forKey:@"type"];
    [listDict setObject:temp forKey:listmodel.content];
    //NSLog(@"%@",listDict);
    [[NSUserDefaults standardUserDefaults]setObject:listDict forKey:@"listcontent"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return  YES;
}



@end
