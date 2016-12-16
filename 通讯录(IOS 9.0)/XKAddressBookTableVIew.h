//
//  XKAddressBookTableVIew.h
//  通讯录(IOS 9.0)
//
//  Created by kr on 16/9/18.
//  Copyright © 2016年 凯如科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBookUserInfoModel.h"

@interface XKAddressBookTableVIew : UITableViewController
@property(nonatomic,strong)NSMutableArray *bookArray;
@property(nonatomic,strong)AddressBookUserInfoModel *model;
@end
