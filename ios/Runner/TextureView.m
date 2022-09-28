//
//  TextureView.m
//  Runner
//
//  Created by 张源远 on 2022/9/26.
//

#import "TextureView.h"
#import <SDWebImage/SDWebImage.h>

@interface TextureView ()

@property (nonatomic) CVPixelBufferRef target;

@property (nonatomic , strong) UIImageView * imageView;

@end

@implementation TextureView

-(instancetype)initWithUrl:(NSString *)url{
    if ([self init]) {
        [self loadImageWithStrFromWeb:url];
    }
    return  self;
}


- (CVPixelBufferRef _Nullable)copyPixelBuffer {
    return _target;
}

-(void)loadImageWithStrFromWeb:(NSString*)imageStr{
    
    __weak typeof(self) weakSelf = self;
    
    self.imageView = [[UIImageView alloc] init];
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.target = [weakSelf CVPixelBufferRefFromUiImage:image size:CGSizeMake(100, 100)];
    }];
    
//    __weak typeof weakSelf = self;
    
//    __weak typeof(DuiaflutterextexturePresenter*) weakSelf = self;
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageStr] options:SDWebImageDownloaderUseNSURLCache context:[SDImageCacheTypeMemory: YES] progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//
//        }];
    
//    SDImageCache * c ;
//
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageStr] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//        NSLog(@"receivedSize == %lu , expectedSize == %lu" ,receivedSize  , expectedSize);
//        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//            weakSelf.target = [weakSelf CVPixelBufferRefFromUiImage:image size:CGSizeMake(100, 100)];
//        }];
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL: [NSURL URLWithString:imageStr]completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//
//        weakSelf.target = [weakSelf CVPixelBufferRefFromUiImage:image size:CGSizeMake(100, 100)];
//
//
//
////        if (weakSelf.asGif) {
////            for (UIImage * uiImage in image.images) {
////                NSDictionary *dic = @{
////                    @"duration":@(image.duration*1.0/image.images.count),
////                    @"image":uiImage
////                };
////                [weakSelf.images addObject:dic];
////            }
////            [weakSelf startGifDisplay];
////        } else {
//
////            if (weakSelf.updateBlock) {
////                weakSelf.updateBlock();
////            }
////        }
//
//    }];
   
}

// 此方法能还原真实的图片
- (CVPixelBufferRef)CVPixelBufferRefFromUiImage:(UIImage *)img size:(CGSize)size {
    if (!img) {
        return nil;
    }
    CGImageRef image = [img CGImage];
    
    //    CGSize size = CGSizeMake(5000, 5000);
//    CGFloat frameWidth = CGImageGetWidth(image);
//    CGFloat frameHeight = CGImageGetHeight(image);
    CGFloat frameWidth = size.width;
    CGFloat frameHeight = size.height;
    
    //兼容外部 不传大小
    frameWidth = CGImageGetWidth(image);
    frameHeight = CGImageGetHeight(image);
    
    
    BOOL hasAlpha = CGImageRefContainsAlpha(image);
    CFDictionaryRef empty = CFDictionaryCreate(kCFAllocatorDefault, NULL, NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             empty, kCVPixelBufferIOSurfacePropertiesKey,
                             nil];
    
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, frameWidth, frameHeight, kCVPixelFormatType_32BGRA, (__bridge CFDictionaryRef) options, &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    uint32_t bitmapInfo = bitmapInfoWithPixelFormatType(kCVPixelFormatType_32BGRA, (bool)hasAlpha);
    CGContextRef context = CGBitmapContextCreate(pxdata, frameWidth, frameHeight, 8, CVPixelBufferGetBytesPerRow(pxbuffer), rgbColorSpace, bitmapInfo);
    //    CGContextRef context = CGBitmapContextCreate(pxdata, size.width, size.height, 8, CVPixelBufferGetBytesPerRow(pxbuffer), rgbColorSpace, (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0, 0, frameWidth, frameHeight), image);
    
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}


BOOL CGImageRefContainsAlpha(CGImageRef imageRef) {
    if (!imageRef) {
        return NO;
    }
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    BOOL hasAlpha = !(alphaInfo == kCGImageAlphaNone ||
                      alphaInfo == kCGImageAlphaNoneSkipFirst ||
                      alphaInfo == kCGImageAlphaNoneSkipLast);
    return hasAlpha;
}

static uint32_t bitmapInfoWithPixelFormatType(OSType inputPixelFormat, bool hasAlpha){
    
    if (inputPixelFormat == kCVPixelFormatType_32BGRA) {
        uint32_t bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host;
        if (!hasAlpha) {
            bitmapInfo = kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Host;
        }
        return bitmapInfo;
    }else if (inputPixelFormat == kCVPixelFormatType_32ARGB) {
        uint32_t bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big;
        return bitmapInfo;
    }else{
        NSLog(@"不支持此格式");
        return 0;
    }
}




@end
