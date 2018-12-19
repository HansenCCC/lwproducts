//
//  lwDefine_EnumUtil.h
//  lwui
//
//  Created by 程恒盛 on 16/11/17.
//  Copyright © 2016年 Herson. All rights reserved.
//

#ifndef lwDefine_EnumUtil_h
#define lwDefine_EnumUtil_h

//添加enum类型与NSString转换的便捷宏###########################{
//enum=>NSString
#define AS_EnumValueToNSString(EnumType)\
+ (NSString *)stringWith##EnumType:(EnumType)value;
#define DEF_EnumValueToNSString(EnumType,__staticMapDictionary)\
+ (NSString *)stringWith##EnumType:(EnumType)enumValue{\
static NSDictionary<NSNumber*,NSString *> *staticMap;\
if(!staticMap){\
NSDictionary *mapDictionary = (__staticMapDictionary);\
NSMutableDictionary<NSNumber *,NSString *> *map = [[NSMutableDictionary alloc] initWithCapacity:mapDictionary.count];\
for(id key in mapDictionary){\
id value = [mapDictionary objectForKey:key];\
if([key isKindOfClass:[NSNumber class]]){\
[map setObject:value forKey:key];\
}else{\
[map setObject:key forKey:value];\
}\
}\
staticMap = (map);\
}\
NSString *str = staticMap[@(enumValue)];\
if(!str){\
str = [@(enumValue) stringValue];\
}\
return str;\
}
//NSString=>enum
#define AS_EnumValueFromNSString(EnumType)\
- (EnumType)EnumType;
#define DEF_EnumValueFromNSString(EnumType,__staticMapDictionary)\
- (EnumType)EnumType{\
static NSDictionary<NSString *,NSNumber *> *staticMap;\
if(!staticMap){\
NSDictionary *mapDictionary = (__staticMapDictionary);\
NSMutableDictionary<NSString *,NSNumber *> *map = [[NSMutableDictionary alloc] initWithCapacity:mapDictionary.count];\
for (id key in mapDictionary) {\
id value = [mapDictionary objectForKey:key];\
if([key isKindOfClass:[NSNumber class]]){\
[map setObject:key forKey:value];\
}else{\
[map setObject:value forKey:key];\
}\
}\
staticMap = map;\
}\
EnumType enumValue = (EnumType)[staticMap[self] integerValue];\
return enumValue;\
}

//enum<=>NSString
#define AS_EnumValue_NSString(EnumType)\
AS_EnumValueToNSString(EnumType)\
AS_EnumValueFromNSString(EnumType)
#define DEF_EnumValue_NSString(EnumType,__staticMapDictionary)\
DEF_EnumValueToNSString(EnumType,__staticMapDictionary)\
DEF_EnumValueFromNSString(EnumType,__staticMapDictionary)

//定义NSString(enum)的类别
#define AS_EnumTypeCategoryToNSString(EnumType)\
@interface NSString(EnumType)\
AS_EnumValue_NSString(EnumType)\
@end
#define DEF_EnumTypeCategoryToNSString(EnumType,__staticMapDictionary)\
@implementation NSString(EnumType)\
DEF_EnumValue_NSString(EnumType,(__staticMapDictionary))\
@end

//添加enum类型数据从NSDictionary中获取的便捷宏
//NSDictionary[path]|otherwise=>enum
#define AS_EnumValueFromNSDictionaryAtPathAndOtherwise(EnumType)\
- (EnumType)EnumType##AtPath:(NSString *)path otherwise:(EnumType)otherwise;
#define DEF_EnumValueFromNSDictionaryAtPathAndOtherwise(EnumType)\
- (EnumType)EnumType##AtPath:(NSString *)path otherwise:(EnumType)otherwise{\
EnumType enumValue = otherwise;\
id obj = [self valueForKeyPath:path];\
if(obj==[NSNull null]){\
obj = nil;\
}\
if(obj){\
if([obj isKindOfClass:[NSNumber class]]){\
enumValue = (EnumType)[(NSNumber *)obj integerValue];\
}else if([obj isKindOfClass:[NSString class]]){\
NSString *str = (NSString *)obj;\
NSScanner *scanner = [[NSScanner alloc] initWithString:str];\
NSInteger value = 0;\
if([scanner scanInteger:&value]&&scanner.isAtEnd){\
enumValue = (EnumType)value;\
}else{\
enumValue = [str EnumType];\
}\
}else{\
enumValue = [[obj description] EnumType];\
}\
}\
return enumValue;\
}

//NSDictionary[path]=>enum
#define AS_EnumValueFromNSDictionaryAtPath(EnumType)\
- (EnumType)EnumType##AtPath:(NSString *)path;
#define DEF_EnumValueFromNSDictionaryAtPath(EnumType)\
- (EnumType)EnumType##AtPath:(NSString *)path{\
EnumType enumValue = (EnumType)0;\
id obj = [self valueForKeyPath:path];\
if(obj==[NSNull null]){\
obj = nil;\
}\
if(obj){\
if([obj isKindOfClass:[NSNumber class]]){\
enumValue = (EnumType)[(NSNumber *)obj integerValue];\
}else if([obj isKindOfClass:[NSString class]]){\
NSString *str = (NSString *)obj;\
NSScanner *scanner = [[NSScanner alloc] initWithString:str];\
NSInteger value = 0;\
if([scanner scanInteger:&value]&&scanner.isAtEnd){\
enumValue = (EnumType)value;\
}else{\
enumValue = [str EnumType];\
}\
}else{\
enumValue = [[obj description] EnumType];\
}\
}\
return enumValue;\
}

//NSDictionary[path]|otherwise=>enum,NSDictionary[path]=>enum
#define AS_EnumValueFromNSDictionary(EnumType)\
AS_EnumValueFromNSDictionaryAtPathAndOtherwise(EnumType)\
AS_EnumValueFromNSDictionaryAtPath(EnumType)
#define DEF_EnumValueFromNSDictionary(EnumType)\
DEF_EnumValueFromNSDictionaryAtPathAndOtherwise(EnumType)\
DEF_EnumValueFromNSDictionaryAtPath(EnumType)

//定义NSDictionary(enum)的类别
#define AS_EnumTypeCategoryToNSDictionary(EnumType)\
@interface NSDictionary(EnumType)\
AS_EnumValueFromNSDictionary(EnumType)\
@end
#define DEF_EnumTypeCategoryToNSDictionary(EnumType)\
@implementation NSDictionary(EnumType)\
DEF_EnumValueFromNSDictionary(EnumType)\
@end

//给Enum添加NSString与NSDictionry的category
//__staticMapDictionary为NSDicionary<NSNumber *,NSString *>,key为enum取值的NSNumber,value为enum值对应的NSString,例如:DEF_EnumTypeCategories(UIViewAnimationCurve,(@{@(UIViewAnimationCurveEaseInOut):@"EaseInOut",@(UIViewAnimationCurveEaseIn):@"EaseIn",@(UIViewAnimationCurveEaseOut):@"EaseOut",@(UIViewAnimationCurveLinear):@"Linear"}))
#define AS_EnumTypeCategories(EnumType)\
AS_EnumTypeCategoryToNSString(EnumType)\
AS_EnumTypeCategoryToNSDictionary(EnumType)
#define DEF_EnumTypeCategories(EnumType,__staticMapDictionary)\
DEF_EnumTypeCategoryToNSString(EnumType,__staticMapDictionary)\
DEF_EnumTypeCategoryToNSDictionary(EnumType)

//添加enum类型与NSString转换的便捷宏###########################}



//添加Mask类型与NSString转换的便捷宏###########################{
//OptionMask掩码值=>NSString
#define AS_OptionValue_NSString(OptionType)\
+ (NSString *)stringWithOPTIONS##OptionType:(OptionType)optionValue;

#define DEF_OptionValue_NSString(OptionType,__staticMapDictionary)\
+ (NSString *)stringWithOPTIONS##OptionType:(OptionType)optionValue{\
NSMutableArray<NSString *> *masks = [[NSMutableArray alloc] init];\
static NSDictionary<NSNumber *,NSString *> *staticMap;\
if(!staticMap){\
NSDictionary *mapDictionary = (__staticMapDictionary);\
NSMutableDictionary<NSNumber *,NSString *> *map = [[NSMutableDictionary alloc] initWithCapacity:mapDictionary.count];\
for (id key in mapDictionary) {\
id value = [mapDictionary objectForKey:key];\
if([key isKindOfClass:[NSNumber class]]){\
[map setObject:value forKey:key];\
}else{\
[map setObject:key forKey:value];\
}\
}\
staticMap = map;\
}\
for (NSNumber *num in staticMap) {\
OptionType v = (OptionType)[num integerValue];\
if((optionValue&v)==v){\
NSString *s = staticMap[num];\
[masks addObject:s];\
}\
}\
NSString *str = [masks componentsJoinedByString:@"|"];\
return str;\
}
//添加Mask类型与NSString转换的便捷宏###########################}

#endif /* lwDefine_EnumUtil_h */
