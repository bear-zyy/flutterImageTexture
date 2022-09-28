//
//  ImageTexturePlugin.h
//  Runner
//
//  Created by 张源远 on 2022/9/26.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageTexturePlugin : NSObject<FlutterPlugin>

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar;

@end

NS_ASSUME_NONNULL_END
