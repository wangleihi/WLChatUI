//
//  WLChatMessageModel.h
//  WLChat
//
//  Created by WangLei on 2018/9/3.
//  Copyright © 2018年 WangLei. All rights reserved.
//  消息详情

#import "WLChatBaseModel.h"

typedef enum : NSInteger {
    WLMessageTypeSystem = 0, //系统消息
    WLMessageTypeText,       //文本消息
    WLMessageTypeImage,      //图片消息
    WLMessageTypeVoice,      //声音消息
    WLMessageTypeVideo,      //视频消息
}WLMessageType;

typedef enum : NSInteger {
    WLMessageSendTypeWaiting = 0,//正在发送
    WLMessageSendTypeSuccess,    //发送成功
    WLMessageSendTypeFailed,     //发送失败
}WLMessageSendType;

@interface WLChatMessageModel : WLChatBaseModel

#pragma mark - 消息基本信息
///消息id
@property (nonatomic, strong) NSString *mid;
///发送人id
@property (nonatomic, strong) NSString *uid;
///发送人昵称
@property (nonatomic, strong) NSString *name;
///发送人头像
@property (nonatomic, strong) NSString *avatar;
///文本内容
@property (nonatomic, strong) NSString *message;
///是否是自己发送
@property (nonatomic, assign, getter=isSender) BOOL sender;
///是否已读
@property (nonatomic, assign ,getter=isRead) BOOL read;
///消息发送时间戳 <该字段参与数据排序, 不要修改字段名, 为了避开数据库关键字, 故意拼错>
@property (nonatomic, assign) NSInteger timestmp;
///消息类型
@property (nonatomic, assign) WLMessageType msgType;
///消息发送结果
@property (nonatomic, assign) WLMessageSendType sendType;
///缓存model宽, 优化列表滑动
@property (nonatomic, assign) NSInteger modelW;
///缓存model高, 优化列表滑动
@property (nonatomic, assign) NSInteger modelH;

#pragma mark - 图片消息
//图片宽高
@property (nonatomic, assign) NSInteger imgW;
@property (nonatomic, assign) NSInteger imgH;
//原图和缩略图
@property (nonatomic, strong) NSString *original;
@property (nonatomic, strong) NSString *thumbnail;

#pragma mark - 声音消息
//声音地址
@property (nonatomic, strong) NSString *voiceUrl;
//声音时长
@property (nonatomic, assign) NSInteger duration;

#pragma mark - 视频消息
//视频地址
@property (nonatomic, strong) NSString *videoUrl;
//视频封面地址
@property (nonatomic, strong) NSString *coverUrl;

#pragma mark - 消息的自定义处理
///缓存model尺寸
- (void)cacheModelSize;

///富文本
- (NSAttributedString *)attributedString;

@end
