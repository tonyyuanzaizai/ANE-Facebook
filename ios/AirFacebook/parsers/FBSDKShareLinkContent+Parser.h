//
//  FBSDKShareLinkContent+Parser.h
//  AirFacebook
//
//  Created by Ján Horváth on 18/09/15.
//
//

#import <FBSDKShareKit/FBSDKShareKit.h>
#import "FlashRuntimeExtensions.h"

@interface FBSDKShareLinkContent (Parser)

+(FBSDKShareLinkContent*)parseFromFREObject:(FREObject) object;

-(NSString *)toString;

@end
