//
//  WLInputView.h
//  WLKit_Example
//
//  Created by WangLei on 2019/7/19.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLBaseInputView.h"
#import "WZNInputEnum.h"
@protocol WLInputViewDelegate;

@interface WLInputView : WLBaseInputView

@property (nonatomic, weak) id<WLInputViewDelegate> delegate;

@end

@protocol WLInputViewDelegate <NSObject>

@optional
///文本变化
- (void)inputView:(WLInputView *)inputView didChangeText:(NSString *)text;
///发送文本消息
- (void)inputView:(WLInputView *)inputView sendMessage:(NSString *)message;
///自定义键盘点击事件
- (void)inputView:(WLInputView *)inputView didSelectMoreType:(WZInputMoreType)type;
///录音状态变化
- (void)inputView:(WLInputView *)inputView didChangeRecordType:(WLRecordType)type;
///输入框frame改变
- (void)inputView:(WLInputView *)inputView willChangeFrameWithDuration:(CGFloat)duration;

@end
