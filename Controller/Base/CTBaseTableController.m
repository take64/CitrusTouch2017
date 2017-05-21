//
//  CTBaseTableController.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/05/21.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseTableController.h"

@interface CTBaseTableController ()

@end

@implementation CTBaseTableController

//
// synthesize
//
@synthesize cacheEnable;
@synthesize headerCaches;
@synthesize footerCaches;

// init
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self)
    {
        // タイトル
        [self setTitle:[self callTitle]];
        
        // cache
        [self setCacheEnable:NO];
        [self setHeaderCaches:[@{} mutableCopy]];
        [self setFooterCaches:[@{} mutableCopy]];
    }
    return self;
}


#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セルヘッダ高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [self callHeaderCacheWithSection:section];
    if(headerView == nil)
    {
        return 0;
    }
    
    return CT8(3);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UIView *footerView = [self callFooterCacheWithSection:section];
    if(footerView == nil)
    {
        return 0;
    }
    return [footerView frame].size.height;
}

// セルヘッダを返す
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self callHeaderCacheWithSection:section];
}
// セルフッタを返す
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self callFooterCacheWithSection:section];
}


#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//


#pragma mark - method
//
// method
//

// タイトル取得
- (NSString *)callTitle
{
    return @"";
}



#pragma mark - private
//
// private
//

// ヘッダキャッシュの取得
- (UIView *)callHeaderCacheWithSection:(NSInteger)section
{
    UIView *cacheView = [[self headerCaches] objectForKey:@(section)];
    if(cacheView == nil)
    {
        cacheView = [CTTableViewTrait callTableHeaderViewWithController:self tableView:[self tableView] section:section];
        [self saveHeaderCacheWithSection:section view:cacheView];
    }
    return cacheView;
}

// フッタキャッシュの取得
- (UIView *)callFooterCacheWithSection:(NSInteger)section
{
    UIView *cacheView = [[self footerCaches] objectForKey:@(section)];
    if(cacheView == nil)
    {
        cacheView = [CTTableViewTrait callTableFooterViewWithController:self tableView:[self tableView] section:section];
        [self saveFooterCacheWithSection:section view:cacheView];
    }
    return cacheView;
}

// ヘッダキャッシュの追加
- (void)saveHeaderCacheWithSection:(NSInteger)section view:(UIView *)viewValue
{
    if(viewValue != nil)
    {
        [[self headerCaches] setObject:viewValue forKey:@(section)];
    }
}

// フッタキャッシュの追加
- (void)saveFooterCacheWithSection:(NSInteger)section view:(UIView *)viewValue
{
    if(viewValue != nil)
    {
        [[self footerCaches] setObject:viewValue forKey:@(section)];
    }
}

@end
