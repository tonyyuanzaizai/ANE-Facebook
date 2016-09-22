//
//  FBSDKGameRequestContent+Parser.h
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import <FBSDKShareKit/FBSDKShareKit.h>
#import "FlashRuntimeExtensions.h"

@interface FBSDKGameRequestContent (Parser)

+(FBSDKGameRequestContent*)parseFromFREObject:(FREObject) object;

-(NSString *)toString;

@end
