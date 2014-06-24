//
//  IPAYPayment.h
//  IAppPayDemo1
//
//  Created by iapppay on 13-6-25.
//  Copyright (c) 2013年 Kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAYiAppPayOrder : NSObject

@property (nonatomic, copy) NSString * exorderno;
@property NSUInteger waresid;
@property NSUInteger price;
@property NSUInteger quantity;
@property (nonatomic, copy) NSString * cppprivateinfo;
@property (nonatomic, copy) NSString * notifyurl;

- (NSString *)getOrderStringWithAppID: (NSString *)iappID;

@end