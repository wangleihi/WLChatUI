//
//  WLChatNotificationManager.m
//  WLChat
//
//  Created by WangLei on 2019/4/30.
//  Copyright © 2019 WangLei. All rights reserved.
//  通知

#import "WLChatNotificationManager.h"

@implementation WLChatNotificationManager

//发送刷新session的通知
+ (void)postSessionNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ll.chat.session" object:nil];
}

//监听刷新session的通知
+ (void)observerSessionNotification:(id)instant sel:(SEL)sel {
    [[NSNotificationCenter defaultCenter] addObserver:instant selector:sel name:@"ll.chat.session" object:nil];
}

//移除通知
+ (void)removeObserver:(id)instant {
    [[NSNotificationCenter defaultCenter] removeObserver:instant];
}

@end
