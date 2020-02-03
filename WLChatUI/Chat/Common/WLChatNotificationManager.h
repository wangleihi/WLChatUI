//
//  WLChatNotificationManager.h
//  WLChat
//
//  Created by WangLei on 2019/4/30.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLChatNotificationManager : NSObject

///发送刷新session的通知
+ (void)postSessionNotification;
///监听刷新session的通知
+ (void)observerSessionNotification:(id)instant sel:(SEL)sel;
///移除通知
+ (void)removeObserver:(id)instant;

@end
