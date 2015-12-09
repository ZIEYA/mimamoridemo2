//
//  softDetailsViewController.m
//  Mimamoro
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import "softDetailsViewController.h"

@interface softDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *Simg;
@property (weak, nonatomic) IBOutlet UILabel *Stitl;

@end

@implementation softDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Stitl.text = _sTitle;
    [_Simg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_sImage]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
