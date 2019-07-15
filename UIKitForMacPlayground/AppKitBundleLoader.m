//
//  AppKitBundleLoader.m
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

#import "AppKitBundleLoader.h"

@implementation AppKitBundleLoader

- (id<AppKitObjcBridge>)loadBundle:(NSBundle *)bundle {
    id<AppKitObjcBridge> bridge = [[[bundle principalClass] alloc] init];
    return bridge;
}

@end
