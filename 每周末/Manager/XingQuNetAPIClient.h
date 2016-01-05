//
//  XingQuNetAPIClient.m
//  兴趣周末
//
//  Created by 李赛 on 15-9-30.
//  Copyright (c) 2015年 李赛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "JDStatusBarNotification.h"
typedef enum {
	Get = 0,
	Post,
	Put,
    Delete
} NetworkMethod;

typedef NS_ENUM(NSInteger, IllegalContentType) {
    IllegalContentTypeTweet = 0,
    IllegalContentTypeTopic,
    IllegalContentTypeProject,
    IllegalContentTypeWebsite
};

@interface XingQuNetAPIClient : AFHTTPSessionManager

+ (id)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;


@end
