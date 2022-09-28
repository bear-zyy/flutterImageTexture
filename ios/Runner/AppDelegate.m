#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "ImageTexturePlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [ImageTexturePlugin registerWithRegistrar:[self registrarForPlugin:@"ImageTexturePlugin"]];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
