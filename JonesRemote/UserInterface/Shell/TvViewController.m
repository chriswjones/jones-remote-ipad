//
//  ShellViewController.m
//  JonesRemote
//
//  Created by Chris Jones on 12/24/14.
//  Copyright (c) 2014 Axis. All rights reserved.
//


#import <BFPaperButton/BFPaperButton.h>
#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "TvViewController.h"
#import "CommandCenter.h"
#import "TimeWarnerRemoteViewController.h"
#import "BluRayRemoteViewController.h"
#import "DirecTvRemoteViewController.h"

static CGFloat padding = 10.0;

@implementation TvViewController {
    enum OutputDevice _outputDevice;

    BFPaperButton *_input;
    UIView *_remoteContainer;
    UIViewController *_curRemoteVc;

    // Remotes
    TimeWarnerRemoteViewController *_timeWarner;
    DirecTvRemoteViewController *_direcTv;
    BluRayRemoteViewController *_bluray;
    UIViewController *_empty;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor paperColorGray400];

    _input = [[BFPaperButton alloc] initWithFrame:CGRectMake(padding, padding, 200, 60) raised:YES];
    _input.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall / 2;
    [_input.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    _input.backgroundColor = [UIColor paperColorBlue500];
    [_input addTarget:self action:@selector(doInput:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_input];

    _remoteContainer = [[UIView alloc] init];
    _remoteContainer.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_remoteContainer];

    [_input setTitle:stringForInputDevice(InputDeviceNone) forState:UIControlStateNormal];
    _outputDevice = OutputDeviceCenterTv;
}

- (void)viewDidLayoutSubviews {
    _remoteContainer.frame = CGRectMake(0, padding + _input.bounds.size.height + padding, self.view.bounds.size.width, self.view.bounds.size.height - (padding + _input.bounds.size.height + padding));
    [super viewDidLayoutSubviews];
}

- (void)headerViewControllerSelected:(enum OutputDevice)outputDevice {
    [self headerViewControllerSelected:outputDevice action:false];
}

- (void)headerViewControllerSelected:(enum OutputDevice)outputDevice action:(BOOL)action {
    _outputDevice = outputDevice;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *value = [defaults valueForKey:stringForOutputDevice(_outputDevice)];
    [self bindInput:value ? (enum InputDevice) [value integerValue] : InputDeviceNone withAction:action];
}

- (void)doInput:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    [alert popoverPresentationController].sourceView = sender;
    [alert popoverPresentationController].sourceRect = sender.bounds;

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceTimeWarnerDvr) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceTimeWarnerDvr];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceTimeWarnerBox1) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceTimeWarnerBox1];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceTimeWarnerBox2) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceTimeWarnerBox2];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceBluRay) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceBluRay];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceAppleTv) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceAppleTv];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceMac) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceMac];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"TV Off" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceNone];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)bindInput:(enum InputDevice)input {
    [self bindInput:input withAction:YES];
}

- (void)bindInput:(enum InputDevice)input withAction:(BOOL)action {
    [_input setTitle:stringForInputDevice(input) forState:UIControlStateNormal];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(input) forKey:stringForOutputDevice(_outputDevice)];
    [defaults synchronize];

    if (_curRemoteVc) {
        [_curRemoteVc.view removeFromSuperview];
        [_curRemoteVc removeFromParentViewController];
        _curRemoteVc = nil;
    }

    switch (input) {
        case InputDeviceTimeWarnerDvr:
        case InputDeviceTimeWarnerBox1:
        case InputDeviceTimeWarnerBox2: {
            if (!_timeWarner) {
                _timeWarner = [[TimeWarnerRemoteViewController alloc] init];
                _timeWarner.view.backgroundColor = _remoteContainer.backgroundColor;
            }
            [_direcTv bindInput:IRDeviceDirecTvBox];
            _curRemoteVc = _timeWarner;
            break;
        }
        case InputDeviceBluRay: {
            if (!_bluray) {
                _bluray = [[BluRayRemoteViewController alloc] init];
                _bluray.view.backgroundColor = _remoteContainer.backgroundColor;
            }
            _curRemoteVc = _bluray;
            break;
        }
        case InputDeviceAppleTv:
        case InputDeviceWii:
        case InputDeviceMac:
        case InputDeviceNone:
        default: {
            if (!_empty) {
                _empty = [[UIViewController alloc] init];
                _empty.view.backgroundColor = _remoteContainer.backgroundColor;
            }
            _curRemoteVc = _empty;
            break;
        }
    }

    if (_curRemoteVc) {
        _curRemoteVc.view.frame = _remoteContainer.bounds;
        [self addChildViewController:_curRemoteVc];
        [_remoteContainer addSubview:_curRemoteVc.view];

        if (action) {

            [[CommandCenter singleton] setMatrixInput:input toOutput:_outputDevice];

            if (_outputDevice == OutputDeviceCenterTv) {
                // Zone 1 mirrors center tv input
                [[CommandCenter singleton] setMatrixInput:input toOutput:OutputDeviceAudioZone1];
                [[CommandCenter singleton] sendQueableIRCommand:input == InputDeviceNone ? IRCommandPowerOff : IRCommandPowerOn toIRDevice:IRDeviceCenterTv];
            } else if (_outputDevice == OutputDeviceLeftTv) {
                [[CommandCenter singleton] sendQueableIRCommand:input == InputDeviceNone ? IRCommandPowerOff : IRCommandPowerOn toIRDevice:IRDeviceLeftTv];
            } else if (_outputDevice == OutputDeviceRightTv) {
                [[CommandCenter singleton] sendQueableIRCommand:input == InputDeviceNone ? IRCommandPowerOff : IRCommandPowerOn toIRDevice:IRDeviceRightTv];
            }
        }
    }
}

@end