//
//  ContactCollectionViewController.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/02.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "ContactCollectionViewController.h"
#import "ContactTableViewController.h"
#import "ContactCollectionViewCell.h"
#import "EditContactViewController.h"
@interface ContactCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIPickerViewDelegate,UIPickerViewDataSource>
{
    ContactCollectionViewCell*cell;
    NSArray*connectionTitle;
    NSMutableArray *connection;
    NSArray *connection2;
    UIPickerView *Choice;
    UIToolbar *ChoiceBar;
    NSString *SelectedName;
    
}

@end

@implementation ContactCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //长按手势
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(delete:)];
    longPressGr.minimumPressDuration = 2.0;
    [self.collectionView addGestureRecognizer:longPressGr];
    
    Choice = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height+self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/4)];
    Choice.backgroundColor = [UIColor lightGrayColor];
    Choice.delegate = self;
    Choice.dataSource = self;
    [Choice reloadComponent:1];
    [self.view addSubview:Choice];
    
    ChoiceBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height+40, self.view.frame.size.width, 60)];
    ChoiceBar.barStyle = UIBarStyleBlackOpaque;
    [ChoiceBar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *Cancel = [[UIBarButtonItem alloc] initWithTitle:@"キャンセル" style:UIBarButtonItemStyleDone target:self action:@selector(Cancel)];
    [barItems addObject:Cancel];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *Confirm = [[UIBarButtonItem alloc] initWithTitle:@"確認" style:UIBarButtonItemStyleDone target:self action:@selector(Confirm)];
    [barItems addObject:Confirm];
    [ChoiceBar setItems:barItems animated:YES];
    [self.view addSubview:ChoiceBar];
    
    self.collectionView.userInteractionEnabled = YES;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    connection = [[NSMutableArray alloc]init];
    connection2 = [[NSMutableArray alloc]init];

    NSLog(@"%@",connection);
    connection2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"connection"];
    
    connection =[[NSMutableArray alloc]initWithArray:connection2];
    
    connectionTitle = [[NSArray alloc]initWithObjects:@"妻",@"夫",@"親友",@"息子",@"嫁",@"娘",@"婿",@"孫",@"孫娘",@"医者",@"看護婦", nil];
}

#pragma mark <UICollectionViewDataSource>
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return connection.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"mycell";
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[connection objectAtIndex:indexPath.row]]]];
    cell.name.text = [connection objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 125);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 35, 0, 35);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    cell = (ContactCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blackColor];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"lai"])
    {
        ContactTableViewController *ContactTableView = segue.destinationViewController;
        NSArray *indexPath = [self.collectionView indexPathsForSelectedItems];
        cell = (ContactCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath[0]];
        ContactTableView.family = cell.name.text;
        
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)Confirm{
    if(SelectedName == nil){
        [connection addObject: @"妻"];
    }else{
    [connection addObject: SelectedName];
    }
    [self.collectionView reloadData];
    
    [[NSUserDefaults standardUserDefaults]setObject:connection forKey:@"connection"];
    NSLog(@"%@",connection);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.03];//动画时间长度，单位秒，浮点数
    Choice.frame  = CGRectMake(0, self.view.frame.size.height+self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/3);
    ChoiceBar.frame = CGRectMake(0, self.view.frame.size.height+40, self.view.frame.size.width, 40);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)Cancel{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.03];//动画时间长度，单位秒，浮点数
    Choice.frame  = CGRectMake(0, self.view.frame.size.height+self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/3);
    ChoiceBar.frame = CGRectMake(0, self.view.frame.size.height+40, self.view.frame.size.width, 40);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
- (IBAction)Addd:(id)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.01];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:1];
    Choice.frame = CGRectMake(0, self.view.frame.size.height/1.5, self.view.frame.size.width, self.view.frame.size.height/4);
    ChoiceBar.frame = CGRectMake(0, self.view.frame.size.height/1.5-40, self.view.frame.size.width, 40);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)animationFinished{
    NSLog(@"动画结束!");
}

//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//行数
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return connectionTitle.count;
}
//行的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return  50;
}
//行的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.view.frame.size.width;
}
//每行显示
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view) {
        view=[[UIView alloc]init];
    }
    UILabel *text=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    text.textColor = [UIColor blackColor];
    text.textAlignment = NSTextAlignmentCenter;
    text.font = [UIFont fontWithName:@"Arial" size:50.0f];
    text.text = [connectionTitle objectAtIndex:row];
    [view addSubview:text];
    return view;
}
//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
        SelectedName = [connectionTitle objectAtIndex:row];
}

-(void)delete:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.collectionView];
        NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:point];
        if(indexPath == nil) return ;
        [connection removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:connection forKey:@"connection"];
        [self.collectionView reloadData];
    }
}

@end
