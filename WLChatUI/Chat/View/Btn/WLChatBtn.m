//
//  WLChatBtn.m
//  WLChat
//
//  Created by WangLei on 2018/9/4.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import "WLChatBtn.h"

@interface WLChatBtn ()

@property (nonatomic, assign) WLChatButtonType type;

@end

@implementation WLChatBtn

+ (instancetype)chatButtonWithType:(WLChatButtonType)type{
    WLChatBtn *baseBtn = [super buttonWithType:UIButtonTypeCustom];
    if (baseBtn) {
        baseBtn.type = type;
    }
    return baseBtn;
}

//重设image的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.currentImage) {
        if (_type == WLChatButtonTypeRetry) {
            //实际应用中要根据情况，返回所需的frame
            return CGRectMake(12.5, 12.5, 15, 15);
        }
    }
    return [super imageRectForContentRect:contentRect];
}

@end
