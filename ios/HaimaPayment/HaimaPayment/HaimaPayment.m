/*
 * HaimaPayment.m
 * HaimaPayment
 *
 * Created by CZQ on 14-6-24.
 * Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
 */

#import "HaimaPayment.h"

HaimaExtensionHandler* handler;

/* HaimaPaymentExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void HaimaPaymentExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering HaimaPaymentExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &HaimaPaymentContextInitializer;
    *ctxFinalizerToSet = &HaimaPaymentContextFinalizer;

    NSLog(@"Exiting HaimaPaymentExtInitializer()");
}

/* HaimaPaymentExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void HaimaPaymentExtFinalizer(void* extData) 
{
    NSLog(@"Entering HaimaPaymentExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting HaimaPaymentExtFinalizer()");
    return;
}

/* HaimaPaymentContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void HaimaPaymentContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] = 
    {
        MAP_FUNCTION(init, NULL),
        MAP_FUNCTION(pay, NULL),
        MAP_FUNCTION(login, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    handler = [[HaimaExtensionHandler alloc]initWithContext:ctx];
    
    NSLog(@"Exiting ContextInitializer()");
}

/* HaimaPaymentContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void HaimaPaymentContextFinalizer(FREContext ctx)
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}


ANE_FUNCTION(init)
{
    return [handler initWithAppKey:argv[0] andAppId:argv[1]];
}
ANE_FUNCTION(pay)
{
    return [handler payWithOrderNo:argv[0] andWaresId:argv[1] andNotifyUrl:argv[2] andPrice:argv[3] andCppPrivateInfo:argv[4]];
}
ANE_FUNCTION(login)
{
    return [handler login];
}

