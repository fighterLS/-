//
//  HomePageModel.h
//  兴趣周末
//
//  Created by 李赛 on 15/10/6.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XingQuNetAPIClient.h"
#import "JKDBModel.h"
@class Result;
@class DetailResult,ActivityLocation,ActivitySort,ActivityTime,ActivityDescription;
@interface HomePageModel : NSObject

+(void)getHomePageModelBlock:(void (^)(NSMutableArray *homePageArray, NSError *error))block withPage:(NSInteger)page;
+(void)getDetailModelBlock:(void (^)(DetailResult *detailResult, NSError *error))block withLeo_id:(NSString *)leo_id session_id:(NSString *)session_id v:(NSString *)v;
@end

@interface Result : JKDBModel

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger collected_num;

@property (nonatomic, copy) NSString *time_desc;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL show_free;

@property (nonatomic, strong) NSArray<NSString *> *tags;

@property (nonatomic, assign) NSInteger want_status;

@property (nonatomic, copy) NSString *consult_phone;

@property (nonatomic, assign) NSInteger sell_status;

@property (nonatomic, strong) NSArray<NSString *> *front_cover_image_list;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *time_info;

@property (nonatomic, copy) NSString *poi;

@property (nonatomic, copy) NSString *jump_type;

@property (nonatomic, copy) NSString *price_info;

@property (nonatomic, assign) NSInteger distance;

@property (nonatomic, copy) NSString *item_type;

@property (nonatomic, copy) NSString *biz_phone;

@property (nonatomic, assign) NSInteger viewed_num;

@property (nonatomic, copy) NSString *jump_data;

@property (nonatomic, assign) NSInteger category_id;

@property (nonatomic, assign) NSInteger leo_id;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *poi_name;

@end


@interface DetailResult : NSObject

@property (nonatomic, strong) NSArray<ActivityDescription *> *description;

@property (nonatomic, strong) NSArray<ActivityDescription *> *booking_policy;

@property (nonatomic, strong) NSArray<ActivityDescription *> *lrzm_tips;

@property (nonatomic, strong) NSArray<ActivityDescription *> *ticket_rule;

@property (nonatomic, strong) NSArray<NSString *> *images;

@property (nonatomic, strong) ActivitySort *category;

@property (nonatomic, assign) NSInteger leo_target_id;

@property (nonatomic, copy) NSString *poi;

@property (nonatomic, assign) NSInteger participate_status;

@property (nonatomic, copy) NSString *price_info;

@property (nonatomic, copy) NSString *provider;

@property (nonatomic, strong) ActivityTime *time;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) ActivityLocation *location;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *leo_target_type;

@end

@interface ActivityDescription : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *type;

@end

@interface ActivityLocation : NSObject

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *lon;

@end


@interface ActivitySort : NSObject

@property (nonatomic, copy) NSString *cn_name;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *icon_view;

@end

@interface ActivityTime : NSObject

@property (nonatomic, copy) NSString *end;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, copy) NSString *start;

@end




