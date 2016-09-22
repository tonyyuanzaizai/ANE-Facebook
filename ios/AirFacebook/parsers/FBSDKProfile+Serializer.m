//
//  FBSDKProfile+Serializer.m
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import "FBSDKProfile+Serializer.h"
#import "FPANEUtils.h"

@implementation FBSDKProfile (Serializer)

- (FREObject) toFREObject
{
    FREObject result;
    FRENewObject((const uint8_t*)"com.freshplanet.ane.AirFacebook.FBProfile", 0, NULL, &result, NULL);
    FRESetObjectProperty(result, (const uint8_t*)"firstName", FPANE_NSStringToFREObject(self.firstName), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"lastName", FPANE_NSStringToFREObject(self.lastName), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"linkUrl", FPANE_NSStringToFREObject([self.linkURL absoluteString]), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"middleName", FPANE_NSStringToFREObject(self.middleName), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"name", FPANE_NSStringToFREObject(self.name), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"refreshDate", FPANE_doubleToFREObject([self.refreshDate timeIntervalSince1970]), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"userID", FPANE_NSStringToFREObject(self.userID), NULL);
    return result;
}

- (NSString *) toString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKAccessToken firstName:'%@' lastName:'%@' linkUrl:'%@' middleName:'%@' name:'%@' refreshDate:'%@' userID:'%@']",
                        self.firstName,
                        self.lastName,
                        [self.linkURL absoluteString],
                        self.middleName,
                        self.name,
                        [formatter stringFromDate:self.refreshDate],
                        self.userID
                        ];
    return result;
}

@end
