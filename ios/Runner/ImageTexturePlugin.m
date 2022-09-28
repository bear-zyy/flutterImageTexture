//
//  ImageTexturePlugin.m
//  Runner
//
//  Created by 张源远 on 2022/9/26.
//

#import "ImageTexturePlugin.h"

#import "TextureView.h"

@interface ImageTexturePlugin ()
{

}


@property (nonatomic , strong) NSObject<FlutterTextureRegistry> * textures;

@end

@implementation ImageTexturePlugin

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    
    FlutterMethodChannel * methodChannel = [FlutterMethodChannel methodChannelWithName:@"ImageTexturePlugin" binaryMessenger:registrar.messenger];
    [registrar addMethodCallDelegate:[[ImageTexturePlugin alloc] initWith:registrar] channel:methodChannel];
    
    
}

-(instancetype)initWith:(nonnull NSObject<FlutterPluginRegistrar> *)registrar{
    if ([self init]) {
        self.textures = registrar.textures;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    
    if ([call.method isEqualToString:@"showNativeImage"]) {
        NSLog(@"showNativeImage");
        
        TextureView * textureView = [[TextureView alloc] initWithUrl:call.arguments[@"url"]];
        
        int64_t textureId = [self.textures registerTexture:textureView];
        
        [self.textures textureFrameAvailable:textureId];
        
        result(@(textureId));
        
    }
    
}




@end
