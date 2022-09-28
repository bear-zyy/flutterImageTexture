//
//  TextureView.h
//  Runner
//
//  Created by 张源远 on 2022/9/26.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>>

NS_ASSUME_NONNULL_BEGIN

@interface TextureView : NSObject<FlutterTexture>

-(instancetype)initWithUrl:(NSString*)url;


@end

NS_ASSUME_NONNULL_END
