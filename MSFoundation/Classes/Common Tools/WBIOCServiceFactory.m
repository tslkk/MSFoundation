//
//  WBIOCServiceFactory.m
//  Pods
//
//  Created by pengfei on 2017/8/22.
//
//

#import "WBIOCServiceFactory.h"
#import "NSObject+DeallocNotification.h"

static WBIOCServiceFactory *serviceInstance = nil;

#define WBIOCObtainParam(inputParams,signature) va_list paramList;\
va_start(paramList, param0);\
{\
for (int i = 2; i < [signature numberOfArguments]; i++){\
const char *argumentType = [signature getArgumentTypeAtIndex:i];\
switch (argumentType[0] == 'r' ? argumentType[1] : argumentType[0]){\
        case '@':{\
            if(i == 2){\
                [inputParams addObject:param0];\
            }\
            else{\
                id value = va_arg(paramList, id);\
                [(inputParams) addObject:value];\
            }\
        }\
        break;\
    default: {\
        NSAssert(YES, @"params中的参数只能是id类型！");\
        return nil;\
    }\
}\
}\
if(inputParams.count+2 != signature.numberOfArguments){\
    NSAssert(YES, @"params中的参数个数与Seletor中定义的不一致！");\
}\
}\
va_end(paramList);\

@interface WBIOCServiceFactory ()

@property(nonatomic,strong) id tmpClassInstance;

//接口与具体实现类之间的映射关系
@property(nonatomic,strong) NSMutableDictionary *serviceMappingDict;

//存储key与instance的映射关系
//此处的instance的生命周期受IOC框架控制
@property(nonatomic,strong) NSMutableDictionary *instanceDict;

//控制serviceMappingDict的数据add／get／delete
@property(nonatomic,strong) dispatch_queue_t serviceMappingConQueue;
//控制instanceDict的数据add／get／delete
@property(nonatomic,strong) dispatch_queue_t instanceConQueue;

- (id) init;

@end

@implementation WBIOCServiceFactory

-(id) init{
    self = [super init];
    
    self.serviceMappingDict = [NSMutableDictionary dictionary];
    self.instanceDict = [NSMutableDictionary dictionary];
    self.serviceMappingConQueue = dispatch_queue_create("WBPageTransferDispatch.serviceMappingDict", DISPATCH_QUEUE_CONCURRENT);
    self.instanceConQueue = dispatch_queue_create("WBPageTransferDispatch.instanceConQueue", DISPATCH_QUEUE_CONCURRENT);
    
    self.tmpClassInstance = nil;
    
    return self;
}

+(WBIOCServiceFactory*) serviceFactoryInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serviceInstance = [[WBIOCServiceFactory alloc]init];
    });
    
    return serviceInstance;
}

#pragma mark ==注册业务实现类

/**
 注册指定的Class，通常此Class是某一个protocol的实现类
 
 @param aClass  注册的Class
 @param aKey  在注册module时指定标示module的唯一标识，key为可选值，
 当key为nil时，仅使用Class Name字符串
 */
-(void) registerClass:(Class) aClass
              withKey:(NSString*) aKey{
    //获取map key
    NSString *implClassMapKey = [self produceMapKey:aClass withKey:aKey];
    
    //采用barrier，使得其他的get／delete操作被锁住，
    //采用async，使得其他操作serviceMappingDict的逻辑代码可以执行
    dispatch_barrier_async(_serviceMappingConQueue, ^{
        //查询是否有相同的key,如果有，执行断言
        if ([self.serviceMappingDict objectForKey:implClassMapKey]) {
            NSString *alertInfo = [NSString stringWithFormat:@"当前业务类%@注册WBIOCServiceFactory时key冲突！",aClass];
            NSAssert(1, alertInfo);
        }
        
        //往map字典中存储映射关系
        [self.serviceMappingDict setObject:aClass forKey:implClassMapKey];

    });
    
}

//生成serviceMappingDict中存储key
-(NSString*) produceMapKey:(Class) aClass
                   withKey:(NSString*) aKey{
    NSString *implClassMapKey = aKey;
    
    //key为空，则取Class的类名字符串，作为key
    if (aKey == nil) {
        implClassMapKey = NSStringFromClass(aClass);
    }
    
    return implClassMapKey;
}

#pragma mark ==获取业务实现类

- (Class) moduleClassForKey:(NSString*) key{
    __block Class serviceClass = nil;
    if (key && key.length > 0) {
        //此处不使用barrier，使得多个任务并发get的时候不用加锁，互不影响
        //使用sync，使得其他操作serviceMappingDict的逻辑代码阻塞，等待当前任务执行完
        dispatch_sync(_serviceMappingConQueue, ^{
            serviceClass = [self.serviceMappingDict objectForKey:key];
        });
    }
    return serviceClass;
}

/**
 使用默认初始化方法构造Class对应的实例instance
 
 @param key  在注册module时指定标示module的唯一标识
 
 @return id  注册module Class对应的实例instance，采用默认初始化方法构造instance
 */
-(id) moduleForKey:(NSString*) key{
    
    id classInstance = nil;
    
    if (key && key.length > 0) {
        __block Class serviceClass = nil;
        
        //此处不使用barrier，使得多个任务并发get的时候不用加锁，互不影响
        //使用sync，使得其他操作serviceMappingDict的逻辑代码阻塞，等待当前任务执行完
        dispatch_sync(_serviceMappingConQueue, ^{
            serviceClass = [self.serviceMappingDict objectForKey:key];
        });
        
        if (serviceClass == nil) {
            return nil;
        }
        
        //如果实现了单例，则调用单例创建instance
        if ([[serviceClass class] respondsToSelector:@selector(wbIOCSharedInstance)]){
            classInstance = [[serviceClass class] performSelector:@selector(wbIOCSharedInstance)];
        }
        //否则调用默认构造函数初始化
        else{
            classInstance = [[serviceClass alloc]init];
        }
    }
    
    return classInstance;
}


/**
 使用默认初始化方法构造Class对应的实例instance
 初始化完的instance在框架中进行存储，直到lifeClass被释放时触发销毁
 
 @param key  在注册module时指定标示module的唯一标识
 @param lifeClass instance的生命周期由lifeClass控制，lifeClass被销毁时自动销毁instance
 如果lifeClass == nil,则返回nil。
 
 @return id  注册module Class对应的实例instance，采用默认初始化方法构造instance
 如果已经调用过一次，则返回的instance是第一次创建的
 
 @warning: 由于instance的生命周期受liefeClass销毁时控制，所以lifeClass一定不能持有instance。
 如果lifeClass必须持有instance，则调用-(id) moduleForKey:(NSString*) key即可。
 */
-(id) moduleForKey:(NSString*) key withLifeClass:(id) lifeClass{
    __block id classInstance = nil;
    
    if (key == nil || key.length == 0) {
        return nil;
    }
    
    //如果传入的lifeClass为空，则返回-(id) moduleForKey:(NSString*) key的调用结果。
    if (lifeClass == nil) {
        //return [self moduleForKey:key];
        return nil;
    }
    
    //先获取是否有存储
    dispatch_sync(_instanceConQueue, ^{
        classInstance = [self.instanceDict objectForKey:key];
    });
    
    //如果没有，则首次创建
    if (classInstance == nil) {
        classInstance = [self moduleForKey:key];
        
        //保存classInstance,并针对lifeClass绑定dealloc的处理block
        [self saveAndBindDeallocBlock:classInstance withKey:key withLifeClass:lifeClass];
    }

    return classInstance;
}

/**
 使用指定的初始化方法及对应的参数构造Class对应的实例instance
 此方法适用初始化方法需要执行自定义的方法，[[Class alloc]init]无法满足要求
 
 @param key  在注册module时指定标示module的唯一标识
 @param selector  初始化方法对应的selector
 params  selector中对应的参数
 
 @return id  注册module Class对应的实例instance，根据传入的selector及参数构造instance
 */
-(id) moduleForKey:(NSString*) key
      initSelector:(SEL) selector
            params:param0,...NS_REQUIRES_NIL_TERMINATION{
    
    id classInstance = nil;
    
    if (key && key.length > 0){
        __block Class serviceClass = nil;
        
        dispatch_sync(_serviceMappingConQueue, ^{
            serviceClass = [self.serviceMappingDict objectForKey:key];
        });
        
        if (serviceClass == nil || selector == nil) {
            return nil;
        }
        
        NSMethodSignature *signature = [[serviceClass class] instanceMethodSignatureForSelector:selector];
        NSMutableArray *inputParams = [NSMutableArray array];
        WBIOCObtainParam(inputParams,signature);
        
        classInstance = [self moduleForClass:serviceClass
                                  initTarget:[[serviceClass alloc]init]
                                initSelector:selector
                              initParamArray:inputParams];
        
    }
    
    return  classInstance;
}



/**
 
 使用指定的初始化方法及对应的参数构造Class对应的实例instance
 此方法适用初始化方法需要执行自定义的方法，[[Class alloc]init]无法满足要求
 
 @param key  在注册module时指定标示module的唯一标识
 @param lifeClass instance的生命周期由lifeClass控制，lifeClass被销毁时自动销毁instance.如果lifeClass == nil,
 则返回nil。
 @param selector 初始化方法对应的selector
 params  selector中对应的参数
 
 @return id  注册module Class对应的实例instance，根据传入的selector及参数构造instance
 
 @warning: 由于instance的生命周期受liefeClass销毁时控制，所以lifeClass一定不能持有instance。
 如果lifeClass必须持有instance，则返回nil。
 
 @warning: selector在本方法只支持实例方法，不支持类方法！
 
 */
-(id) moduleForKey:(NSString*) key
     withLifeClass:(id) lifeClass
      initSelector:(SEL) selector
        initParams:param0,...NS_REQUIRES_NIL_TERMINATION{
    
    __block id classInstance = nil;
    
    if (key == nil || key.length == 0) {
        return nil;
    }
    
    //如果传入的lifeClass为空，则返回-(id) moduleForKey:(NSString*) key的调用结果。
    if (lifeClass == nil) {
        return nil;
    }
    
    //先获取是否有存储
    dispatch_sync(_instanceConQueue, ^{
        classInstance = [self.instanceDict objectForKey:key];
    });
    
    //如果没有，则首次创建
    if (classInstance == nil) {
        __block Class serviceClass = nil;
        
        dispatch_sync(_serviceMappingConQueue, ^{
            serviceClass = [self.serviceMappingDict objectForKey:key];
        });
        
        if (serviceClass == nil || selector == nil) {
            return nil;
        }
        
        id tmpTarget = [[serviceClass alloc]init];
        
        NSMethodSignature *signature = [[serviceClass class] instanceMethodSignatureForSelector:selector];
        NSMutableArray *inputParams = [NSMutableArray array];
        WBIOCObtainParam(inputParams,signature);

        classInstance = [self moduleForClass:serviceClass
                                  initTarget:tmpTarget
                                initSelector:selector
                              initParamArray:inputParams];
        
        //保存classInstance,并针对lifeClass绑定dealloc的处理block
        [self saveAndBindDeallocBlock:classInstance withKey:key withLifeClass:lifeClass];
    }
    
    return classInstance;
}

/**
 根据key删除对应的module
 
 @param key module对应的标示
 @return YES(删除成功) NO（删除失败）
 */
-(BOOL) removeModuleForKey:(NSString*) key{
    __block BOOL removed = NO;
    
    if (key == nil || key.length <= 0) {
        return removed;
    }
    
    //采用barrier，使得其他的get／add操作被锁住，
    //使用sync，使得其他操作serviceMappingDict的逻辑代码阻塞，等待当前删除任务执行完
    dispatch_barrier_sync(_serviceMappingConQueue, ^{
        Class aClass = [self.serviceMappingDict objectForKey:key];
        if (aClass != nil) {
            [self.serviceMappingDict removeObjectForKey:key];
            removed = YES;
        }
    });
    
    return removed;
}

#pragma mark == 私有方法，代码重用

//保存classInstance,并针对lifeClass绑定dealloc的处理block
-(void) saveAndBindDeallocBlock:(id) classInstance
                        withKey:(NSString*) key
                  withLifeClass:(id) lifeClass{
    //将classInstance存储在缓存中
    dispatch_barrier_async(_instanceConQueue, ^{
        if (classInstance) {
            [self.instanceDict setObject:classInstance forKey:key];
        }
    });
    
    //将classIntance的生命周期绑定在lifeClass上
    __weak __typeof (self.instanceDict) weakDict = self.instanceDict;
    [lifeClass setDeallocNotificationWithKey:[key UTF8String] andBlock:^{
        [weakDict removeObjectForKey:key];
    }];
}

-(id) moduleForClass:(Class) serviceClass
          initTarget:(id) target
        initSelector:(SEL) selector
      initParamArray:(NSArray*) arguments{
    id classInstance = nil;
    
    if ([serviceClass instancesRespondToSelector:selector]) {
        
        NSMethodSignature *signature = [[serviceClass class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = target;
        invocation.selector = selector;
        
        // invocation 有2个隐藏参数，所以 argument 从2开始
        if (arguments && [arguments isKindOfClass:[NSArray class]]) {
            NSInteger count = MIN(arguments.count, signature.numberOfArguments - 2);
            for (NSUInteger index = 0; index < count; index++) {
                const char *type = [signature getArgumentTypeAtIndex:2 + index];
                
                // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
                if (strcmp(type, "@") == 0) {
                    id argument = arguments[index];
                    [invocation setArgument:&argument atIndex:2 + index];
                }
            }
        }
        
        //执行方法
        [invocation invoke];
        
        //获取返回参数
        void *tempResultSet = NULL;
        if (strcmp(signature.methodReturnType, "@") == 0) {
            [invocation getReturnValue:&tempResultSet];
            classInstance = (__bridge id) tempResultSet;
        }
        
    }//if ([[serviceClass class]
    
    return classInstance;
}
@end
