//
//  WLMoreKeyboard.h
//  WLChat
//
//  Created by WangLei on 2018/9/5.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZNInputEnum.h"
@protocol WLMoreKeyboardDelegate;

@interface WLMoreKeyboard : UIView

@property (nonatomic, weak) id<WLMoreKeyboardDelegate> delegate;

@end

@protocol WLMoreKeyboardDelegate <NSObject>

@optional
- (void)moreKeyboard:(WLMoreKeyboard *)moreKeyboard didSelectType:(WZInputMoreType)type;

@end
