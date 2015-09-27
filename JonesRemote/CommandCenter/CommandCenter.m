#import "CommandCenter.h"
#import "JTLSingleton.h"
#import "IRHardware.h"
#import "TimeWarnerDVR.h"
#import "PanasonicPlasmaTV.h"
#import "BluRay.h"
#import "Marantz.h"

#define MATRIX_SOCKET_IP @"192.168.0.201"
#define MATRIX_SOCKET_PORT 4999

#define RECEIVER_SOCKET_IP @"192.168.0.202"
#define RECEIVER_SOCKET_PORT 4999

#define IR1_SOCKET_IP @"192.168.0.201"
#define IR1_SOCKET_PORT 4998

#define IR2_SOCKET_IP @"192.168.0.202"
#define IR2_SOCKET_PORT 4998

#define CONNECT_SOCKET_TIMEOUT 10
#define IR_COMMAND_TIMEOUT 1
#define MATRIX_COMMAND_TIMEOUT 1

#define MATRIX_COMMAND_DELAY 1
#define IR_COMMAND_DELAY 1

@implementation CommandCenter {
    GCDAsyncSocket *_matrixSocket;
    GCDAsyncSocket *_receiverSocket;
    GCDAsyncSocket *_ir1Socket;
    GCDAsyncSocket *_ir2Socket;
    dispatch_queue_t _commandQueue;
    NSTimer *_emptyTimer;
}

SINGLETON(CommandCenter)

- (id)init {
    self = [super init];
    if (self) {
        _commandQueue = dispatch_queue_create("com.jones.matrixqueue", NULL);

        _matrixSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _matrixSocket.delegate = self;

        _receiverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _receiverSocket.delegate = self;

        _ir1Socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _ir1Socket.delegate = self;

        _ir2Socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _ir2Socket.delegate = self;

        [self connectSockets];
    }
    return self;
}

- (void)connectSockets {
    if (![_matrixSocket isConnected]) {
        NSLog(@"Matrix socket is disconnected, attempting to connect!");
        [_matrixSocket connectToHost:MATRIX_SOCKET_IP onPort:MATRIX_SOCKET_PORT withTimeout:CONNECT_SOCKET_TIMEOUT error:nil];
    }

    if (![_receiverSocket isConnected]) {
        NSLog(@"Receiver socket is disconnected, attempting to connect!");
        [_receiverSocket connectToHost:RECEIVER_SOCKET_IP onPort:RECEIVER_SOCKET_PORT error:nil];
    }

    if (![_ir1Socket isConnected]) {
        NSLog(@"IR1 socket is disconnected, attempting to connect!");
        [_ir1Socket connectToHost:IR1_SOCKET_IP onPort:IR1_SOCKET_PORT error:nil];
    }

    if (![_ir2Socket isConnected]) {
        NSLog(@"IR2 socket is disconnected, attempting to connect!");
        [_ir2Socket connectToHost:IR2_SOCKET_IP onPort:IR2_SOCKET_PORT error:nil];
    }

    if (_emptyTimer) {
        [_emptyTimer invalidate];
        _emptyTimer = nil;
    }
    _emptyTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(sendEmpty) userInfo:nil repeats:NO];
}

- (void)sendEmpty {
    // send an empty to command to each of the IR hubs (choosing one device from each)
    NSLog(@"sending empty!");
    [self sendIRCommand:IRCommandEmpty toIRDevice:IRDeviceTimeWarnerDvr1];
    [self sendIRCommand:IRCommandEmpty toIRDevice:IRDeviceBluRay];
}

- (void)disconnectSockets {
    if ([_matrixSocket isConnected]) {
        [_matrixSocket disconnect];
    }

    if ([_receiverSocket isConnected]) {
        [_receiverSocket disconnect];
    }

    if ([_ir1Socket isConnected]) {
        [_ir1Socket disconnect];
    }

    if ([_ir2Socket isConnected]) {
        [_ir2Socket disconnect];
    }
}

#pragma mark - Socket Delegates

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    if (sock == _matrixSocket) {
        NSLog(@"Matrix Socket Connected");
    } else if (sock == _ir1Socket) {
        NSLog(@"IR 1 Socket Connected");
    } else if (sock == _ir2Socket) {
        NSLog(@"IR 2 Socket Connected");
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (sock == _matrixSocket) {
        NSLog(@"Matrix Socket did read data");
    } else if (sock == _ir1Socket) {
        NSLog(@"IR 1 Socket did read data");
    } else if (sock == _ir2Socket) {
        NSLog(@"IR 2 Socket did read data");
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if (sock == _matrixSocket) {
        NSLog(@"Matrix Socket did write data");
    } else if (sock == _ir1Socket) {
        NSLog(@"IR 1 Socket did write data");
    } else if (sock == _ir2Socket) {
        NSLog(@"IR 2 Socket did write data");
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    if (sock == _matrixSocket) {
        NSLog(@"Matrix Socket Disconnected");
    } else if (sock == _ir1Socket) {
        NSLog(@"IR 1 Socket Disconnected");
    } else if (sock == _ir2Socket) {
        NSLog(@"IR 2 Socket Disconnected");
    }
    [self connectSockets];
}

#pragma mark - Matrix Commands

- (void)powerMatrixOn {
    dispatch_async(_commandQueue, ^{
        [_matrixSocket writeData:[stringForMatrixCommand(MatrixCommandPowerOn) dataUsingEncoding:NSUTF8StringEncoding] withTimeout:MATRIX_COMMAND_TIMEOUT tag:0];
        sleep(MATRIX_COMMAND_DELAY);
    });
}

- (void)powerMatrixOff {
    dispatch_async(_commandQueue, ^{
        [_matrixSocket writeData:[stringForMatrixCommand(MatrixCommandPowerOff) dataUsingEncoding:NSUTF8StringEncoding] withTimeout:MATRIX_COMMAND_TIMEOUT tag:0];
        sleep(MATRIX_COMMAND_DELAY);
    });
}

- (void)setMatrixInput:(enum InputDevice)inputDevice toOutput:(enum OutputDevice)outputDevice {
    dispatch_async(_commandQueue, ^{
        [_matrixSocket writeData:matrixCommandDataForOutputDevice(outputDevice) withTimeout:MATRIX_COMMAND_TIMEOUT tag:0];
        [_matrixSocket writeData:matrixCommandDataForInputDevice(inputDevice) withTimeout:MATRIX_COMMAND_TIMEOUT tag:0];
        sleep(MATRIX_COMMAND_DELAY);
    });
}

#pragma mark - IR Commands

- (void)sendIRCommand:(enum IRCommand)irCommand toIRDevice:(enum IRDevice)irDevice {
    dispatch_async(_commandQueue, ^{
        [self processIrCommand:irCommand irDevice:irDevice];
    });
}

- (void)sendQueableIRCommand:(enum IRCommand)irCommand toIRDevice:(enum IRDevice)irDevice {
    dispatch_async(_commandQueue, ^{
        sleep(IR_COMMAND_DELAY);
        [self processIrCommand:irCommand irDevice:irDevice];
    });
}

- (void)processIrCommand:(enum IRCommand)irCommand irDevice:(enum IRDevice)irDevice {
    NSString * locationString = [CommandCenter locationStringForIRDevice:irDevice];
    Class <IRHardware> hardwareClass = [CommandCenter hardwareClassForIRDevice:irDevice];
    NSString * commandString = [hardwareClass stringForIRCommand:irCommand];
    NSString * finalString = [NSString stringWithFormat:@"sendir,%@,999,%@\r", locationString, commandString];

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Final IR String:%@", finalString);
    });

    GCDAsyncSocket *socket = [self socketForIRDevice:irDevice];
    [socket writeData:[finalString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:IR_COMMAND_TIMEOUT tag:0];
}

+ (Class <IRHardware>)hardwareClassForIRDevice:(enum IRDevice)irDevice {
    Class <IRHardware> class = nil;
    switch (irDevice) {
        case IRDeviceTimeWarnerDvr1:
            class = [TimeWarnerDVR class];
            break;
        case IRDeviceTimeWarnerDvr2:
            class = [TimeWarnerDVR class];
            break;
        case IRDeviceTimeWarnerBox:
            class = [TimeWarnerDVR class];
            break;
        case IRDeviceLeftTv:
        case IRDeviceCenterTv:
        case IRDeviceRightTv:
            class = [PanasonicPlasmaTV class];
            break;
        case IRDeviceBluRay:
            class = [BluRay class];
            break;
        case IRDeviceMarantz:
            class = [Marantz class];
            break;
        default:
            NSLog(@"Error, unrecognized ir device: %d", irDevice);
            break;
    }

    return class;
}

+ (NSString *)locationStringForIRDevice:(enum IRDevice)irDevice {
    switch (irDevice) {
        case IRDeviceTimeWarnerDvr1:
            return @"4:1";
        case IRDeviceTimeWarnerDvr2:
            return @"4:2";
        case IRDeviceTimeWarnerBox:
            return @"4:3";
        case IRDeviceLeftTv:
            return @"5:1";
        case IRDeviceCenterTv:
            return @"5:2";
        case IRDeviceRightTv:
            return @"5:3";
        case IRDeviceBluRay:
            return @"4:1";
        case IRDeviceMarantz:
            return @"4:2";
        default:
            NSLog(@"Error, unrecognized ir device: %d", irDevice);
            return @"";
    }
}

- (GCDAsyncSocket *)socketForIRDevice:(enum IRDevice)device {
    switch (device) {
        case IRDeviceLeftTv:
        case IRDeviceRightTv:
        case IRDeviceCenterTv:
        case IRDeviceTimeWarnerDvr1:
        case IRDeviceTimeWarnerDvr2:
        case IRDeviceTimeWarnerBox:
            return _ir1Socket;
        case IRDeviceBluRay:
        case IRDeviceMarantz:
            return _ir2Socket;
        default:
            NSLog(@"Error, unrecognized ir device: %d", device);
            return nil;
    }
}

@end