//
//  OpenAMapURLRequestViewController.h
//  officialDemo2D
//
//  Created by xiaoming han on 15/6/12.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import "BaseMapViewController.h"

@interface OpenAMapURLRequestViewController : BaseMapViewController
@property (nonatomic, strong) MAPointAnnotation * destination;
@property (nonatomic, strong) ActivityLocation *location;
@property (nonatomic, copy) NSString *locationName;
@end
