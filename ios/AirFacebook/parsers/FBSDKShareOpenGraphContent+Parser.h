//
//  FBSDKShareOpenGraphContent+Parser.h
//  AirFacebook
//
//  Created by Ján Horváth on 22/09/15.
//
//

#import <FBSDKShareKit/FBSDKShareKit.h>
#import "FlashRuntimeExtensions.h"

@interface FBSDKShareOpenGraphContent (Parser)

+(FBSDKShareOpenGraphContent*)parseFromFREObject:(FREObject) object;

-(NSString *)toString;

@end
