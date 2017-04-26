//
//  CTKeySelectModal.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/19.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTKeySelectModal.h"

@interface CTKeySelectModal ()

@end

@implementation CTKeySelectModal


//
// synthesize
//
@synthesize selectedKey;
@synthesize keyList;
@synthesize keyDict;


#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//


// セクション内セル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[[self keyList] objectAtIndex:section] count];
}
// セルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CellId";
    
    CTTableCellLabel *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(cell == nil)
    {
        cell = [[CTTableCellLabel alloc] initWithPrefix:nil reuseIdentifier:CellId];
    }
    if(cell != nil)
    {
        NSInteger section   = [indexPath section];
        NSInteger row       = [indexPath row];
        id _selectedKey = [[[self keyList] objectAtIndex:section] objectAtIndex:row];
        
        NSString *valString = [[self keyDict] objectForKey:_selectedKey];
        [cell setContentText:valString];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        if([[self selectedList] containsObject:_selectedKey] == YES)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        
    }
    return cell;
}
// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self keyList] count];
}


#pragma mark - UITableViewDelegate method
//
// UITableViewDelegate method
//

// 選択
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = [indexPath section];
    NSInteger row       = [indexPath row];
    id _selectedKey = [[[self keyList] objectAtIndex:section] objectAtIndex:row];
    [self setSelectedKey:_selectedKey];
    [self setSelectedList:[@[ _selectedKey ] mutableCopy]];
//    if([self modalComplete] != nil)
//    {
//        self.modalComplete(_selectedKey);
//    }
    [self hide];
}


#pragma mark - extends
//
// extends
//

// ボタン押下時(選択)
- (void)onTapBarButtonSelect
{
//    if([self modalComplete] != nil)
//    {
//        if([self selectedList] != nil && [[self selectedList] count] > 0)
//        {
//            self.modalComplete([[self selectedList] objectAtIndex:0]);
//        }
//    }
    [self hide];
}


#pragma mark - method
//
// method
//

// データ読み込み
- (void)bindSelectData:(NSArray<NSArray *> *)_keyList keyValue:(NSDictionary *)_keyDict
{
    [self setKeyList:_keyList];
    [self setKeyDict:_keyDict];
}

// データ設定
- (void)loadObject:(NSMutableArray<id> *)_selectedList
{
    if([_selectedList isKindOfClass:[NSArray class]] == YES)
    {
        _selectedList = [(NSArray *)_selectedList mutableCopy];
    }
    [self setSelectedList:_selectedList];
}

@end
