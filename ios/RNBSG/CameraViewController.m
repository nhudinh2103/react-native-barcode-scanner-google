/*
 Copyright 2017 Google Inc.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

@import AVFoundation;
#import "GoogleMobileVision.h"

#import "CameraViewController.h"
#import "DrawingUtility.h"


@interface CameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic, weak) IBOutlet UIView *placeHolderView;
@property(nonatomic, weak) IBOutlet UIView *overlayView;

//@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property(nonatomic, strong) dispatch_queue_t videoDataOutputQueue;
//@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
//@property(nonatomic, assign) UIDeviceOrientation lastKnownDeviceOrientation;

//@property(nonatomic, strong) GMVDetector *barcodeDetector;

@end

@implementation CameraViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue",
        DISPATCH_QUEUE_SERIAL);
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.previewLayer.frame = self.view.layer.bounds;
  self.previewLayer.position = CGPointMake(CGRectGetMidX(self.previewLayer.frame),
                                           CGRectGetMidY(self.previewLayer.frame));
}

- (void)viewDidUnload {
  [self cleanupCaptureSession];
  [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.session startRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.session stopRunning];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
}

#pragma mark - AVCaptureVideoPreviewLayer Helper method

- (CGRect)scaleRect:(CGRect)rect
             xScale:(CGFloat)xscale
             yScale:(CGFloat)yscale
             offset:(CGPoint)offset {
  CGRect resultRect = CGRectMake(rect.origin.x * xscale,
                                 rect.origin.y * yscale,
                                 rect.size.width * xscale,
                                 rect.size.height * yscale);
  resultRect = CGRectOffset(resultRect, offset.x, offset.y);
  return resultRect;
}

- (CGPoint)scalePoint:(CGPoint)point
               xScale:(CGFloat)xscale
               yScale:(CGFloat)yscale
               offset:(CGPoint)offset {
  CGPoint resultPoint = CGPointMake(point.x * xscale + offset.x, point.y * yscale + offset.y);
  return resultPoint;
}

- (void)setLastKnownDeviceOrientation:(UIDeviceOrientation)orientation {
  if (orientation != UIDeviceOrientationUnknown &&
      orientation != UIDeviceOrientationFaceUp &&
      orientation != UIDeviceOrientationFaceDown) {
    _lastKnownDeviceOrientation = orientation;
  }
}

- (void)computeCameraDisplayFrameScaleProperties:(CMSampleBufferRef)sampleBuffer
                                previewFrameSize:(CGSize)previewFrameSize
                                          yScale:(CGFloat *)previewYScale
                                          xScale:(CGFloat *)previewXScale
                                          offset:(CGPoint *)previewOffset {
  /* no rw. */
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
    didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
}

#pragma mark - Camera setup

- (void)cleanupVideoProcessing {
  if (self.videoDataOutput) {
    [self.session removeOutput:self.videoDataOutput];
  }
  self.videoDataOutput = nil;
}

- (void)cleanupCaptureSession {
  [self.session stopRunning];
  [self cleanupVideoProcessing];
  self.session = nil;
  [self.previewLayer removeFromSuperlayer];
}

- (void)setUpVideoProcessing {
  self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
  NSDictionary *rgbOutputSettings = @{
    (__bridge NSString*)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)
  };
  [self.videoDataOutput setVideoSettings:rgbOutputSettings];

  if (![self.session canAddOutput:self.videoDataOutput]) {
    [self cleanupVideoProcessing];
    NSLog(@"Failed to setup video output");
    return;
  }
  [self.videoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
  [self.videoDataOutput setSampleBufferDelegate:self queue:self.videoDataOutputQueue];
  [self.session addOutput:self.videoDataOutput];
}

- (void)setUpCameraPreview {
  self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
  [self.previewLayer setBackgroundColor:[UIColor whiteColor].CGColor];
  [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
  CALayer *rootLayer = self.placeHolderView.layer;
  rootLayer.masksToBounds = YES;
  [self.previewLayer setFrame:rootLayer.bounds];
  [rootLayer addSublayer:self.previewLayer];
}

- (void)updateCameraSelection {
  [self.session beginConfiguration];

  // Remove old inputs
  NSArray *oldInputs = [self.session inputs];
  for (AVCaptureInput *oldInput in oldInputs) {
    [self.session removeInput:oldInput];
  }

  AVCaptureDevicePosition desiredPosition = AVCaptureDevicePositionBack;
  AVCaptureDeviceInput *input = [self captureDeviceInputForPosition:desiredPosition];
  if (!input) {
    // Failed, restore old inputs
    for (AVCaptureInput *oldInput in oldInputs) {
      [self.session addInput:oldInput];
    }
  } else {
    // Succeeded, set input and update connection states
    [self.session addInput:input];
  }
  [self.session commitConfiguration];
}

- (AVCaptureDeviceInput *)captureDeviceInputForPosition:(AVCaptureDevicePosition)desiredPosition {
  for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
    if (device.position == desiredPosition) {
      NSError *error = nil;
      AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                          error:&error];
      if (error) {
        NSLog(@"Could not initialize for AVMediaTypeVideo for device %@", device);
      } else if ([self.session canAddInput:input]) {
        return input;
      }
    }
  }
  return nil;
}

@end
