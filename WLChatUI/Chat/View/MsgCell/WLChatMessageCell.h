//
//  WLChatMessageCell.h
//  WLChat
//
//  Created by WangLei on 2018/9/4.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import "WLChatBaseCell.h"

@interface WLChatMessageCell : WLChatBaseCell {
    UILabel *_nickLabel;
    UIImageView *_avatarImageView;
    UIImageView *_bubbleImageView;
    UIActivityIndicatorView *_activityView;
    
    CGRect _contentRect;
}

@end
