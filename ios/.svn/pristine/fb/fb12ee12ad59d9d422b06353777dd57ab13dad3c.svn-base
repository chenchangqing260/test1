//
//  BeanEntityCache.h
//  hxz
//
//  Created by WangJensen on 11/25/15.
//  Copyright © 2015 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeanProperty : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Class cls;
@property (nonatomic) char ctype;
@property (strong,nonatomic) NSString *stype;
@property (nonatomic) BOOL isReadonly;
@property (nonatomic) BOOL isStrong;
@property (nonatomic) BOOL isCopy;
@property (nonatomic) BOOL isWeak;

@end

@interface BeanEntity : NSObject

@property (strong, nonatomic) Class entityClass;
@property (strong, nonatomic) NSArray *allPropertiesIncludeParent;

@end


@interface BeanEntityCache : NSObject

+ (instancetype)defaultCache;

- (void)registerBeanClass:(Class)class;
- (BeanEntity *)beanEntityForClassName:(NSString *)beanClass;

@end
