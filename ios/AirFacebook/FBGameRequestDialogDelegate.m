//
//  FBGameRequestDialogDelegate.m
//  AirFacebook
//

#import "FBGameRequestDialogDelegate.h"
#import "AirFacebook.h"

@implementation FBGameRequestDialogDelegate
{
    NSString *callback;
}

- (id)initWithCallback:(NSString *)aCallback
{
    if( self = [super init] )
    {
        callback = aCallback;
    }
    
    return self;
}

- (void)showGameRequestDialogWithContent:(FBSDKGameRequestContent *)content frictionlessRequestsEnabled:(BOOL)frictionlessRequestsEnabled
{
    FBSDKGameRequestDialog *dialog = [[FBSDKGameRequestDialog alloc] init];
    dialog.content = content;
    dialog.frictionlessRequestsEnabled = frictionlessRequestsEnabled;
    dialog.delegate = self;
    [dialog show];
}

- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didCompleteWithResults:(NSDictionary *)results
{
    NSString *resultString = [AirFacebook jsonStringFromObject:results andPrettyPrint:NO];
    [AirFacebook log:@"GAMEREQUEST_COMPLETE JSON: %@", resultString];
    [[AirFacebook sharedInstance] dispatchEvent:[NSString stringWithFormat:@"GAMEREQUEST_SUCCESS_%@", callback] withMessage:resultString];
    [[AirFacebook sharedInstance] shareFinishedForCallback:callback];
}

- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didFailWithError:(NSError *)error
{
    [AirFacebook log:@"GAMEREQUEST_ERROR error: %@", [error description]];
    [[AirFacebook sharedInstance] dispatchEvent:[NSString stringWithFormat:@"GAMEREQUEST_ERROR_%@", callback] withMessage:[error description]];
    [[AirFacebook sharedInstance] shareFinishedForCallback:callback];
}

- (void)gameRequestDialogDidCancel:(FBSDKGameRequestDialog *)gameRequestDialog
{
    [AirFacebook log:@"GAMEREQUEST_CANCEL"];
    [[AirFacebook sharedInstance] dispatchEvent:[NSString stringWithFormat:@"GAMEREQUEST_CANCELLED_%@", callback] withMessage:@"OK"];
    [[AirFacebook sharedInstance] shareFinishedForCallback:callback];
}

@end
