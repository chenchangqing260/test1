//
//  BeanEntityCache.m
//  hxz
//
//  Created by WangJensen on 11/25/15.
//  Copyright © 2015 sevenplus. All rights reserved.
//

#import "BeanEntityCache.h"
#import <objc/runtime.h>

@implementation BeanProperty

@end

@implementation BeanEntity

//- (instancetype)init
//{
//    if (self = [super init]) {
//        self.allPropertiesIncludeParent = [NSMutableArray new];
//    }
//    
//    return self;
//}

@end

@interface BeanEntityCache()

@property (nonatomic,strong) NSMutableDictionary *entityCache;

@end

@implementation BeanEntityCache

+ (instancetype)defaultCache
{
    static BeanEntityCache *instance = nil;
    static dispatch_once_t cacheToken;
    
    dispatch_once(&cacheToken, ^{
        if (!instance) {
            instance = [BeanEntityCache new];
            instance.entityCache = [NSMutableDictionary new];
        }
    });
    
    return instance;
}

- (void)registerBeanClass:(Class)class
{
    if (class == NULL) {
        return;
    }
    
    // since register class will access and modify the entity cache, dispatch the opertion on
    // the main thread to avoid multi-thread problem.
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self registerBeanClass:class];
        });
        return;
    }
    
    if (self.entityCache[NSStringFromClass(class)]) {
        return;
    }
    
    DLog(@"regisetering class: %@", class);
    NSString *className = nil;
    BeanEntity *entity = nil;
    
    // get all ancestor classes of the entity in order to we can
    // get the properties of the parent class.
    NSMutableArray *ancestorClasses = [NSMutableArray array];
    Class parentClass = class;
    while (parentClass != NULL) {
        className = NSStringFromClass(parentClass);
        if ([className isEqualToString:NSStringFromClass([NSObject class])]) {
            break;
        }
        
        entity = [self beanEntityForClassName:className];
        if (entity != nil) {
            break;
        }
        
        [ancestorClasses insertObject:parentClass atIndex:0];
        parentClass = [parentClass superclass];
    }
    
    [ancestorClasses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *className = NSStringFromClass(obj);
        if (!self.entityCache[className]) {
            self.entityCache[className] = [self generateBeanEntityForClass:obj];
        }
    }];
}

- (BeanEntity *)generateBeanEntityForClass:(Class)aClass
{
    NSString *className = NSStringFromClass(aClass);
    BeanEntity *entity = self.entityCache[className];
    if (entity != nil) {
        return entity;
    }
    
    entity = [BeanEntity new];
    entity.entityClass = aClass;
    
    // get the properties of the super class.
    Class superClass = [aClass superclass];
    BeanEntity *parentEntity = nil;
    if (superClass != NULL) {
        NSString *superClassName = NSStringFromClass(superClass);
        parentEntity = self.entityCache[superClassName];
    }
    
    NSMutableArray *allPropertyIncludeParent = [NSMutableArray new];
    if (parentEntity && parentEntity.allPropertiesIncludeParent.count > 0) {
        [allPropertyIncludeParent addObjectsFromArray:parentEntity.allPropertiesIncludeParent];
    }
    
    // get all property of the class, then add into the entity.
    unsigned int propertyCount;
    objc_property_t *rawProperties = class_copyPropertyList(aClass, &propertyCount);
    
    NSMutableArray *properties = [NSMutableArray array];
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t p = rawProperties[i];
        
        BeanProperty *property = [BeanProperty new];
        property.name = [NSString stringWithUTF8String:property_getName(p)];
        
        unsigned int attrCount;
        objc_property_attribute_t *rawAttributes = property_copyAttributeList(p, &attrCount);
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        for (int j = 0; j < attrCount; j++) {
            objc_property_attribute_t attribute = rawAttributes[j];
            attributes[[NSString stringWithUTF8String:attribute.name]] = [NSString stringWithUTF8String:attribute.value];
        }
        
        NSString *type = attributes[@"T"];
        property.stype = type;
        if (type.length > 0) {
            property.ctype = type.UTF8String[0];
            
            if (property.ctype == _C_ID) {
                // if the property type is Id, then get the actual type.
                static NSRegularExpression *regex = nil;
                static dispatch_once_t regexToken;
                dispatch_once(&regexToken, ^{
                    regex = [NSRegularExpression regularExpressionWithPattern:@"^@\\\"(\\w+)\\\"" options:0 error:nil];
                });
                
                NSTextCheckingResult *result = [regex firstMatchInString:type options:0 range:NSMakeRange(0, type.length)];
                if (result.numberOfRanges > 1 && result.range.length > 0) {
                    property.cls = NSClassFromString([type substringWithRange:[result rangeAtIndex:1]]);
                }
            }
        }
        property.isReadonly = attributes[@"R"] != nil;
        property.isStrong = attributes[@"&"] != nil;
        property.isCopy = attributes[@"C"] != nil;
        property.isWeak = attributes[@"W"] != nil;
        
        if (rawAttributes != NULL) {
            free(rawAttributes);
            rawAttributes = NULL;
        }
        
        [properties addObject:property];
    }
    
    
    [allPropertyIncludeParent addObjectsFromArray:properties];
    entity.allPropertiesIncludeParent = allPropertyIncludeParent;
    
    if (rawProperties != NULL) {
        free(rawProperties);
        rawProperties = NULL;
    }
    
    return entity;
}


- (BeanEntity *)beanEntityForClassName:(NSString *)className
{
    // since register class will access and modify the entity cache, dispatch the opertion on
    // the main thread to avoid multi-thread problem.
    if ([NSThread isMainThread]) {
        return self.entityCache[className];
    } else {
        __block BeanEntity *entity;
        dispatch_sync(dispatch_get_main_queue(), ^{
            entity = self.entityCache[className];
        });
        
        return entity;
    }
}

@end
