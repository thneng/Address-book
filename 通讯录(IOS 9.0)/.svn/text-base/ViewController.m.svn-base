//
//  ViewController.m
//  通讯录(IOS 9.0)
//
//  Created by kr on 16/9/5.
//  Copyright © 2016年 凯如科技. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <AddressBook/AddressBook.h>
#import "AddressBookUserInfoModel.h"
#import "XKAddressBookTableVIew.h"
#import "XKAddressBookManger.h"

#define IOS_VERSION [[UIDevice currentDevice] systemVersion]
@interface ViewController ()<CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addressBookBtn;
@property(nonatomic,strong)AddressBookUserInfoModel *userModel;
@property(nonatomic,strong)NSMutableArray *addressBookArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"当前版本是%@",IOS_VERSION);
}

- (IBAction)addressBookForge:(id)sender {
    [self getAddressBookQuanXian];

}

#pragma mark---------9.0之前获取通讯录数据的方法------------------------------------------------------
//在联系人当中获取每个联系人信息的方法:http://www.cnblogs.com/hankerTan/articles/2160718.html
-(void)getAddressBookQuanXian
{
    [self.addressBookArray removeAllObjects];

    [[XKAddressBookManger shareManger]canReadAddressBookPermissions:^(BOOL canRead) {
        if([IOS_VERSION floatValue] < 10.0)
        {
         if (canRead) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                    //获取所有通讯录信息
                    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
                    //获取通讯录联系人个数
                    CFIndex num = ABAddressBookGetPersonCount(addressBook);
                    //遍历
                    for (NSInteger i = 0; i < num; i++) {
                        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
                        _userModel=[[AddressBookUserInfoModel alloc]init];
                        //获取每个人的所有号码(电话,手机等)
                        ABMultiValueRef phones = ABRecordCopyValue(people,kABPersonPhoneProperty);
                        //存储所有的号码(手机,电话,其他等)
                        NSMutableArray *phonesArray=[NSMutableArray arrayWithCapacity:10];
                        for (int k = 0; k<ABMultiValueGetCount(phones); k++)
                        {
                            //获取該Label下的电话值
                            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, k);
                            NSString *newP = [personPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
                            newP = [newP stringByReplacingOccurrencesOfString:@"-" withString:@""];
                            [phonesArray addObject:newP];
                        }
                        //只显示手机号码
                        if(phonesArray.count>0)
                        {
                       _userModel.addressBookNumber=[NSString stringWithFormat:@"%@",phonesArray[0]];
                        }
                        //给model赋值
                        _userModel.addressBookName=(__bridge NSString*)ABRecordCopyCompositeName(people);
                        _userModel.addressBookImage=(__bridge NSData*)ABPersonCopyImageData(people);
                        [self.addressBookArray addObject:_userModel];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self pushAddressViewBookViewController];
                    });
                });
         }else
         {
             ///去设置权限页面
            [[XKAddressBookManger shareManger]gotoSetting:self];
         }
        }else
        {
            if (canRead) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //创建通讯录
                    CNContactStore *store=[[CNContactStore alloc]init];
                    //从通讯录获取的数据类型(这里仅仅指定需要获取的数据,节约资源)
                    NSArray * TypeArray = @[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactBirthdayKey,CNContactDepartmentNameKey,CNContactImageDataKey];
                    //进行数据的请求
                    CNContactFetchRequest * Request = [[ CNContactFetchRequest alloc]initWithKeysToFetch:TypeArray];
                    //进行数据的处理,遍历所有的联系人
                    [store enumerateContactsWithFetchRequest:Request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                        // CNLabeledValue 该类在json 转化二进制流的时候，不能被转化。切记一定要转化，否者也存不到文件里
                        _userModel=[[AddressBookUserInfoModel alloc]init];
                        //获取姓名
                        _userModel.addressBookName=[NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
                        //获取电话号码
                        NSMutableArray *contactPhoneArray=[NSMutableArray arrayWithCapacity:10];
                        for (CNLabeledValue*labelValue in contact.phoneNumbers) {
                            CNPhoneNumber *phoneNumber=labelValue.value;
                            [contactPhoneArray addObject:phoneNumber.stringValue];
                        }
                        if(contactPhoneArray.count >0)
                        {
                        _userModel.addressBookNumber=contactPhoneArray[0];
                        }
                        //判断头像是否存在,如果不存在的话需要判断
                        if (contact.imageData != nil) {
                            _userModel.addressBookImage=contact.imageData;
                        }else
                        {
                            _userModel.addressBookImage=nil;
                        }
                        [self.addressBookArray addObject:_userModel];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self pushAddressViewBookViewController];
                        });
                    }];
                });
                

            }else
            {
                [[XKAddressBookManger shareManger]gotoSetting:self];

            }
        }
    }];
}


- (void)pushAddressViewBookViewController
{
    XKAddressBookTableVIew *bookTableView=[[XKAddressBookTableVIew alloc]initWithStyle:UITableViewStylePlain];
    bookTableView.bookArray=self.addressBookArray;
    [self presentViewController:bookTableView animated:YES completion:nil];
}
#pragma mark-------SETANDGET--------
- (NSMutableArray *)addressBookArray
{
    if (!_addressBookArray) {
        _addressBookArray=[NSMutableArray arrayWithCapacity:10];
    }
    return _addressBookArray;
}

@end
