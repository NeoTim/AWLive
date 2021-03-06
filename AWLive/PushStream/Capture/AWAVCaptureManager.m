/*
 copyright 2016 wanghongyu.
 The project page：https://github.com/hardman/AWLive
 My blog page: http://blog.csdn.net/hard_man/
 */

#import "AWAVCaptureManager.h"
#import "AWSystemAVCapture.h"

@interface AWAVCaptureManager()
@property (nonatomic, strong) AWSystemAVCapture *systemAvCapture;
@end

@implementation AWAVCaptureManager


-(AWSystemAVCapture *)systemAvCapture{
    if (!_systemAvCapture) {
        _systemAvCapture = [[AWSystemAVCapture alloc] initWithVideoConfig:self.videoConfig audioConfig:self.audioConfig];
    }
    return _systemAvCapture;
}

-(AWAVCapture *)avCapture{
    if (!self.audioEncoderType) {
        NSLog(@"[E] AVAVCaptureManager 未设置audioEncoderType");
        return nil;
    }
    
    if (!self.videoEncoderType) {
        NSLog(@"[E] AVAVCaptureManager 未设置videoEncoderType");
        return nil;
    }
    
    if (!self.videoConfig) {
        NSLog(@"[E] AWAVCaptureManager 未设置videoConfig");
        return nil;
    }else{
        //对视频分辨率做一些限制。我使用的是iphone6splus测试，下面几个分辨率前后摄像头都支持。
        //手上没有iphone4 iphone5。所以有可能下面有不支持的分辨率。
        //就需要根据手机型号来判断/自动设置支持的分辨率了。
        if(
           !(self.videoConfig.width == 480 && self.videoConfig.height == 640) &&
           !(self.videoConfig.width == 540 && self.videoConfig.height == 960) &&
           !(self.videoConfig.width == 720 && self.videoConfig.height == 1280)
           ){
            NSLog(@"[E] AWAVCaptureManager 只支持下面视频分辨率：480*640 960*540 720*1280");
            return nil;
        }
    }
    
    if (!self.audioConfig) {
        NSLog(@"[E] AWAVCaptureManager 未设置audioConfig");
        return nil;
    }
    
    AWAVCapture *capture = nil;
    capture = self.systemAvCapture;
    
    if (capture) {
        capture.audioEncoderType = self.audioEncoderType;
        capture.videoEncoderType = self.videoEncoderType;
    }
    
    return capture;
}


@end
