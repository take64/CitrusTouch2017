//
//  CTDrawerMenuPanel.m
//  CitrusTouch3
//
//  Created by take64 on 2017/01/25.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTDrawerMenuPanel.h"

#import "CTColor.h"

@implementation CTDrawerMenuPanel

//
// synthesize
//
@synthesize headView;
@synthesize headImageView;
@synthesize menuTableView;



#pragma mark - method
//
// method
//

// init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // パネルサイズ
        CGFloat panelWidth = CGRectGetWidth(frame);
        CGFloat panelHeight = CGRectGetHeight(frame);

        // ヘッダサイズ
        CGFloat headWidth = CGRectGetWidth(frame);
        CGFloat headHeight = headWidth;

        // 画像サイズ
        CGFloat imageWidth = 64;
        CGFloat imageHeight = imageWidth;

        // ヘッダビュー
        CTView *view;
        view = [[CTView alloc] initWithFrame:CGRectMake(0, 0, headWidth, headHeight)];
        [[view callStyle] addStyleKey:@"background-color" value:[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callDrawerPanelBackColor]]];
        [view setUserInteractionEnabled:YES];
        [self addSubview:view];
        [self setHeadView:view];

        // 画像
        UIImageView *imageView;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
        [imageView setCenter:[view center]];
        [imageView setClipsToBounds:YES];
        [[imageView layer] setCornerRadius:8];
        [imageView setImage:[[CitrusTouchApplication callTheme] callDrawerPanelIconImage]];
        [view addSubview:imageView];
        [self setHeadImageView:imageView];

        // テーブルビュー
        UITableView *tableView;
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, panelWidth, panelWidth, (panelHeight - headHeight)) style:UITableViewStylePlain];
        [tableView setBackgroundColor:[[CitrusTouchApplication callTheme] callDrawerPanelBackColor]];
        [self addSubview:tableView];
        [self setMenuTableView:tableView];
    }
    return self;
}

@end
