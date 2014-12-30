//
//  ShellViewController.m
//  JonesRemote
//
//  Created by Chris Jones on 12/24/14.
//  Copyright (c) 2014 Axis. All rights reserved.
//


#import <BFPaperButton/BFPaperButton.h>
#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "FooterViewController.h"
#import "MatrixEnum.h"
#import "CommandCenter.h"
#import "IREnum.h"

static CGFloat zoneBtnWidth = 200.0;
static CGFloat inputBtnWidth = 170.0;
static CGFloat iconBtnWidth = 120.0;

@implementation FooterViewController {
    BFPaperButton *_zone;
    BFPaperButton *_input;
    BFPaperButton *_volumeDown;
    BFPaperButton *_volumeUp;
    BFPaperButton *_mute;
    BFPaperButton *_unMute;

    UIColor *_defaultItemColor;
    UIColor *_activeItemColor;

    enum OutputDevice _outputDevice;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _defaultItemColor = [UIColor paperColorGray800];
    _activeItemColor = [UIColor paperColorGray900];
    self.view.backgroundColor = _defaultItemColor;

    _zone = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _zone.backgroundColor = _activeItemColor;
    _zone.cornerRadius = 0.0;
    _zone.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
    [_zone setTitle:@"Zone" forState:UIControlStateNormal];
    [_zone addTarget:self action:@selector(doZone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zone];


    _input = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _input.backgroundColor = _defaultItemColor;
    _input.cornerRadius = 0.0;
    _input.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
    [_input setTitle:@"Change Input" forState:UIControlStateNormal];
    [_input addTarget:self action:@selector(doInput:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_input];

    _volumeDown = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _volumeDown.backgroundColor = _defaultItemColor;
    _volumeDown.cornerRadius = 0.0;
    _volumeDown.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall / 2;
    [_volumeDown setTitle:@"Vol -" forState:UIControlStateNormal];
    [_volumeDown addTarget:self action:@selector(doVolDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_volumeDown];

    _volumeUp = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _volumeUp.backgroundColor = _defaultItemColor;
    _volumeUp.cornerRadius = 0.0;
    _volumeUp.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall / 2;
    [_volumeUp setTitle:@"Vol +" forState:UIControlStateNormal];
    [_volumeUp addTarget:self action:@selector(doVolUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_volumeUp];

//    _unMute = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
//    _unMute.backgroundColor = _defaultItemColor;
//    _unMute.cornerRadius = 0.0;
//    _unMute.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall / 2;
//    [_unMute setTitle:@"Un-Mute" forState:UIControlStateNormal];
//    [_unMute addTarget:self action:@selector(doUnMute) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_unMute];

    _mute = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) raised:NO];
    _mute.backgroundColor = _defaultItemColor;
    _mute.cornerRadius = 0.0;
    _mute.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall / 2;
    [_mute setTitle:@"Mute" forState:UIControlStateNormal];
    [_mute addTarget:self action:@selector(doMute) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mute];

    [self bindZone:OutputDeviceAudioZone1];
}

- (void)viewDidLayoutSubviews {
    CGFloat xPosition = 0;
    CGFloat btnHeight = self.view.bounds.size.height;

    // Left aligned
    _zone.frame = CGRectMake(xPosition, 0, zoneBtnWidth, btnHeight);
    xPosition += zoneBtnWidth;
    _input.frame = CGRectMake(xPosition, 0, inputBtnWidth, btnHeight);

    // Right aligned
    xPosition = self.view.bounds.size.width;
    _mute.frame = CGRectMake(xPosition - iconBtnWidth, 0, iconBtnWidth, btnHeight);
    xPosition -= iconBtnWidth;
//    _unMute.frame = CGRectMake(xPosition - iconBtnWidth, 0, iconBtnWidth, btnHeight);
//    xPosition -= iconBtnWidth;
    _volumeUp.frame = CGRectMake(xPosition - iconBtnWidth, 0, iconBtnWidth, btnHeight);
    xPosition -= iconBtnWidth;
    _volumeDown.frame = CGRectMake(xPosition - iconBtnWidth, 0, iconBtnWidth, btnHeight);

    [super viewDidLayoutSubviews];
}

- (void)bindZone:(enum OutputDevice)audioZone {
    _outputDevice = audioZone;
    [_zone setTitle:stringForOutputDevice(audioZone) forState:UIControlStateNormal];
}

- (void)bindInput:(enum InputDevice)input {
    [[CommandCenter singleton] setMatrixInput:input toOutput:_outputDevice];
}

- (void)doZone:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    [alert popoverPresentationController].sourceView = sender;
    [alert popoverPresentationController].sourceRect = sender.bounds;

    [alert addAction:[UIAlertAction actionWithTitle:stringForOutputDevice(OutputDeviceAudioZone1) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindZone:OutputDeviceAudioZone1];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForOutputDevice(OutputDeviceAudioZone2) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindZone:OutputDeviceAudioZone2];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForOutputDevice(OutputDeviceAudioZone3) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindZone:OutputDeviceAudioZone3];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)doInput:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    [alert popoverPresentationController].sourceView = sender;
    [alert popoverPresentationController].sourceRect = sender.bounds;

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceTimeWarnerDvr) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceTimeWarnerDvr];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceDirecTvDvr) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceDirecTvDvr];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceDirecTvBox) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceDirecTvBox];
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

    [alert addAction:[UIAlertAction actionWithTitle:stringForInputDevice(InputDeviceWii) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self bindInput:InputDeviceWii];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)doVolUp {
    [[CommandCenter singleton] sendIRCommand:IRCommandVolUp toIRDevice:IRDeviceMarantz];
}

- (void)doVolDown {
    [[CommandCenter singleton] sendIRCommand:IRCommandVolDown toIRDevice:IRDeviceMarantz];
}

- (void)doMute {
    [[CommandCenter singleton] sendQueableIRCommand:IRCommandMute toIRDevice:IRDeviceMarantz];
}

@end