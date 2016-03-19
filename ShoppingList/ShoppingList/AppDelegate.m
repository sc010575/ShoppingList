//
//  AppDelegate.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:25.0f] }];
    return YES;
}


@end
