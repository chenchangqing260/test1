//
//  BeanManager.m
//
//  Created by Ellison Xu on 15/9/20.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import "BeanEntityManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "BeanSupport.h"
#import "BeanEntityCache.h"

@interface BeanEntityManager ()

@end

@implementation BeanEntityManager

+ (BeanEntityManager *)defaultManager
{
    static id instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [BeanEntityManager new];
    });

    return instance;
}

- (id)JSONObjectWithObject:(id)object
{
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if ([object isKindOfClass:[NSDate class]]) {
        return @((int64_t)([object timeIntervalSince1970] * 1000L));
    }
    
    if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]] || [NSJSONSerialization isValidJSONObject:object]) {
        return object;
    }
    
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *serializedArray = [NSMutableArray new];
        [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id jsonObject = [self JSONObjectWithObject:obj];
            if (jsonObject) {
                [serializedArray addObject:jsonObject];
            }
        }];
        return serializedArray;
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id jsonObject = [self JSONObjectWithObject:obj];
            if (jsonObject) {
                [dictionary setObject:jsonObject forKey:key];
            }
        }];
        return dictionary;
    }
    
    return [self complexJSONObjectWithObject:object];
}

- (NSMutableDictionary *)complexJSONObjectWithObject:(id)object
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    Class cls = [object class];
    NSString *className = NSStringFromClass(cls);
    BeanEntity *beanEntity = [[BeanEntityCache defaultCache] beanEntityForClassName:className];
    if (beanEntity == nil) {
        [[BeanEntityCache defaultCache] registerBeanClass:cls];
        beanEntity = [[BeanEntityCache defaultCache] beanEntityForClassName:className];
    }
    if (beanEntity == nil) {
        return nil;
    }
    
    for (BeanProperty *property in beanEntity.allPropertiesIncludeParent) {
        if (property.isWeak || property.isReadonly) {
            continue;
        }
        
        if (property.ctype == _C_ID && !property.isStrong && !property.isCopy) {
            continue;
        }
        
        @try {
            id propertyName = property.name;
            
            if (propertyName) {
                id value = [object valueForKey:propertyName];
                if (value) {
                    if (property.ctype == _C_ID || [value isKindOfClass:[NSNumber class]]) {
                        id jsonObject = [self JSONObjectWithObject:value];
                        if (jsonObject) {
                            [dict setObject:jsonObject forKey:propertyName];
                        }
                    }
                }
            }
        }
        @catch (NSException *exception) {
            DLog(@"exception throwed: %@", exception);
        }
    }

    return dict;
}

- (id)basicObjectWithJSONObject:(id)jsonObject class:(Class)aClass isBasic:(BOOL *)isBasicObject
{
    BOOL isBasic = [aClass isSubclassOfClass:[NSString class]] || [aClass isSubclassOfClass:[NSNumber class]] || [aClass isSubclassOfClass:[NSDate class]];
    if (isBasicObject != NULL) {
        *isBasicObject = isBasic;
    }
    
    if (isBasic) {
        if ([aClass isSubclassOfClass:[NSString class]]) {
            if ([jsonObject isKindOfClass:[NSData class]]) {
                return [[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
            } else if ([jsonObject isKindOfClass:[NSString class]]) {
                return jsonObject;
            } else if ([jsonObject isKindOfClass:[NSNumber class]]) {
                return [jsonObject stringValue];
            } else {
                return nil;
            }
        }
        
        if ([aClass isSubclassOfClass:[NSNumber class]]) {
            if ([jsonObject isKindOfClass:[NSData class]]) {
                jsonObject = [[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
            }
            if ([jsonObject isKindOfClass:[NSString class]]) {
                @try {
                    if ([jsonObject rangeOfString:@"."].length > 0) {
                        return @([jsonObject doubleValue]);
                    } else {
                        long long value = [jsonObject longLongValue];
                        if (value <= INT32_MAX) {
                            return @([jsonObject intValue]);
                        }
                        
                        return @(value);
                    }
                }
                @catch (NSException *exception) {
                    DLog(@"failed to parse number:exception = %@", exception);
                    return nil;
                }
            } else if ([jsonObject isKindOfClass:[NSNumber class]]) {
                return jsonObject;
            } else {
                return nil;
            }
        }
        
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *result = [NSMutableArray array];
            
            [jsonObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                id basicObject = [self basicObjectWithJSONObject:obj class:aClass isBasic:NULL];
                if (basicObject) {
                    [result addObject:basicObject];
                }
            }];
            
            return result;
        }
        
        if ([aClass isSubclassOfClass:[NSDate class]]) {
            @try {
                if ([jsonObject isKindOfClass:[NSData class]]) {
                    jsonObject = [[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
                }
                if ([jsonObject isKindOfClass:[NSString class]] || [jsonObject isKindOfClass:[NSNumber class]]) {
                    int64_t timestamp = [jsonObject longLongValue];
                    return timestamp > 0 ? [NSDate dateWithTimeIntervalSince1970:(timestamp / 1000.0)] : nil;
                } else {
                    return nil;
                }
            }
            @catch (NSException *exception) {
                DLog(@"failed to parse date,exception = %@", exception);
                return nil;
            }
        }
    }
    
    
    return nil;
}

- (id)objectWithJSONObject:(id)jsonObject class:(Class)aClass
{
    if (jsonObject == nil || [jsonObject isKindOfClass:[NSNull class]]) {
        return nil;// treat NSNull as nil.
    }
    
    BOOL isBasicObject;// identify if the object is the basic object: number, date, string.
    id basicObject = [self basicObjectWithJSONObject:jsonObject class:aClass isBasic:&isBasicObject];
    if (isBasicObject) {
        return basicObject;
    }

    if ([jsonObject isKindOfClass:[NSString class]]) {
        jsonObject = [jsonObject dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if ([jsonObject isKindOfClass:[NSData class]]) {
        jsonObject = [NSJSONSerialization JSONObjectWithData:jsonObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
    
    if (![NSJSONSerialization isValidJSONObject:jsonObject]) {
        return nil;
    }
    
    if (aClass == NULL) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *result = [NSMutableDictionary dictionary];
            [jsonObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                id cobject = [self objectWithJSONObject:obj class:aClass];
                if (cobject) {
                    result[key] = cobject;
                }
            }];
            return result;
        } else if ([jsonObject isKindOfClass:[NSArray class]]) {
            aClass = [NSArray class];
        } else {
            return jsonObject;
        }
    }
    
    if ([aClass isSubclassOfClass:[NSDictionary class]] && [jsonObject isKindOfClass:[NSDictionary class]]) {
        return [jsonObject mutableCopy];
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (id jsonValueItem in jsonObject) {
            Class class = aClass;

            id obj = [self objectWithJSONObject:jsonValueItem class:class];
            if (obj) {
                [array addObject:obj];
            }
        }
        return array;
    }

    return [self complexObjectWithJSONObject:jsonObject class:aClass];
}

- (id)complexObjectWithJSONObject:(NSDictionary *)jsonObject class:(Class)aClass
{
    if (jsonObject == nil || aClass == NULL) {
        return nil;
    }
    
    NSMutableDictionary *normalizedValue = [jsonObject mutableCopy];
    if (normalizedValue) {
        NSSet *nullValueKeys = [jsonObject keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
            return [obj isKindOfClass:[NSNull class]];
        }];
        [normalizedValue removeObjectsForKeys:nullValueKeys.allObjects];
        jsonObject = normalizedValue;
    }
    
    if (jsonObject.count == 0) {
        return [aClass new];
    }
    
    NSString *className = NSStringFromClass(aClass);
    BeanEntity *beanEntity = [[BeanEntityCache defaultCache] beanEntityForClassName:className];
    if (beanEntity == nil) {
        [[BeanEntityCache defaultCache] registerBeanClass:aClass];
        beanEntity = [[BeanEntityCache defaultCache] beanEntityForClassName:className];
    }
    if (beanEntity == nil) {
        return nil;
    }
    
    id object = [aClass new];
    NSMutableDictionary *validProperties = [NSMutableDictionary dictionary];
    for (BeanProperty *prop in beanEntity.allPropertiesIncludeParent) {
        if (prop.isWeak || prop.isReadonly) {
            continue;
        }
        validProperties[prop.name] = prop;
    }
    
    @try {
        [jsonObject enumerateKeysAndObjectsUsingBlock:^(id jsonKey, id obj, BOOL *stop) {
            id key = jsonKey;
            BeanProperty *prop = validProperties[key];
            if (prop == nil) {
                return;
            }
            
            Class class = NULL;
            
            // check class in array.
            if ([obj isKindOfClass:[NSArray class]] && [object respondsToSelector:@selector(classInArrayForKey:)]) {
                class = [object classInArrayForKey:key];
            }
            
            // use properties' class.
            if (class == NULL) {
                class = prop.cls;
            }
            if (class != NULL) {
                BOOL isBasic;
                id basicObject = [self basicObjectWithJSONObject:obj class:class isBasic:&isBasic];
                if (isBasic) {
                    [object setValue:basicObject forKey:key];
                } else {
                    [object setValue:[self objectWithJSONObject:obj class:class] forKey:key];
                }
            } else if ([obj isKindOfClass:[NSNumber class]]) {
                [object setValue:obj forKey:key];
            } else {
                NSString *type = prop.stype;
                if ([obj isKindOfClass:[NSString class]]) {
                    NSString *objStr = obj;
                    if ([type isEqualToString:@"i"]) {
                        // property is a integer value.
                        [object setValue:@(objStr.integerValue) forKey:key];
                    } else if ([type isEqualToString:@"B"] && [obj isKindOfClass:[NSString class]]) {
                        [object setValue:@(objStr.boolValue) forKey:key];
                    } else if([type isEqualToString:@"d"] && [obj isKindOfClass:[NSString class]]) {
                        [object setValue:@(objStr.doubleValue) forKey:key];
                    }
                }
            }
        }];
    }
    @catch (NSException *exception) {
        DLog(@"exception throwed:%@", exception);
    }
    return object;
}

@end
