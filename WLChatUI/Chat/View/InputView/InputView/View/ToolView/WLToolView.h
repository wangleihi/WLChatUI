//
//  WLToolView.h
//  WLKit_Example
//
//  Created by WangLei on 2019/7/22.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZNInputEnum.h"
@protocol WLToolViewDelegate;

@interface WLToolView : UIView

@property (nonatomic, weak) id<WLToolViewDelegate> delegate;

///还原btn状态
- (void)resetStatus;

@end

@protocol WLToolViewDelegate <NSObject>

@optional
- (void)toolView:(WLToolView *)toolView didSelectAtIndex:(NSInteger)index;
- (void)toolView:(WLToolView *)toolView showKeyboardType:(WLKeyboardType)type;
- (void)toolView:(WLToolView *)toolView didChangeRecordType:(WLRecordType)type;

@end
