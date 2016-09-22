//
//  FBGameRequestDialogDelegate.h
//  AirFacebook
//

#import <Foundation/Foundation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface FBGameRequestDialogDelegate : NSObject<FBSDKGameRequestDialogDelegate>

- (id)initWithCallback:(NSString *)aCallback;
- (void)showGameRequestDialogWithContent:(FBSDKGameRequestContent *)content frictionlessRequestsEnabled:(BOOL)frictionlessRequestsEnabled;

@end
