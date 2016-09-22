//
//  FBShareDelegate.h
//  AirFacebook
//
//  Created by Ján Horváth on 16/06/15.
//
//

#import <Foundation/Foundation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "AirFacebook.h"

@interface FBShareDelegate : NSObject<FBSDKSharingDelegate>

- (id)initWithCallback:(NSString *)aCallback;
- (BOOL)shareContent:(id<FBSDKSharingContent>)content usingShareApi:(BOOL)useShareApi;

@end
