//
//  WLChatBaseCell.h
//  WLChat
//
//  Created by WangLei on 2019/1/15.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLChatMessageModel.h"

@interface WLChatBaseCell : UITableViewCell

///系统消息 - 比如：时间消息等
- (void)setConfig:(WLChatMessageModel *)model;

///其他消息 - 比如：文本、图片消息等
- (void)setConfig:(WLChatMessageModel *)model isShowName:(BOOL)isShowName;

@end
