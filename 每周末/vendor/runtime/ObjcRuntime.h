//
//  ObjcRuntime.h
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <Foundation/Foundation.h>

//根据类名称获取类
//系统就提供 NSClassFromString(NSString *clsname)

//获取一个类的所有属性名字:类型的名字，具有@property的, 父类的获取不了！
NSDictionary *GetPropertyListOfObject(NSObject *object);
NSDictionary *GetPropertyListOfClass(Class cls);
/**
 *  利用runtime遍历它的所有成员变量，看看系统是怎么存储这个属性的，
 */
NSArray *GetIvarListOfObject(NSObject *object);
void Swizzle(Class c, SEL origSEL, SEL newSEL);