//
//  FBSDKAccessToken+Serializer.m
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import "FBSDKAccessToken+Serializer.h"
#import "FPANEUtils.h"

@implementation FBSDKAccessToken (Serializer)

- (FREObject) toFREObject
{
    FREObject result;
    FRENewObject((const uint8_t*)"com.freshplanet.ane.AirFacebook.FBAccessToken", 0, NULL, &result, NULL);
    FRESetObjectProperty(result, (const uint8_t*)"appID", FPANE_NSStringToFREObject(self.appID), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"declinedPermissions", FPANE_NSArrayToFREObject([self.declinedPermissions allObjects]), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"expirationDate", FPANE_doubleToFREObject([self.expirationDate timeIntervalSince1970]), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"permissions", FPANE_NSArrayToFREObject([self.permissions allObjects]), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"refreshDate", FPANE_doubleToFREObject([self.refreshDate timeIntervalSince1970]), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"tokenString", FPANE_NSStringToFREObject(self.tokenString), NULL);
    FRESetObjectProperty(result, (const uint8_t*)"userID", FPANE_NSStringToFREObject(self.userID), NULL);
    return result;
}

- (NSString *) toString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *declinedPermissions = [[self.declinedPermissions allObjects] componentsJoinedByString:@","];
    NSString *permissions = [[self.permissions allObjects] componentsJoinedByString:@","];
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKAccessToken appID:'%@' declinedPermissions:'%@' expirationDate:'%@' permissions:'%@' refreshDate:'%@' tokenString:'%@' userID:'%@']",
                        self.appID,
                        declinedPermissions != nil ? [NSString stringWithFormat:@"[%@]", declinedPermissions] : nil,
                        [formatter stringFromDate:self.expirationDate],
                        permissions != nil ? [NSString stringWithFormat:@"[%@]", permissions] : nil,
                        [formatter stringFromDate:self.refreshDate],
                        self.tokenString,
                        self.userID
                        ];
    return result;

}

@end
