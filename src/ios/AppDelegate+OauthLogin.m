//
//  AppDelegate+OauthLogin.m
//  OauthLogin
//
//  Created by 村上 健太 on 2018/03/11.
//

#import "AppDelegate+OauthLogin.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <objc/runtime.h>
@import LineSDKObjC;

@implementation AppDelegate (FacebookConnectPlugin)

- (BOOL)application:(UIApplication *)application
openURL:(NSURL *)url
options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.absoluteString hasPrefix:@"fb"]) {
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
            openURL:url
            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
            annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                        ];
        return handled;
    } else {
        return [[LineSDKLoginManager sharedInstance] handleOpenURL:url];
    }
}
@end
