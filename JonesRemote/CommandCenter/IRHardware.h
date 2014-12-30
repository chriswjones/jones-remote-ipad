#import "IREnum.h"

@protocol IRHardware <NSObject>

+ (NSString *)stringForIRCommand:(enum IRCommand)command;

@end