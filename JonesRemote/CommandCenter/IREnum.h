NS_ENUM(int, IRCommand) {
    IRCommandNoCommand,
    IRCommand0, IRCommand1, IRCommand2, IRCommand3, IRCommand4, IRCommand5, IRCommand6, IRCommand7, IRCommand8, IRCommand9,
    IRCommandRewind, IRCommandFastForward, IRCommandPlay, IRCommandPause, IRCommandStop, IRCommandRecord, IRCommandLive, IRCommandSkipForward, IRCommandSkipBack,
    IRCommandGuide, IRCommandRecordedShows, IRCommandPageUp, IRCommandPageDown, IRCommandUp, IRCommandDown, IRCommandLeft, IRCommandRight, IRCommandSelect, IRCommandExit, IRCommandStar, IRCommandPound, IRCommandD, IRCommandFAV, IRCommandLast, IRCommandHelp, IRCommandSports, IRCommandCircleArrow,
    IRCommandA, IRCommandB, IRCommandC, IRCommandInfo, IRCommandOnDemand, IRCommandSettings,
    IRCommandPowerOn, IRCommandPowerOff, IRCommandPowerOnOff, IRCommandVolUp, IRCommandVolDown, IRCommandMute,
    IRCommandPlusDay, IRCommandMinusDay, IRCommandPlusChannel, IRCommandMinusChannel,
    IRCommandStatus, IRCommandBack,
    IRCommandMuteOn, IRCommandMuteOff,
    IRCommandMenu,
    IRCommandZoom, IRCommandMarker, IRCommandSearch, IRCommandHome, IRCommandDiskMenu, IRCommandTitle, IRCommandOpenClose, IRCommandEnter, IRCommandClear, IRCommandRepeat, IRCommandRed, IRCommandGreen, IRCommandYellow, IRCommandBlue,
    IRCommandNightMode, IRCommandPreviousChannel, IRCommandBackThirtySec, IRCommandForwardThirtySec, IRCommandDash, IRCommandRedDot
};

static inline NSString *stringForIRCommand(enum IRCommand irCommand) {
    switch (irCommand) {
        case IRCommandZoom:
            return @"Zoom";
        case IRCommandMarker:
            return @"Marker";
        case IRCommandSearch:
            return @"Search";
        case IRCommandOnDemand:
            return @"On Demand";
        case IRCommandSettings:
            return @"Settings";
        case IRCommandNoCommand:
            return @"";
        case IRCommand0:
            return @"0";
        case IRCommand1:
            return @"1";
        case IRCommand2:
            return @"2";
        case IRCommand3:
            return @"3";
        case IRCommand4:
            return @"4";
        case IRCommand5:
            return @"5";
        case IRCommand6:
            return @"6";
        case IRCommand7:
            return @"7";
        case IRCommand8:
            return @"8";
        case IRCommand9:
            return @"9";
        case IRCommandRewind:
            return @"Rewind";
        case IRCommandFastForward:
            return @"Fast Forward";
        case IRCommandPlay:
            return @"Play";
        case IRCommandPause:
            return @"Pause";
        case IRCommandStop:
            return @"Stop";
        case IRCommandRecord:
            return @"Record";
        case IRCommandLive:
            return @"Live";
        case IRCommandGuide:
            return @"Guide";
        case IRCommandRecordedShows:
            return @"Recorded Shows";
        case IRCommandPageUp:
            return @"Page Up";
        case IRCommandPageDown:
            return @"Page Down";
        case IRCommandUp:
            return @"Up";
        case IRCommandDown:
            return @"Down";
        case IRCommandLeft:
            return @"Left";
        case IRCommandRight:
            return @"Right";
        case IRCommandSelect:
            return @"Select";
        case IRCommandExit:
            return @"Exit";
        case IRCommandA:
            return @"A";
        case IRCommandB:
            return @"B";
        case IRCommandC:
            return @"C";
        case IRCommandInfo:
            return @"Info";
        case IRCommandPowerOn:
            return @"Power On";
        case IRCommandPowerOff:
            return @"Power Off";
        case IRCommandPowerOnOff:
            return @"Power";
        case IRCommandVolUp:
            return @"Vol +";
        case IRCommandVolDown:
            return @"Vol -";
        case IRCommandMute:
            return @"Mute";
        case IRCommandPlusDay:
            return @"Day +";
        case IRCommandMinusDay:
            return @"Day -";
        case IRCommandPlusChannel:
            return @"Channel +";
        case IRCommandMinusChannel:
            return @"Channel -";
        case IRCommandStatus:
            return @"Status";
        case IRCommandBack:
            return @"Back";
        case IRCommandMuteOn:
            return @"Mute On";
        case IRCommandMuteOff:
            return @"Mute Off";
        case IRCommandMenu:
            return @"Menu";
        case IRCommandSkipForward:
            return @"Skip Forward";
        case IRCommandSkipBack:
            return @"Skip Back";
        case IRCommandStar:
            return @"*";
        case IRCommandPound:
            return @"+";
        case IRCommandD:
            return @"D";
        case IRCommandFAV:
            return @"FAV";
        case IRCommandLast:
            return @"Last";
        case IRCommandHelp:
            return @"Help";
        case IRCommandSports:
            return @"Sports";
        case IRCommandCircleArrow:
            return @"Circle Arrow";
        case IRCommandHome:
            return @"Home";
        case IRCommandDiskMenu:
            return @"Disk Menu";
        case IRCommandTitle:
            return @"Title";
        case IRCommandOpenClose:
            return @"Open/Close";
        case IRCommandEnter:
            return @"Enter";
        case IRCommandClear:
            return @"Clear";
        case IRCommandRepeat:
            return @"Repeat";
        case IRCommandRed:
            return @"Red";
        case IRCommandGreen:
            return @"Green";
        case IRCommandYellow:
            return @"Yellow";
        case IRCommandBlue:
            return @"Blue";
        case IRCommandNightMode:
            return @"Night Mode";
        case IRCommandPreviousChannel:
            return @"Previous Channe;";
        case IRCommandBackThirtySec:
            return @"Back Thirty Sec.";
        case IRCommandForwardThirtySec:
            return @"Forward 30 sec.";
        case IRCommandDash:
            return @"Dash (-)";
        case IRCommandRedDot:
            return @"Red Dot";
        default:
            return @"";
    }
    return @"";
}

NS_ENUM(int, IRDevice) {
    IRDeviceTimeWarnerDvr,
    IRDeviceDirecTvDvr,
    IRDeviceDirecTvBox,
    IRDeviceBluRay,
    IRDeviceMac,
    IRDeviceAppleTv,
    IRDeviceWii,
    IRDeviceLeftTv,
    IRDeviceCenterTv,
    IRDeviceRightTv,
    IRDeviceMarantz,
    IRDeviceNone
};

static inline NSString *stringForIRDevice(enum IRDevice irDevice) {
    switch (irDevice) {
        case IRDeviceTimeWarnerDvr:
            return @"TW Cable";
        case IRDeviceDirecTvDvr:
            return @"DirecTV DVR";
        case IRDeviceDirecTvBox:
            return @"DirecTV Box";
        case IRDeviceBluRay:
            return @"Blu-Ray";
        case IRDeviceMac:
            return @"Mac Mini";
        case IRDeviceAppleTv:
            return @"Apple TV";
        case IRDeviceWii:
            return @"Wii";
        case IRDeviceLeftTv:
            return @"Left TV";
        case IRDeviceCenterTv:
            return @"Center TV";
        case IRDeviceRightTv:
            return @"Right TV";
        default:
            NSLog(@"Error, unrecognized ir device: %d", irDevice);
            return @"";
    }
}