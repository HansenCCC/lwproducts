//
//  LWLabDefine.h
//  lwlab
//
//  Created by 程恒盛 on 2018/4/29.
//  Copyright © 2018年 Herson. All rights reserved.
//

#ifndef LWLabDefine_h
#define LWLabDefine_h


//添加快速创建cellModel
#undef  DEF_LWFastCreationFormElement
#define DEF_LWFastCreationFormElement(methodName,name,block) \
- (LWFormElement *)methodName{ \
if (!_##methodName) { \
@HV_WEAKIFY(self); \
_##methodName = [[LWFormElement alloc] initWithTitle:name];\
_##methodName.whenClick = ^(__kindof HVTableViewCellModel *cellModel) { \
@HV_NORMALIZEANDNOTNIL(self); \
if(block){ \
block(); \
} \
}; \
} \
return _##methodName; \
} \

#undef  DEF_LWFastGetFormElement
#define DEF_LWFastGetFormElement(methodName,name,block) \
- (LWFormElement *)methodName{ \
@HV_WEAKIFY(self); \
LWFormElement *methodName = [[LWFormElement alloc] initWithTitle:name];\
methodName.whenClick = ^(__kindof HVTableViewCellModel *cellModel) { \
@HV_NORMALIZEANDNOTNIL(self); \
if(block){ \
block(); \
} \
}; \
return methodName; \
} \

#endif /* LWLabDefine_h */
