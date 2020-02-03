//
//  WLChatUserModel.m
//  WLChat
//
//  Created by WangLei on 2019/4/24.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLChatUserModel.h"

@implementation WLChatUserModel

///默认登录用户
+ (instancetype)shareInfo {
    static WLChatUserModel *userInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[WLChatUserModel alloc] init];
        userInfo.uid = @"00001";
        userInfo.name = @"无敌是多么的寂寞";
        userInfo.avatar = @"http://sqb.wowozhe.com/images/home/wx_appicon.png";
    });
    return userInfo;
}

@end
