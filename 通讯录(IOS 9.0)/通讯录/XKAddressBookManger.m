//
//  XKAddressBookManger.m
//  通讯录(IOS 9.0)
//
//  Created by kr on 16/9/19.
//  Copyright © 2016年 凯如科技. All rights reserved.
//

#import "XKAddressBookManger.h"

///获取当前版本号
#define iOS_Version [[UIDevice currentDevice]systemVersion]

@implementation XKAddressBookManger

+ (instancetype)shareManger{
    static XKAddressBookManger *manger = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manger) {
            manger = [[XKAddressBookManger alloc]init];
        }
    });
    return manger;
}

/**
 获取通讯录权限

 @param block block
 */
- (void)canReadAddressBookPermissions:(XKAddressBookBlock)block
{
    NSLog(@"%@",iOS_Version);
    if ([iOS_Version floatValue] >= 10.0) {
        ///创建通讯录
        CNContactStore *store=[[CNContactStore alloc]init];
        ///获取通讯录当前权限状态
        CNAuthorizationStatus status=[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if(status!= CNAuthorizationStatusAuthorized)
        {
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
                if (error) {
                    
                    NSLog(@"error=%@",error);
                }else if (!granted) {
                    
                    block(NO);
                }else{
                    
                    block(YES);
                }
            }];
        }else
        {
            if(block)
            {
                block(YES);
            }
        }

    }else
    {
    ///创建通讯录
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ///获取请求权限状态
    ABAuthorizationStatus authStatus=ABAddressBookGetAuthorizationStatus();
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        //第一次进来请求访问
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    NSLog(@"Error: %@", (__bridge NSError *)error);
                }
                else if (!granted)
                {
                    block(NO);
                }
                else
                {
                    block(YES);
                }
            });
        });
    }else
    {
        if (block) {
            block(YES);
        }
    }
    }
}

- (void)gotoSetting:(UIViewController *)vc
{
    NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
    if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
    NSString *message = [NSString stringWithFormat:@"请在%@的\"设置-隐私-通讯录\"选项中，\r允许%@访问你的通讯录。",[UIDevice currentDevice].model,appName];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancleAction];
    [alertVC addAction:sureAction];
    [vc presentViewController:alertVC animated:YES completion:nil];
}
@end
