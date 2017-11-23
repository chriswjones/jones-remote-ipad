#import <Foundation/Foundation.h>
#import "IRHardware.h"
#import "MatrixEnum.h"


@interface Marantz : NSObject <IRHardware>

+ (void)routeAudio:(enum InputDevice)input;

@end
