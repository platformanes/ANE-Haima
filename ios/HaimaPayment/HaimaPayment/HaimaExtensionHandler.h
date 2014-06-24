//
//  DomodExtensionHandler.h
//  DomodOfferWall
//
//  Created by CZQ on 14-5-29.
//
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "HaimaTypeConversion.h"
#import "IPAYiAppPay.h"

#define DISPATCH_STATUS_EVENT(extensionContext, code, status) FREDispatchStatusEventAsync((extensionContext), (uint8_t*)code, (uint8_t*)status)


@interface HaimaExtensionHandler : NSObject<IPAYiAppPayPaymentDelegate, IPAYiAppPayLoginDelegate>{

}

//声明immobView
@property (nonatomic, assign) FREContext context;
@property (nonatomic, retain) HaimaTypeConversion *converter;


- (id)initWithContext:(FREContext)extensionContext;

//初始化海马助手
- (FREObject)initWithAppKey:(FREObject)freAppKey andAppId:(FREObject)freAppId;

//买买买买买!!!
- (FREObject)payWithOrderNo:(FREObject)freExOrderNo
                 andWaresId:(FREObject)freWaresId
               andNotifyUrl:(FREObject)freNotifyUrl
                   andPrice:(FREObject)frePrice
          andCppPrivateInfo:(FREObject)freCppPrivateInfo;

//登陆
- (FREObject)login;

@end
