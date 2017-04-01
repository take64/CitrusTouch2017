//
//  CTTheme.m
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTheme.h"

#import "CTColor.h"

@implementation CTTheme

//
// synthesize
//
@synthesize navigationBarColor;

@synthesize drawerBackColor;
@synthesize drawerPanelIcon;
@synthesize drawerPanelBackColor;
@synthesize drawerCellHeadBackColor;
@synthesize drawerCellHeadTextColor;
@synthesize drawerCellBodyBackColor;
@synthesize drawerCellBodyTextColor;


#pragma mark - method
//
// method
//

// UINavigationBar - color
- (UIColor *)callNavigationBarColor
{
    if([self navigationBarColor] != nil)
    {
        return [self navigationBarColor];
    }
    return [CTColor colorWithHEXString:@"FFFFFF"];
}


// drawer setting
- (UIColor *)callDrawerBackColor        { return [CTNVL compare:[self drawerBackColor]          replace:[UIColor whiteColor]]; }
- (UIImage *)callDrawerPanelIcon        { return [CTNVL compare:[self drawerPanelIcon]          replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerPanelBackColor   { return [CTNVL compare:[self drawerPanelBackColor]     replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellHeadBackColor{ return [CTNVL compare:[self drawerCellHeadBackColor]  replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellHeadTextColor{ return [CTNVL compare:[self drawerCellHeadTextColor]  replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellBodyBackColor{ return [CTNVL compare:[self drawerCellBodyBackColor]  replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellBodyTextColor{ return [CTNVL compare:[self drawerCellBodyTextColor]  replace:[UIColor whiteColor]]; }

@end
