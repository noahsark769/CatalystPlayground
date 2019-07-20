//
//  AppKitBundleLoader.h
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_MACCATALYST || IS_APPKIT_BUNDLE
#import <AppKit/AppKit.h>
#endif

@protocol UIKitBridge;

NS_ASSUME_NONNULL_BEGIN

@protocol AppKitObjcBridge <NSObject>

- (void)moveWindowRight;
#if TARGET_OS_MACCATALYST || IS_APPKIT_BUNDLE
- (NSToolbarItem *)customToolbarItemWithIdentifier:(NSString *)identifier callback:(void (^)(NSString *))callback NS_SWIFT_NAME(customToolbarItem(identifier:callback:));
#endif
- (void)setUIKitBridge:(id<UIKitBridge>)bridge;
- (void)setPointerCursor;
- (void)setDefaultCursor;
- (void)sceneBecameActiveWithIdentifier:(NSString *)string NS_SWIFT_NAME(sceneBecameActive(identifier:));

@end

@interface AppKitBundleLoader : NSObject

- (id<AppKitObjcBridge>)loadBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
