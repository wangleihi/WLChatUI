//
//  WLInputBtn.m
//  WLChat
//
//  Created by WangLei on 2018/9/4.
//  Copyright © 2018年 WangLei. All rights reserved.
//

#import "WLInputBtn.h"

@interface WLInputBtn ()

@property (nonatomic, assign) WLInputBtnType type;

@end

@implementation WLInputBtn

+ (instancetype)chatButtonWithType:(WLInputBtnType)type{
    WLInputBtn *baseBtn = [super buttonWithType:UIButtonTypeCustom];
    if (baseBtn) {
        baseBtn.type = type;
    }
    return baseBtn;
}

//重设image的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.currentImage) {
        if (_type == WLInputBtnTypeTool) {
            //实际应用中要根据情况，返回所需的frame
            return CGRectMake(5, 5, 30, 30);
        }
        if (_type == WLInputBtnTypeMore) {
            //实际应用中要根据情况，返回所需的frame
            return CGRectMake(10, 15, 40, 40);
        }
    }
    return [super imageRectForContentRect:contentRect];
}

//重设title的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (_type == WLInputBtnTypeMore) {
        //实际应用中要根据情况，返回所需的frame
        return CGRectMake(0, 55, 60, 25);
    }
    return [super titleRectForContentRect:contentRect];
}

@end
