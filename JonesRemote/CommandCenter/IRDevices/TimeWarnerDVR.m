//
// Created by chris on 7/27/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TimeWarnerDVR.h"


@implementation TimeWarnerDVR

+ (NSString *)stringForIRCommand:(enum IRCommand)command {
    switch (command) {
        case IRCommandPowerOnOff:
            return @"";
        case IRCommandStar:
            return @"58000,1,1,192,192,48,47,48,47,48,144,48,144,48,144,48,144,48,144,48,144,48,144,48,144,48,47,48,144,48,144,48,47,48,47,48,47,48,47,48,47,48,47,48,47,48,47,48,144,48,1160";
        case IRCommandPound:
            return @"58000,1,1,192,191,48,144,48,144,48,48,48,144,48,144,48,48,48,144,48,48,48,144,48,144,48,144,48,48,48,48,48,144,48,48,48,48,48,144,48,48,48,144,48,48,48,48,48,48,48,1160";
        case IRCommand0:
            return @"58000,1,1,192,191,48,144,48,144,48,47,48,144,48,144,48,144,48,47,48,47,48,144,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,144,48,47,48,47,48,144,48,1160";
        case IRCommand1:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,47,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,144,48,144,48,144,48,144,48,47,48,144,48,1160";
        case IRCommand2:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,145,48,47,48,47,48,47,48,145,48,47,48,47,48,47,48,145,48,47,48,47,48,47,48,145,48,145,48,145,48,47,48,145,48,1160";
        case IRCommand3:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,47,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,145,48,47,48,47,48,145,48,47,48,145,48,145,48,47,48,145,48,1160";
        case IRCommand4:
            return @"58000,1,1,192,191,48,144,48,144,48,47,48,144,48,144,48,144,48,144,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,47,48,144,48,144,48,47,48,144,48,1160";
        case IRCommand5:
            return @"57000,1,1,192,191,48,144,48,144,46,47,48,144,48,144,46,47,46,47,48,144,46,47,48,144,46,47,46,47,46,47,48,144,46,47,46,47,48,144,48,144,46,47,48,144,46,47,48,144,48,1140";
        case IRCommand6:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,144,48,47,48,144,48,47,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,47,48,144,48,47,48,144,48,1160";
        case IRCommand7:
            return @"57000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,47,48,145,48,145,48,47,48,145,48,47,48,47,48,47,48,145,48,47,48,47,48,145,48,47,48,47,48,145,48,47,48,145,48,1140";
        case IRCommand8:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,145,48,145,48,145,48,47,48,145,48,47,48,47,48,47,48,145,48,47,48,47,48,47,48,47,48,47,48,145,48,47,48,145,48,1160";
        case IRCommand9:
            return @"58000,1,1,192,191,48,144,48,144,48,48,48,144,48,144,48,48,48,48,48,48,48,144,48,144,48,48,48,48,48,48,48,144,48,48,48,48,48,144,48,144,48,144,48,48,48,48,48,144,48,1160";
        case IRCommandSelect:
            return @"58000,1,1,192,191,48,144,48,144,48,48,48,144,48,144,48,48,48,48,48,144,48,144,48,48,48,48,48,48,48,48,48,144,48,48,48,48,48,144,48,144,48,48,48,48,48,144,48,144,48,1160";
        case IRCommandLeft:
            return @"57000,1,1,192,191,48,144,48,144,48,47,48,144,48,144,48,144,48,144,48,47,48,47,48,47,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,47,48,144,48,144,48,144,48,144,48,1140";
        case IRCommandRight:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,47,48,47,48,145,48,47,48,47,48,145,48,145,48,47,48,145,48,145,48,145,48,1160";
        case IRCommandUp:
            return @"58000,1,1,192,192,48,145,48,145,47,47,48,145,48,145,47,47,48,145,47,47,47,47,47,47,47,47,47,47,47,47,48,145,47,47,47,47,48,145,47,47,48,145,48,145,48,145,48,145,47,1160";
        case IRCommandDown:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,144,48,144,48,47,48,144,48,47,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,47,48,144,48,47,48,144,48,144,48,1160";
        case IRCommandPageUp:
            return @"58000,1,1,192,191,48,144,48,144,48,47,48,144,48,144,48,47,48,144,48,144,48,47,48,144,48,144,48,47,48,47,48,144,48,47,48,47,48,144,48,47,48,47,48,144,48,47,48,47,48,1160";
        case IRCommandPageDown:
            return @"58000,1,1,192,191,48,144,48,144,48,47,48,144,48,144,48,144,48,144,48,144,48,47,48,144,48,144,48,47,48,47,48,144,48,47,48,47,48,47,48,47,48,47,48,144,48,47,48,47,48,1160";
        case IRCommandInfo:
            return @"58000,1,1,192,191,48,144,48,144,48,48,48,144,48,144,48,48,48,48,48,48,48,144,48,48,48,48,48,48,48,48,48,144,48,48,48,48,48,144,48,144,48,144,48,48,48,144,48,144,48,1160";
        case IRCommandPause:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,145,48,47,48,145,48,47,48,47,48,47,48,47,48,47,48,145,48,47,48,47,48,47,48,145,48,47,48,145,48,145,48,145,48,1160";
        case IRCommandPlay:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,145,48,145,48,47,48,47,48,145,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,47,48,145,48,145,48,47,48,47,48,1160";
        case IRCommandRewind:
            return @"57000,1,1,192,191,48,144,48,144,48,47,48,144,48,144,48,144,48,47,48,47,48,144,48,47,48,144,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,144,48,47,48,144,48,47,48,1140";
        case IRCommandFastForward:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,47,48,47,48,47,48,144,48,47,48,144,48,47,48,47,48,144,48,47,48,47,48,144,48,144,48,144,48,47,48,144,48,47,48,1160";
        case IRCommandStop:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,47,48,47,48,145,48,47,48,145,48,145,48,47,48,47,48,145,48,47,48,47,48,145,48,145,48,47,48,145,48,47,48,47,48,1160";
        case IRCommandRecord:
            return @"58000,1,1,192,191,48,144,48,144,48,48,48,144,48,144,48,144,48,48,48,144,48,48,48,144,48,144,48,48,48,48,48,144,48,48,48,48,48,48,48,144,48,48,48,144,48,48,48,48,48,1160";
        case IRCommandA:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,145,48,145,48,145,48,145,48,47,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,47,48,47,48,47,48,145,48,47,48,1160";
        case IRCommandB:
            return @"30000,1,1,30,170,19,79,23,73,29,22,19,79,32,73,35,23,29,22,29,22,29,22,32,72,43,74,47,22,44,21,45,71,45,23,48,21,46,71,46,73,46,73,48,71,48,21,45,23,48,600";
        case IRCommandC:
            return @"58000,1,1,192,191,48,145,48,145,48,48,48,145,48,145,48,145,48,48,48,48,48,48,48,145,48,145,48,48,48,48,48,145,48,48,48,48,48,48,48,145,48,145,48,145,48,48,48,48,48,1160";
        case IRCommandD:
            return @"58000,1,1,192,191,48,47,48,47,48,144,48,144,48,144,48,144,48,47,48,144,48,144,48,144,48,144,48,144,48,144,48,47,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,47,48,1160";
        case IRCommandExit:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,47,48,47,48,144,48,144,48,47,48,144,48,47,48,47,48,144,48,47,48,47,48,144,48,144,48,47,48,47,48,144,48,47,48,1160";
        case IRCommandGuide:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,47,48,145,48,145,48,47,48,47,48,47,48,47,48,47,48,145,48,47,48,47,48,145,48,47,48,47,48,145,48,145,48,145,48,1160";
        case IRCommandRecordedShows:
            return @"58000,1,1,192,191,48,145,48,145,48,48,48,145,48,145,48,48,48,145,48,145,48,48,48,48,48,145,48,48,48,48,48,145,48,48,48,48,48,145,48,48,48,48,48,145,48,145,48,48,48,1160";
        case IRCommandPlusChannel:
            return @"57000,1,1,192,190,48,144,48,144,48,47,48,144,48,144,48,144,48,47,48,144,48,144,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,1140";
        case IRCommandMinusChannel:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,47,48,144,48,144,48,144,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,144,48,47,48,47,48,47,48,47,48,144,48,1160";
        case IRCommandPlusDay:
            return @"58000,1,1,192,191,48,48,48,48,48,144,48,144,48,144,48,144,48,144,48,144,48,144,48,48,48,48,48,144,48,144,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,144,48,144,48,1160";
        case IRCommandMinusDay:
            return @"58000,1,1,192,191,48,47,48,47,48,145,48,145,48,145,48,47,48,47,48,47,48,47,48,145,48,47,48,145,48,145,48,47,48,47,48,47,48,145,48,145,48,145,48,145,48,47,48,145,48,1160";
        case IRCommandLive:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,47,48,144,48,47,48,144,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,144,48,47,48,144,48,47,48,47,48,144,48,1160";
        case IRCommandMenu:
            return @"58000,1,1,192,192,48,145,48,145,48,47,48,145,48,145,48,47,48,145,48,145,48,145,48,145,48,145,48,47,48,47,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,47,48,47,48,1160";
        case IRCommandSettings:
            return @"58000,1,1,192,192,48,144,48,144,47,47,48,144,48,144,48,144,47,47,47,47,48,144,48,144,48,144,47,47,47,47,48,144,47,47,47,47,47,47,48,144,48,144,47,47,47,47,47,47,48,1160";
        case IRCommandFAV:
            return @"58000,1,1,192,192,48,144,48,144,48,47,48,144,48,144,48,144,48,144,48,144,48,144,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,47,48,47,48,47,48,47,48,144,48,1160";
        case IRCommandLast:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,47,48,145,48,145,48,145,48,47,48,47,48,47,48,47,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,145,48,145,48,1160";
        case IRCommandHelp:
            return @"58000,1,1,192,191,48,144,48,144,48,47,48,144,48,144,48,144,48,47,48,47,48,144,48,144,48,47,48,47,48,47,48,144,48,47,48,47,48,47,48,144,48,144,48,47,48,47,48,144,48,1160";
        case IRCommandOnDemand:
            return @"58000,1,1,192,192,48,145,48,145,48,47,48,145,48,145,48,145,48,47,48,47,48,145,48,145,48,47,48,47,48,47,48,145,48,47,48,47,48,47,48,145,48,145,48,47,48,47,48,145,48,1160";
        case IRCommandSports:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,145,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,145,48,47,48,47,48,47,48,47,48,145,48,145,48,47,48,145,48,1160";
        case IRCommandBackFifteenSec:
            return @"58000,1,1,192,191,48,145,48,145,48,47,48,145,48,145,48,145,48,145,48,145,48,47,48,47,48,145,48,47,48,47,48,145,48,47,48,47,48,47,48,47,48,47,48,145,48,145,48,47,48,1160";

        default:
            return @"";
    }
}

@end