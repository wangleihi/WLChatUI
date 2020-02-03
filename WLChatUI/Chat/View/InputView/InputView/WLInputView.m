//
//  WLInputView.m
//  WLKit_Example
//
//  Created by WangLei on 2019/7/19.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import "WLInputView.h"
#import "WLInputHelper.h"
#import "WLToolView.h"
#import "WLEmojisKeyboard.h"
#import "WLMoreKeyboard.h"

@interface WLInputView ()<WLToolViewDelegate,WLEmojisKeyboardDelegate,WLMoreKeyboardDelegate>

@property (nonatomic, strong) WLToolView *inputToolView;
@property (nonatomic, strong) WLMoreKeyboard *moreKeyboard;
@property (nonatomic, strong) WLEmojisKeyboard *emojisKeyboard;

@end

@implementation WLInputView {
    UIView *_toolView;
    NSArray *_keyboards;
}

#pragma mark - 实现以下三个数据源方法, 供父类调用
//设置toolView和keyboards
- (UIView *)toolViewOfInputView {
    if (_toolView == nil) {
        _toolView = self.inputToolView;
    }
    return _toolView;
}

- (NSArray<UIView *> *)keyboardsOfInputView {
    if (_keyboards == nil) {
        _keyboards = @[self.emojisKeyboard,self.moreKeyboard];
    }
    return _keyboards;
}

///视图的初始y值, 一般放在屏幕的最下方, 即: 屏幕高度-toolView的高度
- (CGFloat)startYOfInputView {
    return [UIScreen mainScreen].bounds.size.height-self.inputToolView.bounds.size.height;
}

#pragma mark - 代理事件
//toolView
- (void)toolView:(WLToolView *)toolView didSelectAtIndex:(NSInteger)index {
    
}

- (void)toolView:(WLToolView *)toolView showKeyboardType:(WLKeyboardType)type {
    if (type == WLKeyboardTypeSystem) {
        [self showSystemKeyboard];
    }
    else if (type == WLKeyboardTypeEmoticon) {
        [self showKeyboardAtIndex:0 duration:0.3];
    }
    else if (type == WLKeyboardTypeMore) {
        [self showKeyboardAtIndex:1 duration:0.3];
    }
    else {
        [self dismissKeyboard];
    }
}

- (void)toolView:(WLToolView *)toolView didChangeRecordType:(WLRecordType)type {
    if ([self.delegate respondsToSelector:@selector(inputView:didChangeRecordType:)]) {
        [self.delegate inputView:self didChangeRecordType:type];
    }
}

//表情键盘
- (void)emojisKeyboardDidSelectSend:(WLEmojisKeyboard *)emojisKeyboard {
    //发送按钮
    [self sendText];
}

- (void)emojisKeyboardDidSelectDelete:(WLEmojisKeyboard *)emojisKeyboard {
    //删除键
    [self deleteSelectedText];
}

- (void)emojisKeyboard:(WLEmojisKeyboard *)emojisKeyboard didSelectText:(NSString *)text {
    //选择表情
    [self replaceSelectedTextWithText:text];
}

//more键盘
- (void)moreKeyboard:(WLMoreKeyboard *)moreKeyboard didSelectType:(WZInputMoreType)type {
    //点击按钮类型
    if ([self.delegate respondsToSelector:@selector(inputView:didSelectMoreType:)]) {
        [self.delegate inputView:self didSelectMoreType:type];
    }
}

#pragma mark - 父类回调事件
//点击return键
- (BOOL)shouldReturn {
    [self sendText];
    return NO;
}

///开始编辑
- (void)didBeginEditing {
    [self resetToolViewStatus];
}

///输入框值改变
- (void)valueDidChange {
    if ([self.delegate respondsToSelector:@selector(inputView:didChangeText:)]) {
        [self.delegate inputView:self didChangeText:self.text];
    }
}

///还原视图
- (void)willResetConfig {
    [self resetToolViewStatus];
}

///视图frameb改变
- (void)willChangeFrameWithDuration:(CGFloat)duration {
    if ([self.delegate respondsToSelector:@selector(inputView:willChangeFrameWithDuration:)]) {
        [self.delegate inputView:self willChangeFrameWithDuration:duration];
    }
}

#pragma mark - private method
///还原toolView上的btn状态
- (void)resetToolViewStatus {
    [self.inputToolView resetStatus];
}

///点击发送按钮, 包括系统键盘和自定义表情键盘的发送按钮
- (void)sendText {
    if (self.text.length == 0) return;
    if ([self.delegate respondsToSelector:@selector(inputView:sendMessage:)]) {
        [self.delegate inputView:self sendMessage:self.text];
    }
    self.text = @"";
}

#pragma mark - getter
- (WLToolView *)inputToolView {
    if (_inputToolView == nil) {
        _inputToolView = [[WLToolView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50+[WLInputHelper helper].iPhoneXBottomH)];
        _inputToolView.delegate = self;
        _inputToolView.backgroundColor = [UIColor colorWithRed:250/255. green:250/255. blue:250/255. alpha:1];
    }
    return _inputToolView;
}

- (WLEmojisKeyboard *)emojisKeyboard {
    if (_emojisKeyboard == nil) {
        _emojisKeyboard = [[WLEmojisKeyboard alloc] initWithFrame:CGRectMake(0, _toolView.bounds.size.height, self.bounds.size.width, 200+[WLInputHelper helper].iPhoneXBottomH)];
        _emojisKeyboard.delegate = self;
        _emojisKeyboard.hidden = YES;
        _emojisKeyboard.backgroundColor = [UIColor whiteColor];
    }
    return _emojisKeyboard;
}

- (WLMoreKeyboard *)moreKeyboard {
    if (_moreKeyboard == nil) {
        _moreKeyboard = [[WLMoreKeyboard alloc] initWithFrame:CGRectMake(0, _toolView.bounds.size.height, self.bounds.size.width, 200+[WLInputHelper helper].iPhoneXBottomH)];
        _moreKeyboard.delegate = self;
        _moreKeyboard.hidden = YES;
        _moreKeyboard.backgroundColor = [UIColor whiteColor];
    }
    return _moreKeyboard;
}

@end
