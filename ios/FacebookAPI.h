//
//  FacebookAPI.h
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import "FlashRuntimeExtensions.h"

void AirFacebookInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void AirFacebookFinalizer(void *extData);

void AirFacebookContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                                   uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void AirFacebookContextFinalizer(FREContext ctx);
