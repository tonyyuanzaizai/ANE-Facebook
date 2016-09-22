//
//  FBSDKShareOpenGraphObject+Parser.m
//  AirFacebook
//
//  Created by Ján Horváth on 23/09/15.
//
//

#import "FBSDKShareOpenGraphObject+Parser.h"

@implementation FBSDKShareOpenGraphObject (Parser)

-(NSString *)toString
{
    NSString *properties = @"[";
    for(NSString *aKey in [self keyEnumerator]) {
        id value = [self valueForKey:aKey];
        properties = [properties stringByAppendingFormat:@"%@:'%@' ", aKey, value];
    }
    properties = [properties stringByAppendingString:@"]"];
    
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKShareOpenGraphObject *properties:'%@']",
                        properties
                        ];
    
    return result;

}

@end
