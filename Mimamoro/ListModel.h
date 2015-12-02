//
//  ListModel.h
//  Mimamori
//
//  Created by totyu1 on 2015/11/23.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property (strong, nonatomic)NSString *content;
@property (strong, nonatomic)NSString *type;//0:身の回りのもの　　1:その他のお願い事項

@end
