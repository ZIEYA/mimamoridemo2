//
//  ItemImageCollectionViewController.h
//  Mimamoro
//
//  Created by totyu1 on 2015/12/07.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol itemimageDelegate <NSObject>

-(void)setSelectedImage:(NSString*)imagename;

@end

@interface ItemImageCollectionViewController : UICollectionViewController
@property(nonatomic, assign)id<itemimageDelegate>itemdelegate;
@end
