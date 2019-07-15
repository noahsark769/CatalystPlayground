//
//  AppKitBundleLoader.h
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppKitObjcBridge <NSObject>

- (void)moveWindowRight;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AppKitBundleLoader : NSObject

- (id<AppKitObjcBridge>)loadBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
