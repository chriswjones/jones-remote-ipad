#import "Marantz.h"
#import "CommandCenter.h"

@implementation Marantz

+ (void)routeAudio:(enum InputDevice)input {
    // Update matrix for all (doesnt hurt anything)
    [[CommandCenter singleton] setMatrixInput:input toOutput:OutputDeviceAudioZone1];
    // Swith marantz to specific marantz input based on the input device
    [[CommandCenter singleton] sendQueableIRCommand:[Marantz irCommandForInput:input] toIRDevice:IRDeviceMarantz];
}

+ (enum IRCommand)irCommandForInput:(enum InputDevice)input {
    switch (input) {
        case InputDeviceTimeWarnerDvr1:
            return IRCommandMarantzInputTv;
        case InputDeviceTimeWarnerDvr2:
            return IRCommandMarantzInputVcr;
        case InputDeviceBluRay:
            return IRCommandMarantzInputDvd;
        case InputDeviceAppleTv:
            return IRCommandMarantzInputDss;
        case InputDeviceTimeWarnerBox:
        case InputDeviceMac:
        case InputDeviceWii:
        case InputDeviceNone:
        default:
            return IRCommandMarantzInputTape;
            break;
    }
}

+ (NSString *)stringForIRCommand:(enum IRCommand)command {
    switch (command) {
        case IRCommandEmpty: // actual command taken from DirecTV
            return @"38000,1,1,228,46,46,45,23,22,23,22,23,22,46,45,46,45,46,45,23,22,23,760";
        case IRCommandPowerOn:
            return @"36000,1,1,32,30,64,62,64,31,32,30,32,30,32,157,32,30,32,63,32,30,64,31,32,30,32,30,32,30,32,30,32,30,32,62,32,720";
        case IRCommandPowerOff:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,158,32,31,32,63,32,31,64,31,32,31,32,31,32,31,32,31,32,63,64,720";
        case IRCommandVolUp:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,31,32,62,64,31,32,31,32,31,32,720";
        case IRCommandVolDown:
            return @"36000,1,1,32,31,32,31,32,31,64,30,32,31,32,31,32,31,32,62,64,30,32,31,32,62,32,720";
        case IRCommandMute:
            return @"36000,1,1,32,32,64,63,64,32,32,32,32,32,32,32,32,32,32,63,32,32,64,63,32,720";
        case IRCommandNightMode:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,192,64,31,32,63,64,64,32,31,64,64,64,63,64,720";
        case IRCommandBassPlus:
            return @"36000,1,1,32,32,32,32,32,32,64,32,32,32,32,32,32,32,32,65,64,64,32,32,64,720";
        case IRCommandBassMinus:
            return @"36000,1,1,32,32,64,63,64,32,32,32,32,32,32,32,32,63,64,63,32,32,32,32,32,720";
        case IRCommandTreblePlus:
            return @"36000,1,1,32,32,64,63,64,32,32,32,32,32,32,32,32,63,32,32,64,32,32,32,32,720";
        case IRCommandTrebleMinus:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,31,32,62,32,31,64,31,32,62,32,720";
        case IRCommandSurroundModeAuto:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,190,64,31,32,63,64,63,32,31,64,63,32,31,64,63,32,720";
        case IRCommandSurroundModeDolby:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,190,64,31,32,63,64,62,32,31,64,62,64,31,32,63,32,720";
        case IRCommandSurroundModeDTS:
            return @"36000,1,1,64,32,32,63,64,32,32,31,32,31,32,159,32,31,32,31,32,31,32,31,32,31,32,31,32,31,32,63,64,32,32,31,32,720";
        case IRCommandSurroundModePureDirect:
            return @"36000,1,1,32,32,32,32,32,32,64,32,32,32,32,32,32,64,64,32,32,32,32,64,64,720";
        case IRCommandSurroundModeMultiChannel:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,189,64,31,32,63,64,63,32,31,32,31,32,31,64,31,32,63,32,720";
        case IRCommandSurroundModeStereo:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,192,64,31,32,63,64,63,64,63,32,31,32,31,32,31,64,720";
        case IRCommandSurroundModeVirtual:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,190,64,31,32,63,64,63,32,31,32,31,64,31,32,63,32,31,32,720";
        case IRCommandSurroundModeCircle:
            return @"36000,1,1,64,62,32,31,64,31,32,31,32,31,32,157,32,31,32,31,32,31,32,31,32,31,32,31,32,31,32,62,64,31,32,62,32,720";
        case IRCommandMarantzInputTv:
            return @"36000,1,1,32,30,64,31,32,30,32,30,32,30,32,30,32,62,32,30,32,30,32,30,32,30,32,30,32,720";
        case IRCommandMarantzInputDvd:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,157,32,31,32,31,32,31,32,31,32,31,32,31,32,31,32,62,64,62,64,720";
        case IRCommandMarantzInputVcr:
            return @"36000,1,1,32,31,32,31,64,31,32,63,64,63,32,31,32,31,32,31,32,31,32,31,32,31,32,720";
        case IRCommandMarantzInputDss:
            return @"36000,1,1,32,32,64,32,32,32,32,64,32,32,64,65,32,32,32,32,32,32,32,32,32,32,32,720";
        case IRCommandMarantzInputCd:
            return @"36000,1,1,32,31,32,31,32,31,64,63,64,31,32,63,32,31,32,31,32,31,32,31,32,31,32,720";
        case IRCommandMarantzInputCdr:
            return @"36000,1,1,32,31,32,31,32,31,32,31,64,62,64,62,32,31,32,31,32,31,32,31,32,31,32,720";
        case IRCommandMarantzInputTape:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,62,64,63,32,31,32,31,32,31,32,31,32,31,32,720";
        default:
            return @"36000,1,1,32,31,32,31,32,31,64,31,32,31,32,31,32,192,64,31,32,63,64,64,32,31,64,64,64,63,64,720";
    }
}

@end
