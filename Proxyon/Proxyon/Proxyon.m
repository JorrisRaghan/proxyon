//
//  Proxyon.m
//  Proxyon
//
//  Created by Jorris on 08/06/2017.
//  Copyright © 2017 Jorris. All rights reserved.
//

#import "Proxyon.h"
#import "PPObject.h"
#import <objc/runtime.h>

@interface Proxyon : NSProxy
{
    BOOL _instance;
    Class _cls;
    id _target;
}

@end

@interface Proxyon ()

+ (instancetype)proxyonWithClass:(Class)cls;

+ (instancetype)proxyonWithInstance:(id)instance;

@end

@implementation Proxyon

- (void)dealloc
{
    NSLog(@"DEALLOC Proxyon:%@<%@>", _instance?@"id":@"Class", _cls);
}

+ (instancetype)proxyonWithClass:(Class)cls
{
    if (!cls) return nil;
    Proxyon *proxyon = [Proxyon alloc];
    proxyon->_instance = NO;
    proxyon->_cls = cls;
    proxyon->_target = cls;
    return proxyon;
}

+ (instancetype)proxyonWithInstance:(id)instance
{
    if (!instance) return nil;
    Proxyon *proxyon = [Proxyon alloc];
    proxyon->_instance = YES;
    proxyon->_cls = [instance class];
    proxyon->_target = instance;
    return proxyon;
}

//- (BOOL)respondsToSelector:(SEL)aSelector
//{
//    return NO;
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    return nil;
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (_instance) {
        return [_cls instanceMethodSignatureForSelector:aSelector];
    } else {
        return [_cls methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (_instance && sel_isEqual(anInvocation.selector, @selector(disconnect))) {
        _target = nil;
    }
    anInvocation.target = _target;
    [anInvocation invoke];
    
    if (!_instance && sel_isEqual(anInvocation.selector, @selector(instanceWithIdentifier:))) {
        void *temp = NULL;
        [anInvocation getReturnValue:&temp];
        id obj = (__bridge id)temp;
        
        if (obj) {
            void *proxyon = (__bridge_retained void *)[Proxyon proxyonWithInstance:obj];
            [anInvocation setReturnValue:&proxyon];
        }
    }
}

@end



Class ProxyonClassFromString(NSString *aClassName)
{
    Class cls = NSClassFromString(aClassName);
    if (!cls) return nil;
    Proxyon *proxyon = [Proxyon proxyonWithClass:cls];
    return (Class)proxyon;
}
