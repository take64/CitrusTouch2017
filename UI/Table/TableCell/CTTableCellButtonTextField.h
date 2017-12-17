//
//  CTTableCellButtonTextField.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/28.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTTableCellTextField.h"

@interface CTTableCellButtonTextField : CTTableCellTextField <UITextFieldDelegate>
{
    // button
    CTImageButton *clearButton;
    CTButton *selectButton;
}



//
// property
//
@property (nonatomic, retain) CTImageButton *clearButton;
@property (nonatomic, retain) CTButton *selectButton;

@end
