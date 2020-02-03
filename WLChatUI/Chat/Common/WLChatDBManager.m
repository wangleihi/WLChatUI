//
//  WLChatDBManager.m
//  WLChat
//
//  Created by WangLei on 2019/4/29.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLChatDBManager.h"
#import "WLChatSqliteManager.h"
#import "WLChatMessageModel.h"

NSString *const WL_USER    = @"WL_user";
NSString *const WL_GROUP   = @"WL_group";
NSString *const WL_SESSION = @"WL_session";

@implementation WLChatDBManager

+ (instancetype)DBManager {
    static WLChatDBManager *DBManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBManager = [[WLChatDBManager alloc] init];
    });
    return DBManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //输入框草稿
        _draftDic = [[NSMutableDictionary alloc] init];
        //创建三张表 <user, group, session>
        [[WLChatSqliteManager defaultManager] createTableName:WL_USER modelClass:[WLChatUserModel class]];
        [[WLChatSqliteManager defaultManager] createTableName:WL_GROUP modelClass:[WLChatGroupModel class]];
        [[WLChatSqliteManager defaultManager] createTableName:WL_SESSION modelClass:[WLChatSessionModel class]];
    }
    return self;
}

//草稿
- (NSString *)draftWithModel:(WLChatBaseModel *)model {
    NSString *key = [self tableNameWithModel:model];
    NSString *draft = [_draftDic objectForKey:key];
    if (draft == nil || ![draft isKindOfClass:[NSString class]]) {
        draft = @"";
    }
    return draft;
}

//删除草稿
- (void)removeDraftWithModel:(WLChatBaseModel *)model {
    NSString *key = [self tableNameWithModel:model];
    [_draftDic removeObjectForKey:key];
}

//保存草稿
- (void)setDraft:(NSString *)draft model:(WLChatBaseModel *)model {
    if (draft == nil || ![draft isKindOfClass:[NSString class]]) {
        draft = @"";
    }
    NSString *key = [self tableNameWithModel:model];
    [_draftDic setObject:draft forKey:key];
}

#pragma mark - user表操纵
//所有用户
- (NSMutableArray *)users {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",WL_USER];
    NSArray *list = [[WLChatSqliteManager defaultManager] selectWithSql:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dic in list) {
        WLChatUserModel *model = [WLChatUserModel modelWithDic:dic];
        [arr addObject:model];
    }
    return arr;
}

//添加用户
- (void)insertUserModel:(WLChatUserModel *)model {
    [[WLChatSqliteManager defaultManager] insertModel:model tableName:WL_USER];
}

//更新用户
- (void)updateUserModel:(WLChatUserModel *)model {
    [[WLChatSqliteManager defaultManager] updateModel:model tableName:WL_USER primkey:@"uid"];
}

//查询用户
- (WLChatUserModel *)selectUserModel:(NSString *)uid {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE uid = '%@'",WL_USER,uid];
    NSArray *list = [[WLChatSqliteManager defaultManager] selectWithSql:sql];
    if (list.count > 0) {
        WLChatUserModel *model = [WLChatUserModel modelWithDic:list.firstObject];
        return model;
    }
    return nil;
}

//删除用户
- (void)deleteUserModel:(NSString *)uid {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE uid = '%@'",WL_USER,uid];
    [[WLChatSqliteManager defaultManager] execute:sql];
    //同时删除对应的会话和消息记录
    [self deleteSessionModel:uid];
    [self deleteMessageWithUid:uid];
}

#pragma mark - group表操纵
//所有群
- (NSMutableArray *)groups {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",WL_GROUP];
    NSArray *list = [[WLChatSqliteManager defaultManager] selectWithSql:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dic in list) {
        WLChatGroupModel *model = [WLChatGroupModel modelWithDic:dic];
        [arr addObject:model];
    }
    return arr;
}

//添加群
- (void)insertGroupModel:(WLChatGroupModel *)model {
    [[WLChatSqliteManager defaultManager] insertModel:model tableName:WL_GROUP];
}

//更新群
- (void)updateGroupModel:(WLChatGroupModel *)model {
    [[WLChatSqliteManager defaultManager] updateModel:model tableName:WL_GROUP primkey:@"gid"];
}

//查询群
- (WLChatGroupModel *)selectGroupModel:(NSString *)gid {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE gid = '%@'",WL_GROUP,gid];
    NSArray *list = [[WLChatSqliteManager defaultManager] selectWithSql:sql];
    if (list.count > 0) {
        WLChatGroupModel *model = [WLChatGroupModel modelWithDic:list.firstObject];
        return model;
    }
    return nil;
}

//删除群
- (void)deleteGroupModel:(NSString *)gid {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE gid = '%@'",WL_GROUP,gid];
    [[WLChatSqliteManager defaultManager] execute:sql];
    //同时删除对应的会话和消息记录
    [self deleteSessionModel:gid];
    [self deleteMessageWithGid:gid];
}

#pragma mark - session表操纵
//所有会话
- (NSMutableArray *)sessions {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",WL_SESSION];
    NSArray *list = [[WLChatSqliteManager defaultManager] selectWithSql:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dic in list) {
        WLChatSessionModel *model = [WLChatSessionModel modelWithDic:dic];
        [arr addObject:model];
    }
    [arr sortUsingSelector:@selector(compareOtherModel:)];
    return arr;
}

//添加会话
- (void)insertSessionModel:(WLChatSessionModel *)model {
    [[WLChatSqliteManager defaultManager] insertModel:model tableName:WL_SESSION];
}

//更新会话
- (void)updateSessionModel:(WLChatSessionModel *)model {
    [[WLChatSqliteManager defaultManager] updateModel:model tableName:WL_SESSION primkey:@"sid"];
}

//查询私聊会话
- (WLChatSessionModel *)selectSessionModelWithUser:(WLChatUserModel *)userModel {
    return [self selectSessionModel:userModel];
}

//查询群聊会话
- (WLChatSessionModel *)selectSessionModelWithGroup:(WLChatGroupModel *)groupModel {
    return [self selectSessionModel:groupModel];
}

//private
- (WLChatSessionModel *)selectSessionModel:(WLChatBaseModel *)model {
    NSString *sid, *name, *avatar; BOOL isGroup;
    if ([model isKindOfClass:[WLChatUserModel class]]) {
        WLChatUserModel *user = (WLChatUserModel *)model;
        sid = user.uid;
        name = user.name;
        avatar = user.avatar;
        isGroup = NO;
    }
    else {
        WLChatGroupModel *group = (WLChatGroupModel *)model;
        sid = group.gid;
        name = group.name;
        avatar = group.avatar;
        isGroup = YES;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sid = '%@'",WL_SESSION,sid];
    NSArray *list = [[WLChatSqliteManager defaultManager] selectWithSql:sql];
    WLChatSessionModel *session;
    if (list.count > 0) {
        session = [WLChatSessionModel modelWithDic:list.firstObject];
    }
    else {
        //创建会话,并插入数据库
        session = [[WLChatSessionModel alloc] init];
        session.sid = sid;
        session.name = name;
        session.avatar = avatar;
        session.cluster = isGroup;
        [self insertSessionModel:session];
    }
    return session;
}

//删除会话
- (void)deleteSessionModel:(NSString *)sid {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE sid = '%@'",WL_SESSION,sid];
    [[WLChatSqliteManager defaultManager] execute:sql];
}

///查询会话对应的用户或者群聊
- (WLChatBaseModel *)selectChatModel:(WLChatSessionModel *)model {
    if (model.isCluster) {
        return [self selectGroupModel:model.sid];
    }
    else {
        return [self selectUserModel:model.sid];
    }
}

//查询会话对应的用户
- (WLChatUserModel *)selectChatUserModel:(WLChatSessionModel *)model {
    return [self selectUserModel:model.sid];
}

//查询会话对应的群聊
- (WLChatGroupModel *)selectChatGroupModel:(WLChatSessionModel *)model {
    return [self selectGroupModel:model.sid];
}

#pragma mark - message表操纵
//删除私聊消息记录
- (void)deleteMessageWithUid:(NSString *)uid {
    NSString *tableName = [self tableNameWithUid:uid];
    [[WLChatSqliteManager defaultManager] deleteTableName:tableName];
}

//删除群聊消息记录
- (void)deleteMessageWithGid:(NSString *)gid {
    NSString *tableName = [self tableNameWithUid:gid];
    [[WLChatSqliteManager defaultManager] deleteTableName:tableName];
}

//私聊消息
- (NSMutableArray *)messagesWithUser:(WLChatUserModel *)model {
    return [self messagesWithModel:model];
}

//群聊消息
- (NSMutableArray *)messagesWithGroup:(WLChatGroupModel *)model {
    return [self messagesWithModel:model];
}

//private
- (NSMutableArray *)messagesWithModel:(WLChatBaseModel *)model {
    NSString *tableName = [self tableNameWithModel:model];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY timestmp DESC LIMIT 100",tableName];
    NSArray *list = [[WLChatSqliteManager defaultManager] selectWithSql:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dic in list) {
        WLChatMessageModel *model = [WLChatMessageModel modelWithDic:dic];
        [arr insertObject:model atIndex:0];
    }
    return arr;
}

//插入私聊消息
- (void)insertMessage:(WLChatMessageModel *)message chatWithUser:(WLChatUserModel *)model {
    [self insertMessage:message chatWithModel:model];
}

//插入群聊消息
- (void)insertMessage:(WLChatMessageModel *)message chatWithGroup:(WLChatGroupModel *)model {
    [self insertMessage:message chatWithModel:model];
}

//private
- (void)insertMessage:(WLChatMessageModel *)message chatWithModel:(WLChatBaseModel *)model{
    WLChatSessionModel *session = [self selectSessionModel:model];
    session.lastMsg = message.message;
    session.lastTimestmp = message.timestmp;
    [self updateSessionModel:session];
    
    NSString *tableName = [self tableNameWithModel:model];
    [[WLChatSqliteManager defaultManager] createTableName:tableName modelClass:[message class]];
    [[WLChatSqliteManager defaultManager] insertModel:message tableName:tableName];
}

//更新私聊消息
- (void)updateMessageModel:(WLChatMessageModel *)message chatWithUser:(WLChatUserModel *)model {
    NSString *tableName = [self tableNameWithModel:model];
    [[WLChatSqliteManager defaultManager] updateModel:message tableName:tableName primkey:@"mid"];
}

//更新群聊消息
- (void)updateMessageModel:(WLChatMessageModel *)message chatWithGroup:(WLChatGroupModel *)model {
    NSString *tableName = [self tableNameWithModel:model];
    [[WLChatSqliteManager defaultManager] updateModel:message tableName:tableName primkey:@"mid"];
}

//删除私聊消息
- (void)deleteMessageModel:(WLChatMessageModel *)message chatWithUser:(WLChatUserModel *)model {
    NSString *tableName = [self tableNameWithModel:model];
    [[WLChatSqliteManager defaultManager] deleteModel:message tableName:tableName primkey:@"mid"];
}

//删除群聊消息
- (void)deleteMessageModel:(WLChatMessageModel *)message chatWithGroup:(WLChatGroupModel *)model {
    NSString *tableName = [self tableNameWithModel:model];
    [[WLChatSqliteManager defaultManager] deleteModel:message tableName:tableName primkey:@"mid"];
}

//private
- (NSString *)tableNameWithModel:(WLChatBaseModel *)model {
    if ([model isKindOfClass:[WLChatUserModel class]]) {
        WLChatUserModel *user = (WLChatUserModel *)model;
        return [self tableNameWithUid:user.uid];
    }
    else {
        WLChatGroupModel *group = (WLChatGroupModel *)model;
        return [self tableNameWithGid:group.gid];
    }
}

- (NSString *)tableNameWithUid:(NSString *)uid {
    return [NSString stringWithFormat:@"user_%@",uid];
}

- (NSString *)tableNameWithGid:(NSString *)gid {
    return [NSString stringWithFormat:@"group_%@",gid];
}

@end
