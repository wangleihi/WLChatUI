//
//  WLChatMessageManager.h
//  WLChat
//
//  Created by WangLei on 2019/4/24.
//  Copyright © 2019 WangLei. All rights reserved.
//  消息管理

#import <UIKit/UIKit.h>
#import "WLChatMessageModel.h"
#import "WLChatUserModel.h"

@interface WLChatMessageManager : NSObject

#pragma mark - 创建消息模型
//创建系统消息
+ (WLChatMessageModel *)createSystemMessage:(WLChatUserModel *)userModel
                                    message:(NSString *)message
                                   isSender:(BOOL)isSender;

///创建文本消息
+ (WLChatMessageModel *)createTextMessage:(WLChatUserModel *)userModel
                                  message:(NSString *)message
                                 isSender:(BOOL)isSender;

///创建录音消息
+ (WLChatMessageModel *)createVoiceMessage:(WLChatUserModel *)userModel
                                  duration:(NSInteger)duration
                                  voiceUrl:(NSString *)voiceUrl
                                  isSender:(BOOL)isSender;

///创建图片消息
+ (WLChatMessageModel *)createImageMessage:(WLChatUserModel *)userModel
                                 thumbnail:(NSString *)thumbnail
                                  original:(NSString *)original
                                 thumImage:(UIImage *)thumImage
                                  oriImage:(UIImage *)oriImage
                                  isSender:(BOOL)isSender;

///创建视频消息
+ (WLChatMessageModel *)createVideoMessage:(WLChatUserModel *)userModel
                                  videoUrl:(NSString *)videoUrl
                                  coverUrl:(NSString *)coverUrl
                                coverImage:(UIImage *)coverImage
                                  isSender:(BOOL)isSender;

@end
