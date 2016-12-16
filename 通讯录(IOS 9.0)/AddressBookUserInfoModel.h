//
//  AddressBookUserInfoModel.h
//  通讯录(IOS 9.0)
//
//  Created by kr on 16/9/14.
//  Copyright © 2016年 凯如科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookUserInfoModel : NSObject
//姓名
@property(nonatomic,strong)NSString *addressBookName;
//电话号码
@property(nonatomic,strong)NSString *addressBookNumber;
//头像
@property(nonatomic,strong)NSData *addressBookImage;
@end
