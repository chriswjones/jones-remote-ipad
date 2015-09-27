//
//  ShellViewController.m
//  JonesRemote
//
//  Created by Chris Jones on 12/24/14.
//  Copyright (c) 2014 Axis. All rights reserved.
//


#import "HeaderViewController.h"
#import "BFPaperButton.h"
#import "UIColor+BFPaperColors.h"
#import "MBProgressHUD.h"
#import "Scene.h"
#import "CommandCenter.h"

static CGFloat settingsBtnWidth = 150.0;

@implementation HeaderViewController {
    BFPaperButton *_left;
    BFPaperButton *_center;
    BFPaperButton *_right;
    BFPaperButton *_power;

    UIColor *_defaultItemColor;
    UIColor *_activeItemColor;

    NSArray *_sceneData;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _sceneData = @[
        [Scene sceneWithName:@"ESPN"
                 leftTvInput:InputDeviceTimeWarnerDvr
                    leftTvIr:IRDeviceTimeWarnerDvr
               leftTvChannel:@"0301"
               centerTvInput:InputDeviceTimeWarnerBox1
                  centerTvIr:IRDeviceDirecTvDvr
             centerTvChannel:@"0206"
                rightTvInput:InputDeviceTimeWarnerBox2
                   rightTvIr:IRDeviceDirecTvBox
              rightTvChannel:@"0208"],
        [Scene sceneWithName:@"NFL"
                 leftTvInput:InputDeviceTimeWarnerDvr
                    leftTvIr:IRDeviceTimeWarnerDvr
               leftTvChannel:@"008"
               centerTvInput:InputDeviceTimeWarnerBox1
                  centerTvIr:IRDeviceDirecTvDvr
             centerTvChannel:@"0069"
                rightTvInput:InputDeviceTimeWarnerBox2
                   rightTvIr:IRDeviceDirecTvBox
              rightTvChannel:@"0702"],
        [Scene sceneWithName:@"NCAA"
                 leftTvInput:InputDeviceTimeWarnerDvr
                    leftTvIr:IRDeviceTimeWarnerDvr
               leftTvChannel:@"0375"
               centerTvInput:InputDeviceTimeWarnerBox1
                  centerTvIr:IRDeviceDirecTvDvr
             centerTvChannel:@"0206"
                rightTvInput:InputDeviceTimeWarnerBox2
                   rightTvIr:IRDeviceDirecTvBox
              rightTvChannel:@"0008"],
        [Scene sceneWithName:@"News 1"
                 leftTvInput:InputDeviceTimeWarnerDvr
                    leftTvIr:IRDeviceTimeWarnerDvr
               leftTvChannel:@"0046"
               centerTvInput:InputDeviceTimeWarnerBox1
                  centerTvIr:IRDeviceDirecTvDvr
             centerTvChannel:@"0204"
                rightTvInput:InputDeviceTimeWarnerBox2
                   rightTvIr:IRDeviceDirecTvBox
              rightTvChannel:@"0206"],
        [Scene sceneWithName:@"News 2"
                 leftTvInput:InputDeviceTimeWarnerDvr
                    leftTvIr:IRDeviceTimeWarnerDvr
               leftTvChannel:@"0050"
               centerTvInput:InputDeviceTimeWarnerBox1
                  centerTvIr:IRDeviceDirecTvDvr
             centerTvChannel:@"0360"
                rightTvInput:InputDeviceTimeWarnerBox2
                   rightTvIr:IRDeviceDirecTvBox
              rightTvChannel:@"0202"],
        [Scene sceneWithName:@"Business"
                 leftTvInput:InputDeviceTimeWarnerDvr
                    leftTvIr:IRDeviceTimeWarnerDvr
               leftTvChannel:@"0205"
               centerTvInput:InputDeviceTimeWarnerBox1
                  centerTvIr:IRDeviceDirecTvDvr
             centerTvChannel:@"0359"
                rightTvInput:InputDeviceTimeWarnerBox2
                   rightTvIr:IRDeviceDirecTvBox
              rightTvChannel:@"0353"]
    ];

    _defaultItemColor = [UIColor paperColorGray800];
    _activeItemColor = [UIColor paperColorGray900];

    self.view.backgroundColor = _activeItemColor;

    _left = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _left.backgroundColor = _defaultItemColor;
    _left.cornerRadius = 0.0;
    _left.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
    [_left setTitle:@"Left TV" forState:UIControlStateNormal];
    [_left addTarget:self action:@selector(doTouch:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_left];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doSwipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_left addGestureRecognizer:swipeRight];

    _center = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _center.backgroundColor = _activeItemColor;
    _center.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
    _center.cornerRadius = 0.0;
    [_center setTitle:@"Center TV" forState:UIControlStateNormal];
    [_center addTarget:self action:@selector(doTouch:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_center];

    UISwipeGestureRecognizer *centerSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doCenterSwipeRight)];
    centerSwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_center addGestureRecognizer:centerSwipeRight];

    UISwipeGestureRecognizer *centerSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doCenterSwipeLeft)];
    centerSwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_center addGestureRecognizer:centerSwipeLeft];

    _right = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _right.backgroundColor = _defaultItemColor;
    _right.cornerRadius = 0.0;
    _right.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
    [_right setTitle:@"Right TV" forState:UIControlStateNormal];
    [_right addTarget:self action:@selector(doTouch:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_right];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doSwipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_right addGestureRecognizer:swipeLeft];

    _power = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _power.backgroundColor = _defaultItemColor;
    _power.cornerRadius = 0.0;
    _power.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall / 2;
    [_power setTitle:@"Power" forState:UIControlStateNormal];
    [_power addTarget:self action:@selector(doPower:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_power];
}

- (void)viewDidLayoutSubviews {
    CGFloat statusBarHeight = 20.0;
    CGFloat btnWidth = (self.view.bounds.size.width - settingsBtnWidth) / 3;
    CGFloat btnHeight = self.view.bounds.size.height - 20.0;
    CGFloat xPosition = 0;

    _left.frame = CGRectMake(xPosition, statusBarHeight, btnWidth, btnHeight);
    xPosition += btnWidth;

    _center.frame = CGRectMake(xPosition, statusBarHeight, btnWidth, btnHeight);
    xPosition += btnWidth;

    _right.frame = CGRectMake(xPosition, statusBarHeight, btnWidth, btnHeight);
    xPosition += btnWidth;

    _power.frame = CGRectMake(xPosition, statusBarHeight, settingsBtnWidth, btnHeight);

    [super viewDidLayoutSubviews];
}

- (void)doTouch:(BFPaperButton *)sender {
    // reset colors
    _left.backgroundColor = _defaultItemColor;
    _center.backgroundColor = _defaultItemColor;
    _right.backgroundColor = _defaultItemColor;

    // darken sender
    sender.backgroundColor = _activeItemColor;

    // send delegate message
    if (sender == _left) {
        [self.headerDelegate headerViewControllerSelected:OutputDeviceLeftTv];
    } else if (sender == _center) {
        [self.headerDelegate headerViewControllerSelected:OutputDeviceCenterTv];
    } else if (sender == _right) {
        [self.headerDelegate headerViewControllerSelected:OutputDeviceRightTv];
    }
}

- (void)doPower:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    [alert popoverPresentationController].sourceView = sender;
    [alert popoverPresentationController].sourceRect = sender.bounds;

    [alert addAction:[UIAlertAction actionWithTitle:@"Power System On" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[CommandCenter singleton] powerMatrixOn];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceMarantz];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceLeftTv];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceCenterTv];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceRightTv];

        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOn toIRDevice:IRDeviceDirecTvDvr];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOn toIRDevice:IRDeviceDirecTvBox];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOnOff toIRDevice:IRDeviceTimeWarnerDvr];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOnOff toIRDevice:IRDeviceBluRay];

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
        hud.labelText = @"Powering On";
        [NSTimer scheduledTimerWithTimeInterval:30.0
                                         target:self
                                       selector:@selector(finishPowerOn)
                                       userInfo:nil
                                        repeats:NO];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Power Music On" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[CommandCenter singleton] powerMatrixOn];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceMarantz];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceLeftTv];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceCenterTv];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceRightTv];

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
        hud.labelText = @"Powering On";
        [NSTimer scheduledTimerWithTimeInterval:30.0
                                         target:self
                                       selector:@selector(finishPowerMusicOn)
                                       userInfo:nil
                                        repeats:NO];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Power System Off" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceLeftTv)];
        [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
        [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceRightTv)];
        [defaults synchronize];

        [self.headerDelegate headerViewControllerSelected:OutputDeviceCenterTv action:YES];
        [[CommandCenter singleton] powerMatrixOff];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceMarantz];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceLeftTv];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceCenterTv];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceRightTv];

        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceDirecTvDvr];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOff toIRDevice:IRDeviceDirecTvBox];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOnOff toIRDevice:IRDeviceTimeWarnerDvr];
        [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOnOff toIRDevice:IRDeviceBluRay];

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
        hud.labelText = @"Powering Off";
        [NSTimer scheduledTimerWithTimeInterval:15.0
                                         target:self
                                       selector:@selector(hideHUD)
                                       userInfo:nil
                                        repeats:NO];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Re-Connect" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[CommandCenter singleton] connectSockets];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)finishPowerOn {
    // set DVR channel to default channel
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand0 toIRDevice:IRDeviceDirecTvDvr];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand0 toIRDevice:IRDeviceDirecTvDvr];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand1 toIRDevice:IRDeviceDirecTvDvr];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand5 toIRDevice:IRDeviceDirecTvDvr];

    // Set other boxes to default channels
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand0 toIRDevice:IRDeviceDirecTvBox];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand0 toIRDevice:IRDeviceDirecTvBox];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand1 toIRDevice:IRDeviceDirecTvBox];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand5 toIRDevice:IRDeviceDirecTvBox];

    [[CommandCenter singleton] sendQueableIRCommand:IRCommand0 toIRDevice:IRDeviceTimeWarnerDvr];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand0 toIRDevice:IRDeviceTimeWarnerDvr];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand1 toIRDevice:IRDeviceTimeWarnerDvr];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommand1 toIRDevice:IRDeviceTimeWarnerDvr];

    // set center TV to dvr input
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceLeftTv)];
    [defaults setObject:@(InputDeviceTimeWarnerBox1) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
    [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceRightTv)];
    [defaults synchronize];

    // Audio On
    [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOn toIRDevice:IRDeviceMarantz];

    // this will set the remote, input (and audio) and power the TV On
    [self.headerDelegate headerViewControllerSelected:OutputDeviceCenterTv action:YES];
    [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];


}

- (void)finishPowerMusicOn {

    // set center TV to dvr input
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceLeftTv)];
    [defaults setObject:@(InputDeviceAppleTv) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
    [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceRightTv)];
    [defaults synchronize];

    // Audio On
    [[CommandCenter singleton] setMatrixInput:InputDeviceAppleTv toOutput:OutputDeviceAudioZone1];
    [[CommandCenter singleton] sendQueableIRCommand:IRCommandPowerOn toIRDevice:IRDeviceMarantz];
    [self.headerDelegate headerViewControllerSelected:OutputDeviceCenterTv];
    [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
}

- (void)doCenterSwipeLeft {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    enum InputDevice curLeftInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceLeftTv)] integerValue];
    enum InputDevice curCenterInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceCenterTv)] integerValue];
    [defaults setObject:@(curLeftInput) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
    [defaults setObject:@(curCenterInput) forKey:stringForOutputDevice(OutputDeviceLeftTv)];
    [defaults synchronize];

    [[CommandCenter singleton] setMatrixInput:curLeftInput toOutput:OutputDeviceAudioZone1];
    [[CommandCenter singleton] setMatrixInput:curLeftInput toOutput:OutputDeviceCenterTv];
    [[CommandCenter singleton] setMatrixInput:curCenterInput toOutput:OutputDeviceLeftTv];

    // refresh the ui
    [self.headerDelegate headerViewControllerSelected:OutputDeviceCenterTv];
}

- (void)doCenterSwipeRight {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    enum InputDevice curRightInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceRightTv)] integerValue];
    enum InputDevice curCenterInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceCenterTv)] integerValue];
    [defaults setObject:@(curRightInput) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
    [defaults setObject:@(curCenterInput) forKey:stringForOutputDevice(OutputDeviceRightTv)];
    [defaults synchronize];

    [[CommandCenter singleton] setMatrixInput:curRightInput toOutput:OutputDeviceAudioZone1];
    [[CommandCenter singleton] setMatrixInput:curRightInput toOutput:OutputDeviceCenterTv];
    [[CommandCenter singleton] setMatrixInput:curCenterInput toOutput:OutputDeviceRightTv];

    // refresh the ui
    [self.headerDelegate headerViewControllerSelected:OutputDeviceCenterTv];
}

- (void)doSwipeRight {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    enum InputDevice curLeftInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceLeftTv)] integerValue];
    enum InputDevice curCenterInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceCenterTv)] integerValue];
    [defaults setObject:@(curLeftInput) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
    [defaults setObject:@(curCenterInput) forKey:stringForOutputDevice(OutputDeviceLeftTv)];
    [defaults synchronize];

    [[CommandCenter singleton] setMatrixInput:curLeftInput toOutput:OutputDeviceAudioZone1];
    [[CommandCenter singleton] setMatrixInput:curLeftInput toOutput:OutputDeviceCenterTv];
    [[CommandCenter singleton] setMatrixInput:curCenterInput toOutput:OutputDeviceLeftTv];

    // refresh the ui
    [self.headerDelegate headerViewControllerSelected:OutputDeviceLeftTv];
}

- (void)doSwipeLeft {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    enum InputDevice curRightInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceRightTv)] integerValue];
    enum InputDevice curCenterInput = (enum InputDevice) [[defaults valueForKey:stringForOutputDevice(OutputDeviceCenterTv)] integerValue];
    [defaults setObject:@(curRightInput) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
    [defaults setObject:@(curCenterInput) forKey:stringForOutputDevice(OutputDeviceRightTv)];
    [defaults synchronize];

    [[CommandCenter singleton] setMatrixInput:curRightInput toOutput:OutputDeviceAudioZone1];
    [[CommandCenter singleton] setMatrixInput:curRightInput toOutput:OutputDeviceCenterTv];
    [[CommandCenter singleton] setMatrixInput:curCenterInput toOutput:OutputDeviceRightTv];

    // refresh the ui
    [self.headerDelegate headerViewControllerSelected:OutputDeviceRightTv];
}

@end