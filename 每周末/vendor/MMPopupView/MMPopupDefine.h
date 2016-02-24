//
//  MMPopupDefine.h
//  MMPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//
#import "MMPopupItem.h"
#import "MMPopupView.h"
#import "MMAlertView.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#ifndef MMPopupDefine_h
#define MMPopupDefine_h

#define MMWeakify(o)        __weak   typeof(self) mmwo = o;
#define MMStrongify(o)      __strong typeof(self) o = mmwo;
#define MMHexColor(color)   [UIColor mm_colorWithHex:color]
#define MM_SPLIT_WIDTH      (1/[UIScreen mainScreen].scale)

#endif /* MMPopupDefine_h */
