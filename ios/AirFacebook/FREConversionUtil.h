//
//  FREConversionUtil.h
//  AirFacebook
//
//  Created by Ján Horváth on 30/06/15.
//
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

@interface FREConversionUtil : NSObject

+ (FREObject)fromString:(NSString *)value;
+ (FREObject)fromNumber:(NSNumber *)value;
+ (FREObject)fromInt:(NSInteger)value;
+ (FREObject)fromUInt:(NSUInteger)value;
+ (FREObject)fromBoolean:(BOOL)value;

+ (NSString *)toString:(FREObject)object;
+ (NSNumber *)toNumber:(FREObject)object;
+ (NSInteger)toInt:(FREObject)object;
+ (NSUInteger)toUInt:(FREObject)object;
+ (BOOL)toBoolean:(FREObject)object;
+ (NSArray *)toStringArray:(FREObject)object;

+ (NSArray *)toIntArray:(FREObject)object;
+ (NSArray *)toBoolArray:(FREObject)object;
+ (NSArray *)toLongArray:(FREObject)object;
+ (NSArray *)toDoubleArray:(FREObject)object;
+ (NSArray *)toDictionaryArray:(FREObject)object;

+ (NSDictionary *)toStringDictionary:(FREObject)object;
+ (NSDictionary *)toStringDictionaryFromKeys:(FREObject)keys andValues:(FREObject)values;
+ (NSDictionary *)toDictionary:(FREObject)object;
+ (NSDictionary *)toDictionaryFromKeys:(FREObject)keys types:(FREObject)types andValues:(FREObject)values;

+ (FREObject)getProperty:(NSString *)name fromObject:(FREObject)object;
+ (NSUInteger)getArrayLength:(FREObject *)array;
+ (FREObject *)getArrayItemAt:(NSUInteger)index on:(FREObject)array;

@end
