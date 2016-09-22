//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////
//

#import "AirFacebook.h"

#import "FBShareDelegate.h"
#import "FBAppInviteDialogDelegate.h"
#import "FBGameRequestDialogDelegate.h"

@implementation AirFacebook {
    
    NSMutableDictionary *shareActivities;
}

static AirFacebook *sharedInstance = nil;

+ (AirFacebook *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        shareActivities = [NSMutableDictionary dictionary];
        self.defaultShareDialogMode = FBSDKShareDialogModeAutomatic;
        self.defaultAudience = FBSDKDefaultAudienceFriends;
        self.loginBehavior = FBSDKLoginBehaviorNative;
    }
    return self;
}

// every time we have to send back information to the air application, invoque this method wich will dispatch an Event in air
- (void)dispatchEvent:(NSString *)event withMessage:(NSString *)message
{
    if(self.context != nil){
        NSString *eventName = event ? event : @"LOGGING";
        NSString *messageText = message ? message : @"";
        FREDispatchStatusEventAsync(self.context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[messageText UTF8String]);
    }
}

+ (void)log:(NSString *)format, ...
{
    @try
    {
        va_list args;
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        [AirFacebook as3Log:message];
        [AirFacebook nativeLog:message withPrefix:@"NATIVE"];
    }
    @catch (NSException *exception)
    {
        NSLog(@"[AirFacebook] Couldn't log message. Exception: %@", exception);
    }
}

+ (void)as3Log:(NSString *)message
{
    [[AirFacebook sharedInstance] dispatchEvent:@"LOGGING" withMessage:message];
}

+ (void)nativeLog:(NSString *)message withPrefix:(NSString *)prefix
{
    if ([[AirFacebook sharedInstance] isNativeLogEnabled]) {
        NSLog(@"[AirFacebook][%@] %@", prefix, message);
    }
}

// sharing

- (void)shareContent:(id<FBSDKSharingContent>)content usingShareApi:(BOOL)useShareApi andCallback:(NSString *)callback
{
    [AirFacebook log:@"share:usingShareApi:andShareCallback: callback: %@", callback];
    
    if (callback != nil){
        FBShareDelegate *delegate = [[FBShareDelegate alloc] initWithCallback:callback];
        [shareActivities setObject:delegate forKey:callback];
        [delegate shareContent:content usingShareApi:useShareApi];
    }
}

- (void)shareFinishedForCallback:(NSString *)callback
{
    [AirFacebook log:@"shareFinishedForCallback: callback: %@", callback];
    
    if (callback != nil){
        [shareActivities removeObjectForKey:callback];
    }
}

- (void)showAppInviteDialogWithContent:(FBSDKAppInviteContent *)content andCallback:(NSString *)callback
{
    [AirFacebook log:@"showAppInviteDialog:withCallback: callback: %@", callback];
    
    if(callback != nil){
        FBAppInviteDialogDelegate *delegate = [[FBAppInviteDialogDelegate alloc] initWithCallback:callback];
        [shareActivities setObject:delegate forKey:callback];
        [delegate showAppInviteDialogWithContent:content];
    }
}

- (void)showGameRequestDialogWithContent:(FBSDKGameRequestContent *)content andCallback:(NSString *)callback frictionlessRequestsEnabled:(BOOL)frictionlessRequestsEnabled
{
    [AirFacebook log:@"showGameRequestDialog:withCallback: callback: %@", callback];

    if(callback != nil){
        FBGameRequestDialogDelegate *delegate = [[FBGameRequestDialogDelegate alloc] initWithCallback:callback];
        [shareActivities setObject:delegate forKey:callback];
        [delegate showGameRequestDialogWithContent:content frictionlessRequestsEnabled:frictionlessRequestsEnabled];
    }
}

+ (NSString*) jsonStringFromObject:(id)obj andPrettyPrint:(BOOL) prettyPrint
{
    if(obj == nil){
        NSLog(@"jsonStringFromObject:andPrettyPrint: first argument was nil!");
        return @"[]";
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:(NSJSONWritingOptions) (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"jsonStringFromObject:andPrettyPrint: error: %@", error.localizedDescription);
        return @"[]";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (FBOpenSessionCompletionHandler)openSessionCompletionHandler
{
    return ^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error) {
            // Process error
            [AirFacebook log:@"Login error: (Error details : %@ )", error.description];
            [[AirFacebook sharedInstance] dispatchEvent:@"OPEN_SESSION_ERROR" withMessage:@"OK"];
        }
        else if (result.isCancelled) {
            // Handle cancellations
            [AirFacebook log:@"Login failed! User cancelled! (Error details : %@ )", error.description];
            [[AirFacebook sharedInstance] dispatchEvent:@"OPEN_SESSION_CANCEL" withMessage:@"OK"];
        }
        else {
            [AirFacebook log:@"Login success! grantedPermissions: %@ declinedPermissions: %@", result.grantedPermissions, result.declinedPermissions];
            [[AirFacebook sharedInstance] dispatchEvent:@"OPEN_SESSION_SUCCESS" withMessage:@"OK"];
        }
    };
}

@end