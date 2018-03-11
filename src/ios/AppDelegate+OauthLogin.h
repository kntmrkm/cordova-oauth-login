//
//  AppDelegate+OauthLogin.h
//  OauthLogin
//
//  Created by 村上 健太 on 2018/03/11.
//

#import "AppDelegate.h"

@interface AppDelegate (FacebookConnectPlugin)
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options;

@end

@interface AppDelegate (LineLogin)
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options;

@end


