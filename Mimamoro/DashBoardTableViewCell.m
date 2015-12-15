//
//  DashBoardTableViewCell.m
//  Mimamoro
//
//  Created by totyu1 on 2015/12/15.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "DashBoardTableViewCell.h"
#import "UUChart.h"

@interface DashBoardTableViewCell()<UUChartDataSource>{
    //NSIndexPath *path;
    int type;
    int xnum; //0:1~24時 1:1~7日 2:１〜３０日 　3:１〜１２月
    UUChart *chartview;
    NSArray *yArr;
}

@end

@implementation DashBoardTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configUI:(NSIndexPath*)indexPath type:(int)styletype unit:(int)segmentunitnum yArray:(NSArray*)yarray{
    if (chartview) {
        [chartview removeFromSuperview];
        chartview =nil;
    }
    //path = indexPath;
    type = styletype;
    xnum = segmentunitnum;
    yArr = yarray;
    chartview =[[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20
                                                                   , 150) withSource:self withStyle:type==1?UUChartBarStyle:UUChartLineStyle];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

-(NSArray*)getXTitles:(int)num{
    NSMutableArray *xTitles = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =1; i<=num; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

- (NSArray *)UUChart_xLableArray:(UUChart *)chart{
    if (type ==1) {
        switch (xnum) {
            case 0:
                [self getXTitles:24];
            case 1:
                [self getXTitles:7];
            case 2:
                [self getXTitles:30];
            case 3:
                [self getXTitles:12];
            default:
                break;
        }
    }else{
        switch (xnum) {
            case 0:
                [self getXTitles:24];
            case 1:
                [self getXTitles:7];
            case 2:
                [self getXTitles:30];
            case 3:
                [self getXTitles:12];
            default:
                break;
        }
    }
    return [self getXTitles:12];
}

- (NSArray *)UUChart_yValueArray:(UUChart *)chart{
    return yArr;
}

@end
