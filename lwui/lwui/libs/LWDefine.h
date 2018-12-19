//
//  lwDefine.h
//  lwui
//
//  Created by 程恒盛 on 16/11/7.
//  Copyright © 2016年 Herson. All rights reserved.
//

#ifndef lwDefine_h
#define lwDefine_h

/**
 *  定义单例
 *  @param ... 无实际使用
 */
#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

/**
 *  对于block外部与内部间的变量传递,定义block外的weak弱引用与block内的strong强引用,防止因block而引起的循环引用内存泄露
 *	范例:
 - (void)test{
	NSObject *obj;
	@weakify(self);
	@weakify(obj);
	void(^testBlock)() = ^(){
 @normalize(self);
 @normalize(obj);
 ...
	};
 }
 *  @param objc_arc 对象
 *
 */
#undef HV_WEAKIFY
#define HV_WEAKIFY( x )    autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;

#undef    HV_NORMALIZE
#define HV_NORMALIZE( x )    try{} @finally{} __typeof__(x) x = __weak_##x##__;
#undef    HV_NORMALIZEANDNOTNIL
#define HV_NORMALIZEANDNOTNIL( x )    try{} @finally{} __typeof__(x) x = __weak_##x##__;if(x==nil)return;



#undef  LWLog
#ifdef DEBUG
#define LWLog(format,args...) NSLog([NSString stringWithFormat:@"%%@ [%%@] %%d\n================================================={\n\t%@\n}=================================================\n\n",format],[[NSString stringWithUTF8String:__FILE__] lastPathComponent] ,NSStringFromSelector(_cmd) ,__LINE__,##args)

#else
#define LWLog(format, args...)
#endif


#endif /* lwDefine_h */







