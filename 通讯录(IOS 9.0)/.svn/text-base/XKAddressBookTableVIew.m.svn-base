//
//  XKAddressBookTableVIew.m
//  通讯录(IOS 9.0)
//
//  Created by kr on 16/9/18.
//  Copyright © 2016年 凯如科技. All rights reserved.
//

#import "XKAddressBookTableVIew.h"

@implementation XKAddressBookTableVIew
 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSLog(@"%ld",indexPath.row);
    self.model=self.bookArray[indexPath.row];
    cell.textLabel.text=self.model.addressBookName;
    cell.detailTextLabel.text=self.model.addressBookNumber;
    if(self.model.addressBookImage != nil)
    {
    [cell.imageView setImage:[UIImage imageWithData:self.model.addressBookImage]];
    }else
    {
        [cell.imageView setImage:[UIImage imageNamed:@"Snip20160918_1"]];
    }

    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark---------getAndSet----------
- (AddressBookUserInfoModel *)model
{
    if (!_model) {
        _model=[[AddressBookUserInfoModel alloc]init];
    }
    return _model;
}
@end
