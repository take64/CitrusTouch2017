//
//  CTTableViewTrait.m
//  CitrusTouch3
//
//  Created by take64 on 2017/05/03.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTTableViewTrait.h"

@implementation CTTableViewTrait

// call table header view
+ (UIView *)callTableHeaderViewWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    // head title
    NSString *titleString = @"";
    if ([tableDelegate respondsToSelector:@selector(callHeaderTitleWithSection:)] == YES)
    {
        titleString = [tableDelegate callHeaderTitleWithSection:section];
    }

    // head view
    UIView *titleView = nil;
    if ([tableDelegate respondsToSelector:@selector(callHeaderViewWithSection:)] == YES)
    {
        titleView = [tableDelegate callHeaderViewWithSection:section];
    }

    // title id
    NSString *queueID = [CTTableHeaderView reuseIdentifierWithSection:section];

    // dequeue
    CTTableHeaderView *headerFooterView = (CTTableHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:queueID];

    // data exists
    if ([titleString length] > 0 || titleView != nil)
    {
        // generate
        if (headerFooterView == nil)
        {
            headerFooterView = [[CTTableHeaderView alloc] initWithReuseIdentifier:queueID];
            [headerFooterView setMargin:[self callTableSectionMarginSizeWithController:tableDelegate tableView:tableView]];
            CTLog(@"%ff", [headerFooterView margin]);
        }
    }

    // bind
    if (headerFooterView != nil)
    {
        // title string exist
        if ([titleString length] > 0)
        {
            [headerFooterView bindTitle:titleString];
        }

        // title view exist
        if (titleView != nil)
        {
            [headerFooterView bindView:titleView];
        }
    }

    return headerFooterView;
}

// call table footer view
+ (UIView *)callTableFooterViewWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    // head title
    NSString *titleString = @"";
    if ([tableDelegate respondsToSelector:@selector(callFooterTitleWithSection:)] == YES)
    {
        titleString = [tableDelegate callFooterTitleWithSection:section];
    }

    // head view
    UIView *titleView = nil;
    if ([tableDelegate respondsToSelector:@selector(callFooterViewWithSection:)] == YES)
    {
        titleView = [tableDelegate callFooterViewWithSection:section];
    }

    // queue id
    NSString *queueID = [CTTableFooterView reuseIdentifierWithSection:section];

    // dequeue
    CTTableFooterView *headerFooterView = (CTTableFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:queueID];

    // data exists
    if ([titleString length] > 0 || titleView != nil)
    {
        // generate
        if (headerFooterView == nil)
        {
            headerFooterView = [[CTTableFooterView alloc] initWithReuseIdentifier:queueID];
            [headerFooterView setMargin:[self callTableSectionMarginSizeWithController:tableDelegate tableView:tableView]];
        }
    }

    // bind
    if (headerFooterView != nil)
    {
        // title string exist
        if ([titleString length] > 0)
        {
            [headerFooterView bindTitle:titleString];
        }

        // title view exist
        if (titleView != nil)
        {
            [headerFooterView bindView:titleView];
        }
    }

    return headerFooterView;
}


// call table header/footer margin size
+ (CGFloat)callTableSectionMarginSizeWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView
{
    CTTableViewMode mode = CTTableViewModeList;
    if ([tableDelegate respondsToSelector:@selector(callTableViewMode)] == YES)
    {
        mode = [tableDelegate callTableViewMode];
    }

    CGFloat result = .0f;
    if (mode == CTTableViewModeEdit)
    {
        result = CT8(1);
        if ([tableView style] == UITableViewStyleGrouped)
        {
            result += CT8(1);
        }
    }

    return result;
}

// call table header height
+ (CGFloat)callTableHeaderHeightWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    UIView *view = [self callTableHeaderViewWithController:tableDelegate tableView:tableView section:section];
    if (view == nil)
    {
        return 0;
    }
    return [view frame].size.height;
}

// call table footer height
+ (CGFloat)callTableFooterHeightWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    UIView *view = [self callTableFooterViewWithController:tableDelegate tableView:tableView section:section];
    if (view == nil)
    {
        return 0;
    }
    return [view frame].size.height;
}

@end
