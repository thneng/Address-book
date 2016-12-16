//
//  XKAddressBookManger.h
//  通讯录(IOS 9.0)
//
//  Created by kr on 16/9/19.
//  Copyright © 2016年 凯如科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContactsUI/ContactsUI.h>
#import <AddressBook/AddressBook.h>

typedef void(^XKAddressBookBlock)(BOOL canRead);
@interface XKAddressBookManger : NSObject

///单例类方法
+ (instancetype)shareManger;
///获取通讯录权限(获取权限的方法)
- (void)canReadAddressBookPermissions:(XKAddressBookBlock)block;
///到设置页面
- (void)gotoSetting:(UIViewController*)vc;
///返回所有的联系人
- (NSArray*)allContacts;
@end

