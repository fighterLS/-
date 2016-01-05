//
//  HomePageModel.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/6.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel
+(void)getHomePageModelBlock:(void (^)(NSMutableArray *homePageArray, NSError *error))block withPage:(NSInteger)page
{
//   NSString *url= @"http://api.lanrenzhoumo.com/main/recommend/index/?city_id=0&lat=40.05334&lon=116.2966&page=1&session_id=00004200ac458269ce5e861da55f6c6714df6a&v=3";
    NSDictionary *params=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0",@"40.05334",@"116.2966",@(page),@"00004200ac458269ce5e861da55f6c6714df6a",@"3", nil] forKeys:[NSArray arrayWithObjects:@"city_id",@"lat",@"lon",@"page",@"session_id",@"v", nil]];
    NSMutableArray *mHomePageArray=[[NSMutableArray alloc]initWithCapacity:0];
    [[XingQuNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"main/recommend/index/?" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        
        if (data) {
            for (NSDictionary *dict in [data valueForKeyPath:@"result"]) {
                Result *model=[Result modelWithDictionary:dict];
                [mHomePageArray addObject:model];
            }
           // id resultData = [data valueForKeyPath:@"data"];
         
            block(mHomePageArray, nil);
        }else{
            block(nil, error);
        }
        
    }];
}

+(void)getDetailModelBlock:(void (^)(DetailResult *detailResult, NSError *error))block withLeo_id:(NSString *)leo_id session_id:(NSString *)session_id v:(NSString *)v
{
    //@"//api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=1358145309&session_id=&v=3"
    NSDictionary *params=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:leo_id,session_id,v, nil] forKeys:[NSArray arrayWithObjects:@"leo_id",@"session_id",@"v", nil]];
//    NSMutableArray *mArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    [[XingQuNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"wh/common/leo_detail?" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        
        if (data) {
            DetailResult *detailResult=[DetailResult modelWithJSON:[data objectForKey:@"result"]];
            block(detailResult, nil);
        }else{
            block(nil, error);
        }
        
    }];
}


@end


@implementation Result

@end





@implementation DetailResult
@synthesize description;
+ (NSDictionary *)objectClassInArray{
    return @{ @"description" : [ActivityDescription class],@"booking_policy" : [ActivityDescription class],@"lrzm_tips" : [ActivityDescription class],@"ticket_rule" : [ActivityDescription class]};
}

@end


@implementation ActivityLocation

@end



@implementation ActivitySort

@end


@implementation ActivityTime

@end


@implementation ActivityDescription

@end



