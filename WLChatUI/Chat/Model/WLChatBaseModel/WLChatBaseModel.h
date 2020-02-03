//
//  WLChatBaseModel.h
//  WLChat
//
//  Created by WangLei on 2019/4/26.
//  Copyright © 2019 WangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLChatBaseModel : NSObject<NSCoding>

///将字典转化为model
+ (instancetype)modelWithDic:(NSDictionary *)dic;

///将model转化为字典
- (NSDictionary *)transfromDictionary;

///获取类的所有属性名称与类型, 使用WLChatBaseModel的子类调用
+ (NSArray *)allPropertyName;

///解档
+ (instancetype)chat_unarchiveObjectWithData:(NSData *)data;

@end

@interface NSData (WLChatBaseModel)

///归档
+ (NSData *)chat_archivedDataWithModel:(WLChatBaseModel *)model;

@end
