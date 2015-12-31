//
//  ObjcRuntime.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "ObjcRuntime.h"
#import <objc/runtime.h>

NSArray *GetIvarListOfObject(NSObject *object){
    NSMutableArray *nameArray=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *typeArray=[[NSMutableArray alloc]initWithCapacity:0];
    unsigned int count=0;
    Ivar *var=class_copyIvarList([object class], &count);
    for (int i=0; i<count; i++) {
        Ivar _var=*(var+i);
//        NSLog(@"%s",ivar_getName(_var));
//        NSLog(@"%s",ivar_getTypeEncoding(_var));
        
        NSString *name=[NSString stringWithFormat:@"%s",ivar_getName(_var)];
        NSString *typeEncoding=[NSString stringWithFormat:@"%s",ivar_getTypeEncoding(_var)];
        [nameArray addObject:name];
        [typeArray addObject:typeEncoding];
    }
    free(var);
    return nameArray;
}

NSDictionary *GetPropertyListOfObject(NSObject *object){
    return GetPropertyListOfClass([object class]);
}

NSDictionary *GetPropertyListOfClass(Class cls){
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        const char *propType = property_getAttributes(property);
        if(propType&&propName) {
            NSArray *anAttribute = [[NSString stringWithUTF8String:propType]componentsSeparatedByString:@","];
            NSString *aType = anAttribute[0];
//暂时不能去掉前缀T@\"和后缀"，需要用以区分标量与否
//            if ([aType hasPrefix:@"T@\""]) {
//                aType = [aType substringWithRange:NSMakeRange(3, [aType length]-4)];
//            }else{
//                aType = [aType substringFromIndex:1];
//            }
            [dict setObject:aType forKey:[NSString stringWithUTF8String:propName]];
        }
    }
    free(properties);
    
    return dict;
}

//静态就交换静态，实例方法就交换实例方法
void Swizzle(Class c, SEL origSEL, SEL newSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
	if (!origMethod) {
		origMethod = class_getClassMethod(c, origSEL);
        if (!origMethod) {
            return;
        }
        newMethod = class_getClassMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
	}
}