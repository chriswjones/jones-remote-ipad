#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "IREnum.h"
#import "MatrixEnum.h"

@interface CommandCenter : NSObject <GCDAsyncSocketDelegate>

+ (CommandCenter *)singleton;

- (void)connectSockets;

- (void)disconnectSockets;

- (void)powerMatrixOn;

- (void)powerMatrixOff;

- (void)setMatrixInput:(enum InputDevice)inputDevice toOutput:(enum OutputDevice)outputDevice;

- (void)sendIRCommand:(enum IRCommand)irCommand toIRDevice:(enum IRDevice)irDevice;

- (void)sendQueableIRCommand:(enum IRCommand)irCommand toIRDevice:(enum IRDevice)irDevice;

@end