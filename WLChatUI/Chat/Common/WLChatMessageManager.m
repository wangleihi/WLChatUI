//
//  WLChatMessageManager.m
//  WLChat
//
//  Created by WangLei on 2019/4/24.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLChatMessageManager.h"
#import "WLChatUserModel.h"
#import "WLChatHelper.h"

@implementation WLChatMessageManager

#pragma mark - 创建消息模型
//创建系统消息
+ (WLChatMessageModel *)createSystemMessage:(WLChatUserModel *)userModel
                                    message:(NSString *)message
                                   isSender:(BOOL)isSender {
    WLChatMessageModel *msgModel = [[WLChatMessageModel alloc] init];
    msgModel.msgType = WLMessageTypeSystem;
    msgModel.message = message;
    [self setConfig:msgModel userModel:userModel isSender:isSender];
    return msgModel;
}

//创建文本消息
+ (WLChatMessageModel *)createTextMessage:(WLChatUserModel *)userModel
                                  message:(NSString *)message
                                 isSender:(BOOL)isSender {
    WLChatMessageModel *msgModel = [[WLChatMessageModel alloc] init];
    msgModel.msgType = WLMessageTypeText;
    msgModel.message = message;
    [self setConfig:msgModel userModel:userModel isSender:isSender];
    return msgModel;
}

//创建录音消息
+ (WLChatMessageModel *)createVoiceMessage:(WLChatUserModel *)userModel
                                  duration:(NSInteger)duration
                                  voiceUrl:(NSString *)voiceUrl
                                  isSender:(BOOL)isSender {
    WLChatMessageModel *msgModel = [[WLChatMessageModel alloc] init];
    msgModel.msgType = WLMessageTypeVoice;
    msgModel.message = @"[语音]";
    msgModel.duration = duration;
    msgModel.voiceUrl = voiceUrl;
    [self setConfig:msgModel userModel:userModel isSender:isSender];
    return msgModel;
}

//创建图片消息
+ (WLChatMessageModel *)createImageMessage:(WLChatUserModel *)userModel
                                 thumbnail:(NSString *)thumbnail
                                  original:(NSString *)original
                                 thumImage:(UIImage *)thumImage
                                  oriImage:(UIImage *)oriImage
                                  isSender:(BOOL)isSender {
    WLChatMessageModel *msgModel = [[WLChatMessageModel alloc] init];
    msgModel.msgType   = WLMessageTypeImage;
    msgModel.message   = @"[图片]";
    msgModel.thumbnail = thumbnail;
    msgModel.original  = original;
    msgModel.imgW = oriImage.size.width;
    msgModel.imgH = oriImage.size.height;
    //将图片保存到本地
    [WLChatHelper storeImage:oriImage forKey:original];
    [WLChatHelper storeImage:thumImage forKey:thumbnail];
    [self setConfig:msgModel userModel:userModel isSender:isSender];
    return msgModel;
}

//创建视频消息
+ (WLChatMessageModel *)createVideoMessage:(WLChatUserModel *)userModel
                                  videoUrl:(NSString *)videoUrl
                                  coverUrl:(NSString *)coverUrl
                                coverImage:(UIImage *)coverImage
                                  isSender:(BOOL)isSender {
    WLChatMessageModel *msgModel = [[WLChatMessageModel alloc] init];
    msgModel.msgType   = WLMessageTypeVideo;
    msgModel.message   = @"[视频]";
    msgModel.videoUrl = videoUrl;
    msgModel.coverUrl  = coverUrl;
    msgModel.imgW = coverImage.size.width;
    msgModel.imgH = coverImage.size.height;
    //将封面图片保存到本地
    [WLChatHelper storeImage:coverImage forKey:coverUrl];
    [self setConfig:msgModel userModel:userModel isSender:isSender];
    return msgModel;
}

#pragma mark - pravite
+ (void)setConfig:(WLChatMessageModel *)msgModel userModel:(WLChatUserModel *)userModel isSender:(BOOL)isSender {
    if (isSender) {
        msgModel.uid    = [WLChatUserModel shareInfo].uid;
        msgModel.name   = [WLChatUserModel shareInfo].name;
        msgModel.avatar = [WLChatUserModel shareInfo].avatar;
    }
    else {
        msgModel.uid    = userModel.uid;
        msgModel.name   = userModel.name;
        msgModel.avatar = userModel.avatar;
    }
    msgModel.sender  = isSender;
    msgModel.sendType  = WLMessageSendTypeWaiting;
    msgModel.timestmp  = [WLChatHelper nowTimestamp];
}

@end
