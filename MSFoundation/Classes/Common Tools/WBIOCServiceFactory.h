//
//  WBIOCServiceFactory.h
//
//(1)此类用来设计处理面向接口的消息通讯
//(2)此类与其他IOC框架不同，主要处理protocol及ImplClass直接的耦合关系，
//(3)所以调用者需要根据需求场景来使用
//
//  Created by pengfei on 2017/8/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NSString * IOCModuleKey NS_SWIFT_BRIDGED_TYPEDEF;

@protocol WBIOCProtocol <NSObject>

//如果有自己的单例实例，只需要实现此协议，moduleForKey的时候会自动返回业务类里面的实例。
+(id) wbIOCSharedInstance;

@end

@interface WBIOCServiceFactory : NSObject

//组件注册方法的宏封装
//（1）key为service类的唯一标示，
//（2）如果key为空，则系统默认取service类名字符串
#define REGISTER_WBIOC_SERVICE(key) \
+ (void)load {\
[[WBIOCServiceFactory serviceFactoryInstance]registerClass:self\
 withKey:key];\
}

//工厂类实例
#define IOC_SERVICEFACTORY_INSTANCE [WBIOCServiceFactory serviceFactoryInstance]

//单例构造函数
+(WBIOCServiceFactory*) serviceFactoryInstance;

/**
 注册指定的Class，通常此Class是某一个protocol的实现类
 
 @param aClass  注册的Class
 @param aKey  在注册module时指定标示module的唯一标识，key为可选值，
 当key为nil时，仅使用Class Name字符串
 */
-(void) registerClass:(Class) aClass
              withKey:(IOCModuleKey) aKey;

/**
 获取对应module的Class
 
 @param key  在注册module时指定标示module的唯一标识
 
 @return Class 注册的module Class
 */
- (nullable Class) moduleClassForKey:(IOCModuleKey) key;

/**
 使用默认初始化方法构造Class对应的实例instance
 
 @param key  在注册module时指定标示module的唯一标识
 
 @return id  注册module Class对应的实例instance，采用默认初始化方法构造instance
 */
-(nullable id) moduleForKey:(IOCModuleKey) key;

/**
 使用默认初始化方法构造Class对应的实例instance
 初始化完的instance在框架中进行存储，直到lifeClass被释放时触发销毁
 
 @param key  在注册module时指定标示module的唯一标识
 @param lifeClass instance的生命周期由lifeClass控制，lifeClass被销毁时自动销毁instance
         如果lifeClass为nil，则直接返回nil
 
 @return id  注册module Class对应的实例instance，采用默认初始化方法构造instance
 如果已经调用过一次，则返回的instance是第一次创建的
 
 @warning: 由于instance的生命周期受liefeClass销毁时控制，所以lifeClass一定不能持有instance。
 如果lifeClass必须持有instance，则返回nil。
 */
-(nullable id) moduleForKey:(IOCModuleKey) key withLifeClass:(id) lifeClass;

/**
 使用指定的初始化方法及对应的参数构造Class对应的实例instance
 
 @param key  在注册module时指定标示module的唯一标识
 @param selector  初始化方法对应的selector
 params  selector中对应的参数
 
 @return id  注册module Class对应的实例instance，根据传入的selector及参数构造instance
 
 @warning: selector在本方法只支持实例方法，不支持类方法！
 */
-(nullable id) moduleForKey:(IOCModuleKey) key
               initSelector:(SEL) selector
                     params:param0,...NS_REQUIRES_NIL_TERMINATION;

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
-(nullable id) moduleForKey:(IOCModuleKey) key
              withLifeClass:(id) lifeClass
               initSelector:(SEL) selector
                 initParams:param0,...NS_REQUIRES_NIL_TERMINATION;

/**
 根据key删除对应的module
 
 @param key module对应的标示
 @return YES(删除成功) NO（删除失败）
 */
-(BOOL) removeModuleForKey:(IOCModuleKey) key;

@end


NS_ASSUME_NONNULL_END
