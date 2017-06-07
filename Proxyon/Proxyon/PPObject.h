//
//  PPObject.h
//  Proxyon
//
//  Created by Jorris on 08/06/2017.
//  Copyright © 2017 Jorris. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PPObject <NSObject>

+ (instancetype)instanceWithIdentifier:(NSString *)identifier;

- (void)dump;

- (void)disconnect;

@end
