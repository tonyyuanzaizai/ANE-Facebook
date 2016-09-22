//
//  FacebookAPIFunctions.m
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import <Foundation/Foundation.h>
#import "FacebookAPIFunctions.h"

#import "FREConversionUtil.h"
#import "AirFacebook.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "FBShareDelegate.h"
#import "FBAppInviteDialogDelegate.h"
#import "FBGameRequestDialogDelegate.h"

#import "FBSDKGameRequestContent+Parser.h"
#import "FBSDKAccessToken+Serializer.h"
#import "FBSDKProfile+Serializer.h"
#import "FBSDKShareLinkContent+Parser.h"
#import "FBSDKAppInviteContent+Parser.h"
#import "FBSDKShareOpenGraphContent+Parser.h"

DEFINE_ANE_FUNCTION(logInWithPermissions)
{
    NSArray *permissions = [FREConversionUtil toStringArray:argv[0]];
    NSString *type = [FREConversionUtil toString:argv[1]];
    
    [AirFacebook log:[NSString stringWithFormat:@"Trying to open session with %@ permissions: %@", type, [permissions componentsJoinedByString:@", "]]];
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    loginManager.loginBehavior = [[AirFacebook sharedInstance] loginBehavior];
    loginManager.defaultAudience = [[AirFacebook sharedInstance] defaultAudience];
    if([type isEqualToString:@"read"]){
        [loginManager logInWithReadPermissions:permissions fromViewController:nil handler: [AirFacebook openSessionCompletionHandler]];
    }else{
        [loginManager logInWithPublishPermissions:permissions fromViewController:nil handler: [AirFacebook openSessionCompletionHandler]];
    }
    
    return nil;
}

DEFINE_ANE_FUNCTION(nativeLog)
{
    NSString *message = [FREConversionUtil toString:argv[0]];
    
    // NOTE: logs from as3 should go only to native log
    [AirFacebook nativeLog:message withPrefix:@"AS3"];
    
    return nil;
}


DEFINE_ANE_FUNCTION(setNativeLogEnabled)
{
    BOOL nativeLogEnabled = [FREConversionUtil toBoolean:argv[0]];
    
    [[AirFacebook sharedInstance] setNativeLogEnabled:nativeLogEnabled];
    
    return nil;
}

DEFINE_ANE_FUNCTION(initFacebook)
{
    [AirFacebook log:@"initFacebook"];
    
    NSString *callback = [FREConversionUtil toString:argv[1]];
    
    [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:[NSMutableDictionary dictionary]];
    
    [[AirFacebook sharedInstance] dispatchEvent:[NSString stringWithFormat:@"SDKINIT_%@", callback] withMessage:nil];
    
    return nil;
}

DEFINE_ANE_FUNCTION(handleOpenURL)
{
    [AirFacebook log:@"handleOpenURL"];
    
    NSURL *url = [NSURL URLWithString:[FREConversionUtil toString:argv[0]]];
    NSString *sourceApplication = [FREConversionUtil toString:argv[1]];
    NSString *annotation = [FREConversionUtil toString:argv[2]];
    
    BOOL result = [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication]
                                                                 openURL:url
                                                       sourceApplication:sourceApplication
                                                              annotation:annotation];
    return [FREConversionUtil fromBoolean:result];
}

DEFINE_ANE_FUNCTION(getAccessToken)
{
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
 
    [AirFacebook log:@"getAccessToken token:%@", [token toString]];
    
    return [token toFREObject];
}

DEFINE_ANE_FUNCTION(getProfile)
{
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
 
    [AirFacebook log:@"getProfile profile:%@", [profile toString]];
    
    return [profile toFREObject];
}

DEFINE_ANE_FUNCTION(logOut)
{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    return nil;
}

DEFINE_ANE_FUNCTION(requestWithGraphPath)
{
    NSString *graphPath = [FREConversionUtil toString:argv[0]];
    NSDictionary *parameters = [FREConversionUtil toStringDictionaryFromKeys:argv[1] andValues:argv[2]];
    NSString *httpMethod = [FREConversionUtil toString:argv[3]];
    NSString *callback = [FREConversionUtil toString:argv[4]];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:graphPath parameters:parameters HTTPMethod:httpMethod]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (error){
                 
                 if (callback){
                     
                     NSDictionary* parsedResponseKey = [error.userInfo objectForKey:FBSDKGraphRequestErrorParsedJSONResponseKey];
                     if (parsedResponseKey && [parsedResponseKey objectForKey:@"body"])
                     {
                         NSDictionary* body = [parsedResponseKey objectForKey:@"body"];
                         NSError *jsonError = nil;
                         NSData *resultData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&jsonError];
                         if (jsonError)
                         {
                             [AirFacebook log:[NSString stringWithFormat:@"Request error -> JSON error: %@", [jsonError description]]];
                         } else
                         {
                             NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
                             [[AirFacebook sharedInstance] dispatchEvent:callback withMessage:resultString];
                         }
                     }
                     return;
                 }
                 
                 [AirFacebook log:[NSString stringWithFormat:@"Request error: %@", [error description]]];
                 
             }
             else{
                 
                 NSError *jsonError = nil;
                 NSData *resultData = [NSJSONSerialization dataWithJSONObject:result options:0 error:&jsonError];
                 if (jsonError)
                 {
                     [AirFacebook log:[NSString stringWithFormat:@"Request JSON error: %@", [jsonError description]]];
                 }
                 else
                 {
                     NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
                     [[AirFacebook sharedInstance] dispatchEvent:callback withMessage:resultString];
                 }
                 
             }
         }];
    }
    
    return nil;
}

DEFINE_ANE_FUNCTION(setDefaultAudience)
{
    NSUInteger defaultAudience = [FREConversionUtil toUInt:argv[0]];
    
    [AirFacebook log:@"defaultAudience value:%d", defaultAudience];
    [[AirFacebook sharedInstance] setDefaultAudience:defaultAudience];
    
    return nil;
}

DEFINE_ANE_FUNCTION(setLoginBehavior)
{
    NSUInteger loginBehavior = [FREConversionUtil toUInt:argv[0]];
    
    [AirFacebook log:@"setLoginBehavior value:%d", loginBehavior];
    [[AirFacebook sharedInstance] setLoginBehavior:loginBehavior];
    
    return nil;
}

DEFINE_ANE_FUNCTION(setDefaultShareDialogMode)
{
    NSUInteger defaultShareDialogMode = [FREConversionUtil toUInt:argv[0]];
    
    [AirFacebook log:@"defaultShareDialogMode value:%d", defaultShareDialogMode];
    [[AirFacebook sharedInstance] setDefaultShareDialogMode:defaultShareDialogMode];
    
    return nil;
}

DEFINE_ANE_FUNCTION(canPresentShareDialog)
{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.fromViewController = rootViewController;
    dialog.mode = [[AirFacebook sharedInstance] defaultShareDialogMode];
    BOOL canShow = [dialog canShow];
    
    return [FREConversionUtil fromBoolean:canShow];
}

DEFINE_ANE_FUNCTION(shareLinkDialog)
{
    FBSDKShareLinkContent *content = [FBSDKShareLinkContent parseFromFREObject:argv[0]];
    BOOL useShareApi = [FREConversionUtil toBoolean:argv[1]];
    NSString *callback = [FREConversionUtil toString:argv[2]];
    
    [AirFacebook log:@"shareLinkDialog content:%@ useShareApi:%@ callback:%@", [content toString], (useShareApi ? @"TRUE" : @"FALSE"), callback];
    [[AirFacebook sharedInstance] shareContent:content usingShareApi:useShareApi andCallback:callback];
    
    return nil;
}

DEFINE_ANE_FUNCTION(appInviteDialog)
{
    FBSDKAppInviteContent *content = [FBSDKAppInviteContent parseFromFREObject:argv[0]];
    NSString *callback = [FREConversionUtil toString:argv[1]];
    
    [AirFacebook log:@"appInviteDialog content:%@ callback:%@", [content toString], callback];
    [[AirFacebook sharedInstance] showAppInviteDialogWithContent:content andCallback:callback];
    
    return nil;
}

DEFINE_ANE_FUNCTION(gameRequestDialog)
{
    FBSDKGameRequestContent *content = [FBSDKGameRequestContent parseFromFREObject:argv[0]];
    NSString *callback = [FREConversionUtil toString:argv[1]];
    
    BOOL frictionlessRequestsEnabled = [FREConversionUtil toBoolean:argv[2]];
    [AirFacebook log:@"gameRequestDialog content:%@ callback:%@", [content toString], callback];
    [[AirFacebook sharedInstance] showGameRequestDialogWithContent:content andCallback:callback frictionlessRequestsEnabled:frictionlessRequestsEnabled];

    return nil;
}

DEFINE_ANE_FUNCTION(activateApp)
{
    [FBSDKAppEvents activateApp];
    return nil;
}

DEFINE_ANE_FUNCTION(logEvent)
{
    NSString *eventName = [FREConversionUtil toString:[FREConversionUtil getProperty:@"eventName" fromObject:argv[0]]];
    NSNumber *valueToSum = [FREConversionUtil toNumber:[FREConversionUtil getProperty:@"valueToSum" fromObject:argv[0]]];
    NSDictionary *parameters = [FREConversionUtil toDictionary:argv[0]];
    
    [AirFacebook log:@"logEvent name:%@", eventName];
    
    [FBSDKAppEvents logEvent:eventName valueToSum:[valueToSum doubleValue] parameters:parameters];
    return nil;
}

DEFINE_ANE_FUNCTION(shareOpenGraph)
{
    FBSDKShareOpenGraphContent *content = [FBSDKShareOpenGraphContent parseFromFREObject:argv[0]];
    BOOL useShareApi = [FREConversionUtil toBoolean:argv[1]];
    NSString *callback = [FREConversionUtil toString:argv[2]];
    
    [AirFacebook log:@"shareOpenGraph content:%@ useShareApi:%@ callback:%@", [content toString], (useShareApi ? @"TRUE" : @"FALSE"), callback];
    
    [[AirFacebook sharedInstance] shareContent:content usingShareApi:useShareApi andCallback:callback];
    
    return nil;
}

