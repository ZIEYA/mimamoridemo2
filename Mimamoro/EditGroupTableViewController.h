//
//  EditGroupTableViewController.h
//  Mimamoro
//
//  Created by totyu1 on 2015/12/03.
//  Copyright © 2015年 totyu1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "ContactModel.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
@interface EditGroupTableViewController : UITableViewController<CNContactPickerDelegate>
@property int editType;//0:追加  1:編集
@property (strong, nonatomic)NSDictionary *contdic;
@end
