//
//  WLChatViewController.h
//  WLChat
//
//  Created by WangLei on 2018/9/4.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLChat.h"

@interface WLChatViewController : UIViewController

///选择用户进入聊天
- (instancetype)initWithUser:(WLChatUserModel *)userModel;

///选择群进入聊天
- (instancetype)initWithGroup:(WLChatGroupModel *)groupModel;

///选择会话进入聊天
- (instancetype)initWithSession:(WLChatSessionModel *)sessionModel;

@end
