//
//  IPAYAppPay.h
//  IAppPayDemo1
//
//  Created by iapppay on 13-6-25.
//  Copyright (c) 2013年 Kong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPAYiAppPayOrder.h"

@protocol IPAYiAppPayContentProviderDelegate <NSObject>
@optional
- (void)getStatusInitialized;

@end


@protocol IPAYiAppPayLoginDelegate <NSObject>
@optional
- (void)loginDidSuccessWithUserName: (NSString *)userName;
- (void)loginDidFail;
- (void)loginDidCancel;

@end

typedef enum IPAYiAppPayPaymentStatusCodeType: NSInteger {
    IPAY_PAYMENT_CANCELED = 99,
    IPAY_PAYMENT_FAILED = -1,
    IPAY_PAYMENT_SUCCESS = 0
} IPAYiAppPayPaymentStatusCodeType;

@protocol IPAYiAppPayPaymentDelegate <NSObject>
@optional
- (void)paymentStatusCode: (IPAYiAppPayPaymentStatusCodeType)statusCode
                signature: (NSString *)signature
               resultInfo: (NSString *)resultInfo;

@end

@interface IPAYiAppPay : NSObject

@property (nonatomic, weak) id<IPAYiAppPayContentProviderDelegate> cpDelegate;
@property (nonatomic, weak) id<IPAYiAppPayLoginDelegate> loginDelegate;
@property (nonatomic, weak) id<IPAYiAppPayPaymentDelegate> payDelegate;

// called in - (BOOL)application: didFinishLaunchingWithOptions:
+ (IPAYiAppPay *)sharediAppPay;

- (void)initializeWithAppKey: (NSString *) iappKey
                    andAppID: (NSString *) iappID
                  andWaresID: (NSUInteger) waresid
            andUIOrientation: (UIInterfaceOrientation) supportedOrientation
               andCPDelegate: (id<IPAYiAppPayContentProviderDelegate>) delegate;


// called in - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
- (void)handleOpenurl: (NSURL *) url;

- (void)showLoginViewWithIsForced:(BOOL)isForcedLogin
                 andLoginDelegate:(id<IPAYiAppPayLoginDelegate>)delegate;

- (NSString *)getOrderSignature: (IPAYiAppPayOrder *) order
                      withAppID: (NSString *)iappID
                      andAppKey: (NSString *)iappKey;

- (void)checkoutWithOrder: (IPAYiAppPayOrder *)order
        andOrderSignature: (NSString *) orderSign
       andPaymentDelegate: (id<IPAYiAppPayPaymentDelegate>)delegate;

- (BOOL)verifyPaymentSignature: (NSString *) paySign withAppKey: (NSString *)iappKey;

@end
