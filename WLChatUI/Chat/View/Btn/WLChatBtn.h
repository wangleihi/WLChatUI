//
//  WLChatBtn.h
//  WLChat
//
//  Created by WangLei on 2018/9/4.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WLChatButtonTypeNormal = 0,   //系统默认类型
    WLChatButtonTypeRetry,        //重发消息按钮
}WLChatButtonType;

@interface WLChatBtn : UIButton

+ (instancetype)chatButtonWithType:(WLChatButtonType)type;

@end
