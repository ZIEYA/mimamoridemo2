//
//  ContactModel.h
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property NSString *name;
@property NSString *email;
@property NSString *imageName;

@property NSString *groupType;//0:配偶者 1:息子　2:娘　3:親友　4:その他
@property NSString *worryType;//0:普通 1:不安時
@property NSString *emergencyType;//0:普通 1:緊急時
@property NSString *alertType;//0: no 1:通知

@end
