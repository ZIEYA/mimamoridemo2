//
//  AddViewController.h
//  Mimamoro
//
//  Created by totyu3 on 15/12/8.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *rootArr;
@end
