//
//  AddNewItemTableViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/07.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "AddNewItemTableViewController.h"
#import "ItemModel.h"
#import "ItemImageCollectionViewController.h"
#import "LeafNotification.h"

@interface AddNewItemTableViewController ()<UITextFieldDelegate,itemimageDelegate,UIAlertViewDelegate>{
    NSMutableArray *itemArray;
    ItemModel *itemmodel;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation AddNewItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    itemmodel = [[ItemModel alloc]init];
    NSMutableArray *tmparr= [[NSUserDefaults standardUserDefaults]objectForKey:@"item"];
    if (tmparr) {
         itemArray = [[NSMutableArray alloc]initWithArray:tmparr];
    }
    if (self.edittype == 0 || self.tmpitemImage==nil || [self.tmpitemImage isEqualToString:@""]) {
        self.imageview.image = [UIImage imageNamed:@"addimage.png"];
        [_deleteBtn setEnabled:NO];
        [_deleteBtn setAlpha:0.5];
    }else if (self.edittype ==1){
        _imageview.image = [UIImage imageNamed:_tmpitemImage];
        _itemNameTextField.text = _tmpitemName;
        itemmodel.itemname = _tmpitemName;
        itemmodel.itemimage = _tmpitemImage;
        //Remove old item
        for (int i=0; i<itemArray.count; i++) {
            NSDictionary *tmpdict = [itemArray objectAtIndex:i];
            NSString *key = [tmpdict valueForKey:@"name"];
            if ([itemmodel.itemname isEqualToString:key]) {
                [itemArray removeObject:tmpdict];
            }
        }
    }
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)saveAction:(id)sender {
    if ([_itemNameTextField.text isEqualToString:@""]) {
        [LeafNotification showInController:self.navigationController withText:@"アイテム名を記入してください"];
        return;
    }
    if([itemmodel.itemimage isEqualToString:@""]||itemmodel.itemimage == nil){
        [LeafNotification showInController:self.navigationController withText:@"イメージを設定してください"];
        return;
    }

    // Add new item
    itemmodel.itemname = _itemNameTextField.text;
    NSMutableDictionary *tmpdict = [[NSMutableDictionary alloc]init];
    [tmpdict setValue:itemmodel.itemimage forKey:@"image"];
    [tmpdict setValue:itemmodel.itemname forKey:@"name"];
    [itemArray addObject:tmpdict];
    [[NSUserDefaults standardUserDefaults]setObject:itemArray forKey:@"item"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"削除でよろしいですか？" preferredStyle:UIAlertControllerStyleActionSheet];
    //添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"削除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        for (int i=0; i<itemArray.count; i++) {
            NSDictionary *tmpdict = [itemArray objectAtIndex:i];
            NSString *key = [tmpdict valueForKey:@"name"];
            if ([itemmodel.itemname isEqualToString:key]) {
                [itemArray removeObject:tmpdict];
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:itemArray forKey:@"item"];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)setSelectedImage:(NSString *)imagename{
    _imageview.image = [UIImage imageNamed:imagename];
    itemmodel.itemimage = imagename;
}


#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

- (IBAction)btnAction:(id)sender {
    [self performSegueWithIdentifier:@"gotoSelectItemImage" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ItemImageCollectionViewController *ivc = segue.destinationViewController;
    ivc.itemdelegate = self;
}


@end
