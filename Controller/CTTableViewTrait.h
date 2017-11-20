//
//  CTTableViewTrait.h
//  CitrusTouch3
//
//  Created by take64 on 2017/05/03.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTTableViewTrait : NSObject

// call table header view
+ (UIView *)callTableHeaderViewWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

// call table footer view
+ (UIView *)callTableFooterViewWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

// call table header/footer margin size
+ (CGFloat)callTableSectionMarginSizeWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView;

// call table header height
+ (CGFloat)callTableHeaderHeightWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

// call table footer height
+ (CGFloat)callTableFooterHeightWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

@end
