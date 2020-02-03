//
//  WLChatGroupModel.h
//  WLChat
//
//  Created by WangLei on 2019/4/29.
//  Copyright © 2019 WangLei. All rights reserved.
//  聊天群

#import "WLChatBaseModel.h"

@interface WLChatGroupModel : WLChatBaseModel

///群id
@property (nonatomic, strong) NSString *gid;
///群昵称
@property (nonatomic, strong) NSString *name;
///群头像
@property (nonatomic, strong) NSString *avatar;
///聊天界面是否显示用户昵称
@property (nonatomic, assign, getter=isShowName) BOOL showName;

@end
