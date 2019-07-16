//
//  AppKitBundleLoader.h
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AppKitObjcBridge <NSObject>

- (void)moveWindowRight;
- (NSToolbarItem *)customToolbarItem;

@end

@interface AppKitBundleLoader : NSObject

- (id<AppKitObjcBridge>)loadBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
