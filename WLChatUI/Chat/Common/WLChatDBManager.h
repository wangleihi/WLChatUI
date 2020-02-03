//
//  WLChatDBManager.h
//  WLChat
//
//  Created by WangLei on 2019/4/29.
//  Copyright © 2019 WangLei. All rights reserved.
//  数据库操纵

#import <Foundation/Foundation.h>
#import "WLChatBaseModel.h"
#import "WLChatUserModel.h"
#import "WLChatGroupModel.h"
#import "WLChatSessionModel.h"
#import "WLChatMessageModel.h"

@interface WLChatDBManager : NSObject

///输入框草稿
@property (nonatomic, strong) NSMutableDictionary *draftDic;
///草稿
- (NSString *)draftWithModel:(WLChatBaseModel *)model;
///删除草稿
- (void)removeDraftWithModel:(WLChatBaseModel *)model;
///保存草稿
- (void)setDraft:(NSString *)draft model:(WLChatBaseModel *)model;

+ (instancetype)DBManager;

#pragma mark - user表操纵
///所有用户
- (NSMutableArray *)users;
///添加用户
- (void)insertUserModel:(WLChatUserModel *)model;
///更新用户
- (void)updateUserModel:(WLChatUserModel *)model;
///查询用户
- (WLChatUserModel *)selectUserModel:(NSString *)uid;
///删除用户
- (void)deleteUserModel:(NSString *)uid;

#pragma mark - group表操纵
///所有群
- (NSMutableArray *)groups;
///添加群
- (void)insertGroupModel:(WLChatGroupModel *)model;
///更新群
- (void)updateGroupModel:(WLChatGroupModel *)model;
///查询群
- (WLChatGroupModel *)selectGroupModel:(NSString *)gid;
///删除群
- (void)deleteGroupModel:(NSString *)gid;

#pragma mark - session表操纵
///所有会话
- (NSMutableArray *)sessions;
///添加会话
- (void)insertSessionModel:(WLChatSessionModel *)model;
///更新会话
- (void)updateSessionModel:(WLChatSessionModel *)model;
///查询私聊会话
- (WLChatSessionModel *)selectSessionModelWithUser:(WLChatUserModel *)userModel;
///查询群聊会话
- (WLChatSessionModel *)selectSessionModelWithGroup:(WLChatGroupModel *)groupModel;
///删除会话
- (void)deleteSessionModel:(NSString *)sid;
///查询会话对应的用户或者群聊
- (WLChatBaseModel *)selectChatModel:(WLChatSessionModel *)model;
///查询会话对应的用户
- (WLChatUserModel *)selectChatUserModel:(WLChatSessionModel *)model;
///查询会话对应的群聊
- (WLChatGroupModel *)selectChatGroupModel:(WLChatSessionModel *)model;

#pragma mark - message表操纵
///删除私聊消息记录
- (void)deleteMessageWithUid:(NSString *)uid;
///删除群聊消息记录
- (void)deleteMessageWithGid:(NSString *)gid;
//私聊消息列表
- (NSMutableArray *)messagesWithUser:(WLChatUserModel *)model;
//群聊消息列表
- (NSMutableArray *)messagesWithGroup:(WLChatGroupModel *)model;
///插入私聊消息
- (void)insertMessage:(WLChatMessageModel *)message chatWithUser:(WLChatUserModel *)model;
///插入群聊消息
- (void)insertMessage:(WLChatMessageModel *)message chatWithGroup:(WLChatGroupModel *)model;
///更新私聊消息
- (void)updateMessageModel:(WLChatMessageModel *)message chatWithUser:(WLChatUserModel *)model;
///更新群聊消息
- (void)updateMessageModel:(WLChatMessageModel *)message chatWithGroup:(WLChatGroupModel *)model;
///删除私聊消息
- (void)deleteMessageModel:(WLChatMessageModel *)message chatWithUser:(WLChatUserModel *)model;
///删除群聊消息
- (void)deleteMessageModel:(WLChatMessageModel *)message chatWithGroup:(WLChatGroupModel *)model;

@end
