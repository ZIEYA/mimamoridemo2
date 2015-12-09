//
//  contactAddressModel.h
//  Mimamori
//
//  Created by totyu1 on 2015/11/19.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contactAddressModel : NSObject
@property NSString *name;
@property NSString *emailaddress;
@property NSString *contactType;//0:家族 1:その他
@property NSString *emergencyType;//0:通常 1:緊急
//@property NSString *familyName;
@end
