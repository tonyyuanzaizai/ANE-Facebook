//
//  FBSDKAppInviteContent+Parser.m
//  AirFacebook
//
//  Created by Ján Horváth on 18/09/15.
//
//

#import "FBSDKAppInviteContent+Parser.h"
#import "FREConversionUtil.h"

@implementation FBSDKAppInviteContent (Parser)

+(FBSDKAppInviteContent*)parseFromFREObject:(FREObject) object
{
    NSString *appLinkUrl = [FREConversionUtil toString:[FREConversionUtil getProperty:@"appLinkUrl" fromObject:object]];
    NSString *previewImageUrl = [FREConversionUtil toString:[FREConversionUtil getProperty:@"previewImageUrl" fromObject:object]];
    
    FBSDKAppInviteContent *content = [[FBSDKAppInviteContent alloc] init];
    
    if(appLinkUrl != nil) content.appLinkURL = [NSURL URLWithString:appLinkUrl];
    if(previewImageUrl != nil) content.appInvitePreviewImageURL = [NSURL URLWithString:previewImageUrl];
    
    return content;
}

-(NSString *)toString
{
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKAppInviteContent appLinkUrl:'%@' previewImageUrl:'%@']",
                        self.appLinkURL,
                        self.appInvitePreviewImageURL
                        ];
    return result;
}

@end
