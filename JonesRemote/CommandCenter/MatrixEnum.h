NS_ENUM(int, OutputDevice) {
  OutputDeviceLeftTv,
  OutputDeviceCenterTv,
  OutputDeviceRightTv,
  OutputDeviceAudioZone1,
  OutputDeviceAudioZone2,
  OutputDeviceAudioZone3
};

NS_ENUM(int, InputDevice) {
  InputDeviceTimeWarnerDvr,
  InputDeviceDirecTvDvr,
  InputDeviceDirecTvBox,
  InputDeviceBluRay,
  InputDeviceMac,
  InputDeviceAppleTv,
  InputDeviceWii,
  InputDeviceNone
};

NS_ENUM(int, MatrixCommand) {
  MatrixCommandPowerOn,
  MatrixCommandPowerOff,
  MatrixCommandStatus
};

static inline NSString *stringForMatrixCommand(enum MatrixCommand command) {
  switch (command) {
    case MatrixCommandPowerOn:
      return @"Y";
    case MatrixCommandPowerOff:
      return @"X";
    case MatrixCommandStatus:
      return @"M";
    default:
      NSLog(@"MatrixEnum: Error, unrecognized matrix command: %d", command);
      return @"";
  }
}

static inline NSData *matrixCommandDataForOutputDevice(enum OutputDevice outputDevice) {
  NSString *string = nil;
  switch (outputDevice) {
    case OutputDeviceLeftTv: {
      string = @"a";
      break;
    }
    case OutputDeviceCenterTv: {
      string = @"b";
      break;
    }
    case OutputDeviceRightTv: {
      string = @"c";
      break;
    }
    case OutputDeviceAudioZone1: {
      string = @"d";
      break;
    }
    case OutputDeviceAudioZone2: {
      string = @"e";
      break;
    }
    case OutputDeviceAudioZone3: {
      string = @"f";
      break;
    }
    default: {
      string = @"";
      NSLog(@"MatrixEnum: Error, unrecognized output device: %d", outputDevice);
      break;
    }
  }

  return [string dataUsingEncoding:NSUTF8StringEncoding];
}

static inline NSData *matrixCommandDataForInputDevice(enum InputDevice inputDevice) {
  NSString *string = nil;
  switch (inputDevice) {
    case InputDeviceTimeWarnerDvr: {
      string = @"1";
      break;
    }
    case InputDeviceDirecTvDvr: {
      string = @"2";
      break;
    }
    case InputDeviceDirecTvBox: {
      string = @"3";
      break;
    }
    case InputDeviceBluRay: {
      string = @"4";
      break;
    }
    case InputDeviceAppleTv: {
      string = @"5";
      break;
    }
    case InputDeviceMac: {
      string = @"6";
      break;
    }
    case InputDeviceWii: {
      string = @"7";
      break;
    }
    case InputDeviceNone: {
      string = @"7";
      break;
    }
    default: {
      string = @"";
      NSLog(@"MatrixEnum: Error, unrecognized input device: %d", inputDevice);
      break;
    }
  }

  return [string dataUsingEncoding:NSUTF8StringEncoding];
}

static inline NSString *stringForOutputDevice(enum OutputDevice outputDevice) {
  NSString *string = nil;
  switch (outputDevice) {
    case OutputDeviceLeftTv: {
      string = @"Left TV";
      break;
    }
    case OutputDeviceCenterTv: {
      string = @"Center TV";
      break;
    }
    case OutputDeviceRightTv: {
      string = @"Right TV";
      break;
    }
    case OutputDeviceAudioZone1: {
      string = @"Main Audio Zone";
      break;
    }
    case OutputDeviceAudioZone2: {
      string = @"Audio Zone 2";
      break;
    }
    case OutputDeviceAudioZone3: {
      string = @"Audio Zone 3";
      break;
    }
    default:
      NSLog(@"MatrixEnum: Error, unrecognized output device: %d", outputDevice);
      string = @"";
      break;
  }
  return string;
}

static inline NSString *stringForInputDevice(enum InputDevice inputDevice) {
  NSString *string = nil;
  switch (inputDevice) {
    case InputDeviceTimeWarnerDvr: {
      string = @"TW DVR";
      break;
    }
    case InputDeviceDirecTvDvr: {
      string = @"DirecTV DVR";
      break;
    }
    case InputDeviceDirecTvBox: {
      string = @"DirecTV Box";
      break;
    }
    case InputDeviceBluRay: {
      string = @"BluRay";
      break;
    }
    case InputDeviceMac: {
      string = @"Mac Mini";
      break;
    }
    case InputDeviceAppleTv: {
      string = @"Apple TV";
      break;
    }
    case InputDeviceWii: {
      string = @"Wii";
      break;
    }
    case InputDeviceNone: {
      string = @"None";
      break;
    }
    default:
      NSLog(@"MatrixEnum: Error, unrecognized input device: %d", inputDevice);
      string = @"";
      break;
  }

  return string;
}