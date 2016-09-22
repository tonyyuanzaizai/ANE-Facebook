//
//  FacebookAPI.m
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import <Foundation/Foundation.h>
#import "FacebookAPI.h"
#import "FacebookAPIFunctions.h"
#import "AirFacebook.h"

void AirFacebookInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AirFacebookContextInitializer;
    *ctxFinalizerToSet = &AirFacebookContextFinalizer;
}

void AirFacebookFinalizer(void *extData)
{
}

void AirFacebookContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                                   uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSDictionary *functions = @{
                                @"initFacebook":                    [NSValue valueWithPointer:&initFacebook],
                                @"handleOpenURL":                   [NSValue valueWithPointer:&handleOpenURL],
                                @"getAccessToken":                  [NSValue valueWithPointer:&getAccessToken],
                                @"getProfile":                      [NSValue valueWithPointer:&getProfile],
                                @"logInWithPermissions":            [NSValue valueWithPointer:&logInWithPermissions],
                                @"logOut":                          [NSValue valueWithPointer:&logOut],
                                @"requestWithGraphPath":            [NSValue valueWithPointer:&requestWithGraphPath],
                                
                                // Settings
                                @"setDefaultShareDialogMode":       [NSValue valueWithPointer:&setDefaultShareDialogMode],
                                @"setLoginBehavior":                [NSValue valueWithPointer:&setLoginBehavior],
                                @"setDefaultAudience":              [NSValue valueWithPointer:&setDefaultAudience],
                                
                                // Sharing dialogs
                                @"canPresentShareDialog":           [NSValue valueWithPointer:&canPresentShareDialog],
                                @"shareLinkDialog":                 [NSValue valueWithPointer:&shareLinkDialog],
                                @"appInviteDialog":                 [NSValue valueWithPointer:&appInviteDialog],
                                @"gameRequestDialog":               [NSValue valueWithPointer:&gameRequestDialog],
                                @"shareOpenGraph":                  [NSValue valueWithPointer:&shareOpenGraph],
                                
                                // FB events
                                @"activateApp":                     [NSValue valueWithPointer:&activateApp],
                                @"logEvent":                        [NSValue valueWithPointer:&logEvent],
                                
                                // Debug
                                @"nativeLog":                       [NSValue valueWithPointer:&nativeLog],
                                @"setNativeLogEnabled":             [NSValue valueWithPointer:&setNativeLogEnabled],
                                };
    
    *numFunctionsToTest = (uint32_t)[functions count];
    
    FRENamedFunction *func = (FRENamedFunction *)malloc(sizeof(FRENamedFunction) * [functions count]);
    
    uint32_t i = 0;
    for (NSString* functionName in functions){
        NSValue *value = functions[functionName];
        
        func[i].name = (const uint8_t *)[functionName UTF8String];
        func[i].functionData = NULL;
        func[i].function = [value pointerValue];
        i++;
    }
    
    *functionsToSet = func;
    
    [[AirFacebook sharedInstance] setContext:ctx];
}

void AirFacebookContextFinalizer(FREContext ctx)
{
}
