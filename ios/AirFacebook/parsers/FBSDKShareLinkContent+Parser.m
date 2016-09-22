//
//  FBSDKShareLinkContent+Parser.m
//  AirFacebook
//
//  Created by Ján Horváth on 18/09/15.
//
//

#import "FBSDKShareLinkContent+Parser.h"
#import "FREConversionUtil.h"

@implementation FBSDKShareLinkContent (Parser)

+(FBSDKShareLinkContent*)parseFromFREObject:(FREObject) object
{
    NSString *contentUrl = [FREConversionUtil toString:[FREConversionUtil getProperty:@"contentUrl" fromObject:object]];
    NSArray *peopleIds = [FREConversionUtil toStringArray:[FREConversionUtil getProperty:@"peopleIds" fromObject:object]];
    NSString *placeId = [FREConversionUtil toString:[FREConversionUtil getProperty:@"placeId" fromObject:object]];
    NSString *ref = [FREConversionUtil toString:[FREConversionUtil getProperty:@"ref" fromObject:object]];
    NSString *contentTitle = [FREConversionUtil toString:[FREConversionUtil getProperty:@"contentTitle" fromObject:object]];
    NSString *contentDescription = [FREConversionUtil toString:[FREConversionUtil getProperty:@"contentDescription" fromObject:object]];
    NSString *imageUrl = [FREConversionUtil toString:[FREConversionUtil getProperty:@"imageUrl" fromObject:object]];

    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    if(contentUrl != nil) content.contentURL = [NSURL URLWithString:contentUrl];
    if(peopleIds != nil) content.peopleIDs = peopleIds;
    if(placeId != nil) content.placeID = placeId;
    if(ref != nil) content.ref = ref;
    if(contentTitle != nil) content.contentTitle = contentTitle;
    if(contentDescription != nil) content.contentDescription = contentDescription;
    if(imageUrl != nil) content.imageURL = [NSURL URLWithString:imageUrl];
    
    return content;
}

-(NSString *)toString
{
    NSString *peopleIds = [self.peopleIDs componentsJoinedByString:@","];
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKShareLinkContent contentUrl:'%@' peopleIds:'%@' placeId:'%@' ref:'%@' contentTitle:'%@' contentDescription:'%@' imageUrl:'%@']",
                        self.contentURL,
                        peopleIds != nil ? [NSString stringWithFormat:@"[%@]", peopleIds] : nil,
                        self.placeID,
                        self.ref,
                        self.contentTitle,
                        self.contentDescription,
                        self.imageURL
                        ];
    return result;
}

@end
