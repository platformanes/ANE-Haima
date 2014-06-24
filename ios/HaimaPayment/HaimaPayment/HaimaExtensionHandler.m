//
//  DomodExtensionHandler.m
//  DomodOfferWall
//
//  Created by CZQ on 14-5-29.
//
//

#import "HaimaExtensionHandler.h"

@implementation HaimaExtensionHandler

@synthesize context;
@synthesize converter;

#pragma mark -

- (id)initWithContext:(FREContext)extensionContext
{
    self = [super init];
    if (self) {
        self.context = extensionContext;
        self.converter = [[[HaimaTypeConversion alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc {
    self.context = nil;
    self.converter = nil;
    [super dealloc];
}


#pragma mark - Manager Delegate

- (void)paymentStatusCode: (IPAYiAppPayPaymentStatusCodeType)statusCode
                signature: (NSString *)signature
               resultInfo: (NSString *)resultInfo
{
    if(statusCode == IPAY_PAYMENT_SUCCESS)
    {
        if([[IPAYiAppPay sharediAppPay] verifyPaymentSignature:signature withAppKey:nil])
        {
//            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                 message:@"支付成功！"
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"确定"
//                                                       otherButtonTitles:nil];
//            [alertView show];
            DISPATCH_STATUS_EVENT(self.context, [@"IPAY_PAYMENT_SUCCESS" UTF8String], [@"支付成功" UTF8String]);

        }
        else
        {
//            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                 message:@"支付成功,验签失败！"
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"确定"
//                                                       otherButtonTitles:nil];
//            [alertView show];
            DISPATCH_STATUS_EVENT(self.context, [@"IPAY_PAYMENT_SUCCESS" UTF8String], [@"VerifyFail" UTF8String]);
        }
    }
    else if(statusCode == IPAY_PAYMENT_CANCELED)
    {
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                             message:@"支付失败，用户取消支付！"
//                                                            delegate:nil
//                                                   cancelButtonTitle:@"确定"
//                                                   otherButtonTitles:nil];
//        [alertView show];
        DISPATCH_STATUS_EVENT(self.context, [@"IPAY_PAYMENT_CANCELED" UTF8String], [@"支付失败，用户取消支付" UTF8String]);
    }
    else
    {
        //        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
        //                                                             message:@"支付失败！"
        //                                                            delegate:nil
        //                                                   cancelButtonTitle:@"确定"
        //                                                   otherButtonTitles:nil];
        //        [alertView show];
        DISPATCH_STATUS_EVENT(self.context, [@"IPAY_PAYMENT_FAILED" UTF8String], [@"支付失败" UTF8String]);
    }
}

#pragma mark - IPAYiAppPayLoginDelegate

- (void)loginDidSuccessWithUserName: (NSString *)userName
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:[NSString stringWithFormat:@"登录成功！用户名：%@", userName]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//    [alertView show];
    DISPATCH_STATUS_EVENT(self.context, [@"IPAY_LOGIN_SUCCESS" UTF8String], [userName UTF8String]);

}

#pragma main function

//初始化海马助手
- (FREObject)initWithAppKey:(FREObject)freAppKey andAppId:(FREObject)freAppId
{
    NSString *appkey;
    if ([self.converter FREGetObject:freAppKey asString:&appkey] != FRE_OK)
    {
        return NULL;
    }
    NSString *appid;
    if ([self.converter FREGetObject:freAppId asString:&appid] != FRE_OK)
    {
        return NULL;
    }
    
    [[IPAYiAppPay sharediAppPay] initializeWithAppKey: appkey
                                             andAppID: appid
                                           andWaresID: 1
                                     andUIOrientation: UIInterfaceOrientationPortrait
                                        andCPDelegate: nil];

    return NULL;
}

//买买买买买!!!
- (FREObject)payWithOrderNo:(FREObject)freExOrderNo
                 andWaresId:(FREObject)freWaresId
               andNotifyUrl:(FREObject)freNotifyUrl
                   andPrice:(FREObject)frePrice
          andCppPrivateInfo:(FREObject)freCppPrivateInfo
{
    NSString *exOrderNo;
    if ([self.converter FREGetObject:freExOrderNo asString:&exOrderNo] != FRE_OK)
    {
        return NULL;
    }
    NSString *notifyUrl;
    if ([self.converter FREGetObject:freNotifyUrl asString:&notifyUrl] != FRE_OK)
    {
        notifyUrl = nil;
    }
    NSString *cppPrivateInfo;
    if ([self.converter FREGetObject:freCppPrivateInfo asString:&cppPrivateInfo] != FRE_OK)
    {
        cppPrivateInfo = nil;
    }
    NSInteger waresId =  [self.converter FREGetObjectAsInteger:freWaresId];
    NSInteger price =  [self.converter FREGetObjectAsInteger:frePrice];
    IPAYiAppPayOrder* iAppPayOrder = [[IPAYiAppPayOrder alloc] init];
    iAppPayOrder.exorderno = exOrderNo;
    iAppPayOrder.waresid = waresId;
    iAppPayOrder.notifyurl = notifyUrl;
    iAppPayOrder.price = price;
    iAppPayOrder.cppprivateinfo = cppPrivateInfo;
    
    NSString * orderSignature = [[IPAYiAppPay sharediAppPay] getOrderSignature: iAppPayOrder
                                                                     withAppID: nil
                                                                     andAppKey: nil];
    
    [[IPAYiAppPay sharediAppPay] checkoutWithOrder:iAppPayOrder
                                 andOrderSignature:orderSignature
                                andPaymentDelegate:self];
    return NULL;
}

//登陆
- (FREObject)login
{
    IPAYiAppPay *appPay = [IPAYiAppPay sharediAppPay];
    [appPay showLoginViewWithIsForced: NO andLoginDelegate: self];
    return NULL;
}


@end
