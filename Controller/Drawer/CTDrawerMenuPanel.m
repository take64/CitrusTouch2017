//
//  CTDrawerMenuPanel.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/01/25.
//  Copyright © 2017年 citrus.tk. All rights reserved.
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
    if(self)
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
//        CGRect imageRect = CGRectMake((headWidth / 2) - (imageWidth / 2),
//                                      (headHeight / 2) - (imageHeight / 2),
//                                      imageWidth,
//                                      imageHeight
//                                      );
        
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

//// bind
//- (void)bindImage:(UIImage *)imageValue
//{
//    [[self headImageView] setImage:imageValue];
//}

//// setter head background-color
//- (void)setHeadBackgroundColor:(UIColor *)colorValue
//{
//    [[[self headView] callStyle] addStyleKey:@"background-color" value:[CTColor hexStringWithColor:colorValue]];
//}
//
//// setter table view background-color
//- (void)setTableViewBackgroundColor:(UIColor *)colorValue
//{
//    [[self menuTableView] setBackgroundColor:colorValue];
//}

@end
