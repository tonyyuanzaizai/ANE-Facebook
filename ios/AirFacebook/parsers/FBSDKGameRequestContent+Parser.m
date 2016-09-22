//
//  FBSDKGameRequestContent+Parser.m
//  AirFacebook
//
//  Created by Ján Horváth on 16/09/15.
//
//

#import "FBSDKGameRequestContent+Parser.h"
#import "FREConversionUtil.h"

// Names of member variables of FBGameRequestContent actionscript class
NSString * const MESSAGE = @"message";
NSString * const TO = @"to";
NSString * const DATA = @"data";
NSString * const TITLE = @"title";
NSString * const ACTION_TYPE = @"actionType";
NSString * const OBJECT_ID = @"objectId";
NSString * const FILTERS = @"filters";
NSString * const SUGGESTIONS = @"suggestions";

@implementation FBSDKGameRequestContent (Parser)

+(FBSDKGameRequestContent*)parseFromFREObject:(FREObject) object
{
    NSString *message = [FREConversionUtil toString:[FREConversionUtil getProperty:MESSAGE fromObject:object]];
    NSArray *to = [FREConversionUtil toStringArray:[FREConversionUtil getProperty:TO fromObject:object]];
    NSString *data = [FREConversionUtil toString:[FREConversionUtil getProperty:DATA fromObject:object]];
    NSString *title = [FREConversionUtil toString:[FREConversionUtil getProperty:TITLE fromObject:object]];
    
    FBSDKGameRequestActionType actionType = 0;
    FREObject actionTypeObject = [FREConversionUtil getProperty:ACTION_TYPE fromObject:object];
    if(actionTypeObject != nil){
        
        actionType = [FREConversionUtil toUInt:[FREConversionUtil getProperty:@"value" fromObject:actionTypeObject]];
    }
    
    NSString *objectId = [FREConversionUtil toString:[FREConversionUtil getProperty:OBJECT_ID fromObject:object]];
    
    FBSDKGameRequestFilter filters = 0;
    FREObject filtersObject = [FREConversionUtil getProperty:FILTERS fromObject:object];
    if(filtersObject != nil){
        
        filters = [FREConversionUtil toUInt:[FREConversionUtil getProperty:@"value" fromObject:filtersObject]];
    }
    
    NSArray *suggestions = [FREConversionUtil toStringArray:[FREConversionUtil getProperty:SUGGESTIONS fromObject:object]];
    
    FBSDKGameRequestContent *content = [[FBSDKGameRequestContent alloc] init];
    
    if(message != nil) content.message = message;
    if(to != nil) content.recipients = to;
    if(data != nil) content.data = data;
    if(title != nil) content.title = title;
    content.actionType = actionType;
    if(objectId != nil) content.objectID = objectId;
    content.filters = filters;
    if(suggestions != nil) content.recipientSuggestions = suggestions;
    
    return content;
}

-(NSString *)toString
{
    NSString *recipients = [self.recipients componentsJoinedByString:@","];
    NSString *recipientSuggestions = [self.recipientSuggestions componentsJoinedByString:@","];
    NSString *result = [[NSString alloc] initWithFormat:@"[FBSDKGameRequestContent message:'%@' to:'%@' data:'%@' title:'%@' actionType:'%lu' objectId:'%@' filters:'%lu' suggestions:'%@']",
                        self.message,
                        recipients != nil ? [NSString stringWithFormat:@"[%@]", recipients] : nil,
                        self.data,
                        self.title,
                        (unsigned long)self.actionType,
                        self.objectID,
                        (unsigned long)self.filters,
                        recipientSuggestions != nil ? [NSString stringWithFormat:@"[%@]", recipientSuggestions] : nil
                        ];
    return result;
}

@end
