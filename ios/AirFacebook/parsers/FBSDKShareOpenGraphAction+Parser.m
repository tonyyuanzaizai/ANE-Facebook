//
//  FBSDKShareOpenGraphAction+Parser.m
//  AirFacebook
//
//  Created by Ján Horváth on 22/09/15.
//
//

#import "FBSDKShareOpenGraphAction+Parser.h"
#import "FREConversionUtil.h"
#import "FBSDKShareOpenGraphObject+Parser.h";

@implementation FBSDKShareOpenGraphAction (Parser)

+(FBSDKShareOpenGraphAction*)parseFromFREObject:(FREObject) object
{
    NSDictionary *dictionary = [FREConversionUtil toDictionary:object];
    if(dictionary == nil){
        return nil;
    }
    
    NSString *type = [dictionary objectForKey:@"og:type"];
    
    //[AirFacebook log:@"FBSDKShareOpenGraphAction parseFromFREObject: %@", dictionary];
    
    FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
    action.actionType = type;
    [action parseProperties:dictionary];
    
    // FIXME: FBSDKShareUtility.m:144 checks for "type" instead of "og:type" which crash in FBSDKShareOpenGraphValueContainer.m:90 (FBSDKShareUtility.m:95) with "Open Graph keys must be namespaced:"
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *properties = (NSDictionary *)value;
            
            if ([FBSDKShareOpenGraphAction stringValue:properties[@"og:type"]]) {
                FBSDKShareOpenGraphObject *object = [FBSDKShareOpenGraphObject objectWithProperties:properties];
                [action setObject:object forKey:key];
            }
        }
    }];
    
    return action;
}

-(NSString *)toString
{
    NSString *properties = @"[";
    for(NSString *aKey in [self keyEnumerator]) {
        id value = [self valueForKey:aKey];
        if([value isKindOfClass:[FBSDKShareOpenGraphObject class]]){
            FBSDKShareOpenGraphObject *object = (FBSDKShareOpenGraphObject *)value;
            properties = [properties stringByAppendingFormat:@"%@:'%@' ", aKey, [object toString]];
        } else {
            properties = [properties stringByAppendingFormat:@"%@:'%@' ", aKey, value];
        }
    }
    properties = [properties stringByAppendingString:@"]"];
    
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKShareOpenGraphAction actionType:'%@' *properties:'%@']",
                        self.actionType,
                        properties
                        ];
    
    return result;
}

+ (NSString *)stringValue:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object stringValue];
    } else if ([object isKindOfClass:[NSURL class]]) {
        return [(NSURL *)object absoluteString];
    } else {
        return nil;
    }
}

@end
