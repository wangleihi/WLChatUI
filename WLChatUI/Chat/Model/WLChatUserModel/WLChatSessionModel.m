//
//  WLChatSessionModel.m
//  WLChat
//
//  Created by WangLei on 2019/4/29.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLChatSessionModel.h"

@implementation WLChatSessionModel

///时间戳排序
- (NSComparisonResult)compareOtherModel:(WLChatSessionModel *)model {
    return self.lastTimestmp < model.lastTimestmp;
}

@end
