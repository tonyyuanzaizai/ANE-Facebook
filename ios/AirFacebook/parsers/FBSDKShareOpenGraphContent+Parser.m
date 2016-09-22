//
//  FBSDKShareOpenGraphContent+Parser.m
//  AirFacebook
//
//  Created by Ján Horváth on 22/09/15.
//
//

#import "FBSDKShareOpenGraphContent+Parser.h"
#import "FREConversionUtil.h"
#import "FBSDKShareOpenGraphAction+Parser.h"

@implementation FBSDKShareOpenGraphContent (Parser)

+(FBSDKShareOpenGraphContent*)parseFromFREObject:(FREObject) object
{
    NSString *contentUrl = [FREConversionUtil toString:[FREConversionUtil getProperty:@"contentUrl" fromObject:object]];
    NSArray *peopleIds = [FREConversionUtil toStringArray:[FREConversionUtil getProperty:@"peopleIds" fromObject:object]];
    NSString *placeId = [FREConversionUtil toString:[FREConversionUtil getProperty:@"placeId" fromObject:object]];
    NSString *ref = [FREConversionUtil toString:[FREConversionUtil getProperty:@"ref" fromObject:object]];
    
    NSString *previewPropertyName = [FREConversionUtil toString:[FREConversionUtil getProperty:@"previewPropertyName" fromObject:object]];
    FBSDKShareOpenGraphAction *action = [FBSDKShareOpenGraphAction parseFromFREObject:[FREConversionUtil getProperty:@"action" fromObject:object]];
    
    FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
    
    if(contentUrl != nil) content.contentURL = [NSURL URLWithString:contentUrl];
    if(peopleIds != nil) content.peopleIDs = peopleIds;
    if(placeId != nil) content.placeID = placeId;
    if(ref != nil) content.ref = ref;
    
    if(previewPropertyName != nil) content.previewPropertyName = previewPropertyName;
    if(action != nil) content.action = action;
    
    return content;
}

-(NSString *)toString
{
    NSString *peopleIds = [self.peopleIDs componentsJoinedByString:@","];
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKShareOpenGraphContent contentUrl:'%@' peopleIds:'%@' placeId:'%@' ref:'%@' previewPropertyName:'%@' action:'%@']",
                        self.contentURL,
                        peopleIds != nil ? [NSString stringWithFormat:@"[%@]", peopleIds] : nil,
                        self.placeID,
                        self.ref,
                        self.previewPropertyName,
                        [self.action toString]
                        ];
    return result;
}

@end
