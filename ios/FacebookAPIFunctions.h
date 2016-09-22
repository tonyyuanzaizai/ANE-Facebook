//
//  FacebookAPIFunctions.h
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import "FlashRuntimeExtensions.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject fn(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

// C interface
DEFINE_ANE_FUNCTION(initFacebook);
DEFINE_ANE_FUNCTION(handleOpenURL);
DEFINE_ANE_FUNCTION(getAccessToken);
DEFINE_ANE_FUNCTION(getProfile);
DEFINE_ANE_FUNCTION(logInWithPermissions);
DEFINE_ANE_FUNCTION(logOut);
DEFINE_ANE_FUNCTION(requestWithGraphPath);

// Settings
DEFINE_ANE_FUNCTION(setDefaultAudience);
DEFINE_ANE_FUNCTION(setLoginBehavior);
DEFINE_ANE_FUNCTION(setDefaultShareDialogMode);

// Sharing dialogs
DEFINE_ANE_FUNCTION(canPresentShareDialog);
DEFINE_ANE_FUNCTION(shareLinkDialog);
DEFINE_ANE_FUNCTION(appInviteDialog);
DEFINE_ANE_FUNCTION(gameRequestDialog);
DEFINE_ANE_FUNCTION(shareOpenGraph);

// FB events
DEFINE_ANE_FUNCTION(activateApp);
DEFINE_ANE_FUNCTION(logEvent);

// Debug
DEFINE_ANE_FUNCTION(nativeLog);
DEFINE_ANE_FUNCTION(setNativeLogEnabled);
