//
//  PersonImageCollectionViewController.h
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol imageDelegate <NSObject>

-(void)setSelectedImage:(NSString*)imagename;

@end

@interface PersonImageCollectionViewController : UICollectionViewController
@property(nonatomic, assign)id<imageDelegate>imagedelegate;
@end
