//
//  ViewController.m
//  Proxyon
//
//  Created by Jorris on 08/06/2017.
//  Copyright © 2017 Jorris. All rights reserved.
//

#import "ViewController.h"
#import "Proxyon.h"
#import "PPObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Class<PPObject> cls = ProxyonClassFromString(@"PPObject");
    id<PPObject> obj = [cls instanceWithIdentifier:[NSUUID UUID].UUIDString];
    [obj disconnect];
    [obj dump];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
