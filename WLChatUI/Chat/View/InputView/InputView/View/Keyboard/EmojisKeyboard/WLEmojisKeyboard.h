//
//  WLEmojisKeyboard.h
//  WLChat
//
//  Created by WangLei on 2018/9/5.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WLEmojisKeyboardDelegate;

@interface WLEmojisKeyboard : UIView

@property (nonatomic, weak) id<WLEmojisKeyboardDelegate> delegate;

@end

@protocol WLEmojisKeyboardDelegate <NSObject>

@optional
- (void)emojisKeyboardDidSelectSend:(WLEmojisKeyboard *)emojisKeyboard;
- (void)emojisKeyboardDidSelectDelete:(WLEmojisKeyboard *)emojisKeyboard;
- (void)emojisKeyboard:(WLEmojisKeyboard *)emojisKeyboard didSelectText:(NSString *)text;

@end
