NS_ENUM(int, OutputDevice) {
  OutputDeviceLeftTv,
  OutputDeviceCenterTv,
  OutputDeviceRightTv,
  OutputDeviceAudioZone1,
  OutputDeviceAudioZoneHeadphones,
  OutputDeviceAudioZone3
};

NS_ENUM(int, InputDevice) {
  InputDeviceTimeWarnerDvr,
    InputDeviceTimeWarnerBox1,
    InputDeviceTimeWarnerBox2,
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
    case OutputDeviceAudioZoneHeadphones: {
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
    case InputDeviceTimeWarnerBox1: {
      string = @"2";
      break;
    }
    case InputDeviceTimeWarnerBox2: {
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
      string = @"Main Audio";
      break;
    }
    case OutputDeviceAudioZoneHeadphones: {
      string = @"Headphones";
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
    case InputDeviceTimeWarnerBox1: {
      string = @"DirecTV DVR";
      break;
    }
    case InputDeviceTimeWarnerBox2: {
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