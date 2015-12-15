//
//  FamilyViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "FamilyViewController.h"
#import "FamilyCollectionViewCell.h"
#import "LeafNotification.h"
#import "familyModel.h"
@interface FamilyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
{
    familyModel* fammodel;
    FamilyCollectionViewCell*cell;
    NSArray *familyTitle;
    NSMutableArray*famImgArr;
    NSMutableDictionary*famTitleArr;
    NSMutableArray*famNumArr;
    NSString *familyImg;
    NSString *familynumber;
    NSArray *fiarr;
    NSArray *ftarr;
    NSArray *fnarr;
    NSDictionary *famdata;
    NSMutableDictionary *_exitDict;
}
@property (weak, nonatomic) IBOutlet UICollectionView *famImage;
@property (weak, nonatomic) IBOutlet UITextField *famTitle;
@property (weak, nonatomic) IBOutlet UIButton *famBtn;


@end

@implementation FamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fammodel = [[familyModel alloc]init];
    _famTitle.delegate= self;
    familyImg = @"1";
    famTitleArr = [[NSMutableDictionary alloc]init];
    _famImage.delegate = self;
    _famImage.dataSource = self;
    _famImage.layer.cornerRadius = 15;
    _famImage.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1].CGColor;
    _famImage.layer.borderWidth = 2;
    _famBtn.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1].CGColor;
    _famBtn.layer.borderWidth = 2;
    _famBtn.layer.cornerRadius = 8;
    familyTitle = [[NSArray alloc]initWithObjects:@"妻",@"親友",@"娘",@"息子",@"夫",@"嫁",@"婿",@"孫",@"孫娘",@"医者",@"看護婦", nil];
    _famImage.allowsSelection = YES;
    if (!famTitleArr) {
        famTitleArr = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    famTitleArr = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"famTitleArrr"]];
    if([_famtype isEqualToString:@"1"]){
    NSIndexPath *ip=[NSIndexPath indexPathForRow:[_numbb intValue] inSection:0];
    [_famImage selectItemAtIndexPath:ip animated:YES scrollPosition:UICollectionViewScrollPositionBottom];
    familyImg = familyTitle[ip.row];
    familynumber = [NSString stringWithFormat:@"%ld",(long)ip.row];
    _famTitle.text = _titll;
    _exitDict = [famTitleArr objectForKey:_titll];
    _famTitle.text = _titll;
    fammodel.titlee  = _titll;
    familyImg = [_exitDict valueForKey:@"imagee"];
    }
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return familyTitle.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"myfamcell";
    cell = [_famImage dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.fimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[familyTitle objectAtIndex:indexPath.row]]]];
    UIView*selview = [[UIView alloc]initWithFrame:cell.frame];
    selview.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    selview.layer.cornerRadius = 11;
    cell.selectedBackgroundView = selview;
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 35, 15, 31);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (FamilyCollectionViewCell *)[_famImage cellForItemAtIndexPath:indexPath];
        //创建核心动画
        CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
        keyAnima.keyPath = @"transform.rotation";
        keyAnima.values = @[@(-M_PI_4 /90.0 * 15),@(M_PI_4 /90.0 * 15),@(-M_PI_4 /90.0 * 15)];
        //执行完之后不删除动画
        keyAnima.removedOnCompletion = YES;
        //执行完之后保存最新的状态
        keyAnima.fillMode = kCAFillModeForwards;
        //动画执行时间
        keyAnima.duration = 0.2;
        //设置重复次数。
        keyAnima.repeatCount = 2;
        //添加核心动画
        [cell.fimage.layer addAnimation:keyAnima forKey:nil];
    familyImg = familyTitle[indexPath.row];
    familynumber = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
}

- (IBAction)fambtn:(id)sender {
    if (![_famTitle.text isEqualToString: @""]&&![familyImg  isEqualToString: @"1"]) {
        if ([_famtype isEqualToString:@"0"]) {

        }else if([_famtype isEqualToString:@"1"]){
            famdata = [[NSDictionary alloc]init];
            famdata = [[NSUserDefaults standardUserDefaults]objectForKey:_titll];
            [[NSUserDefaults standardUserDefaults]setObject:famdata forKey:_famTitle.text];
            if (![_famTitle.text isEqualToString:_titll]) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:_titll];
            }
            [famTitleArr removeObjectForKey:_titll];
        }
        fammodel.titlee = _famTitle.text;
        fammodel.imagee = familyImg;
        fammodel.numberr = familynumber;
        NSMutableDictionary *famm = [[NSMutableDictionary alloc]init];
        [famm setValue:fammodel.titlee forKey:@"titlee"];
        [famm setValue:fammodel.imagee forKey:@"imagee"];
        [famm setValue:fammodel.numberr forKey:@"numberr"];
        [famTitleArr setObject:famm forKey:fammodel.titlee];
        [self.navigationController popViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults]setObject:famTitleArr forKey:@"famTitleArrr"];
    }else{
        [LeafNotification showInController:self withText:[NSString stringWithFormat:@"保存できませんので、画像やタイトル添加"]];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
