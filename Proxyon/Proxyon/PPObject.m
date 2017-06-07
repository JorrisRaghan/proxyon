//
//  PPObject.m
//  Proxyon
//
//  Created by Jorris on 08/06/2017.
//  Copyright © 2017 Jorris. All rights reserved.
//

#import "PPObject.h"

@interface PPObject : NSObject<PPObject>

@end

@interface PPObject ()

@property (nonatomic) NSString *identifier;

@end

@implementation PPObject

- (void)dealloc
{
    NSLog(@"DEALLOC PPObject:%@", _identifier);
}

+ (instancetype)instanceWithIdentifier:(NSString *)identifier
{
    if (identifier.length == 0) return nil;
    PPObject *obj = [self new];
    obj.identifier = identifier;
    return obj;
}

- (void)dump
{
    NSLog(@"PPObject:%@", _identifier);
}

- (void)disconnect
{
    
}


@end
