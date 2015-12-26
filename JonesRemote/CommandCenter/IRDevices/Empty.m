#import "Empty.h"


@implementation Empty

+ (NSString *)stringForIRCommand:(enum IRCommand)command {
    switch (command) {
        case IRCommandEmpty:
            return @"38000,1,1,228,46,46,45,23,22,23,22,46,22,46,22,23,22,23,22,23,22,23,760";
        default:
            return @"";
    }
}

@end