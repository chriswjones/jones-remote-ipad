//
//  ShellViewController.m
//  JonesRemote
//
//  Created by Chris Jones on 12/24/14.
//  Copyright (c) 2014 Axis. All rights reserved.
//


#import "ShellViewController.h"
#import "HeaderViewController.h"
#import "FooterViewController.h"
#import "TvViewController.h"

static CGFloat northHeight = 80.0;
static CGFloat southHeight = 80.0;

@implementation ShellViewController {
    UIView *_north;
    UIView *_center;
    UIView *_south;

    HeaderViewController *_headerVc;
    FooterViewController *_footerVc;
    TvViewController *_tvVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceLeftTv)];
    [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceCenterTv)];
    [defaults setObject:@(InputDeviceNone) forKey:stringForOutputDevice(OutputDeviceRightTv)];
    [defaults synchronize];

    // Center
    _center = [[UIView alloc] initWithFrame:CGRectMake(0, northHeight, self.view.bounds.size.width, self.view.bounds.size.height - northHeight - southHeight)];
    _tvVc = [[TvViewController alloc] init];
    [self addChildViewController:_tvVc];
    [_center addSubview:_tvVc.view];
    _tvVc.view.frame = _center.bounds;
    [self.view addSubview:_center];

    // North
    _north = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, northHeight)];
    _headerVc = [[HeaderViewController alloc] init];
    [self addChildViewController:_headerVc];
    [_north addSubview:_headerVc.view];
    _headerVc.view.frame = _north.bounds;

    _north.layer.shadowColor = [UIColor colorWithWhite:0.2f alpha:1.f].CGColor;
    _north.layer.shadowOffset = CGSizeMake(0.f, 1.0f);
    _north.layer.shadowOpacity = 0.7f;
    [self.view addSubview:_north];

    // South
    _south = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - southHeight, self.view.bounds.size.width, southHeight)];
    _footerVc = [[FooterViewController alloc] init];
    [self addChildViewController:_footerVc];
    [_south addSubview:_footerVc.view];
    _footerVc.view.frame = _south.bounds;

    _south.layer.shadowColor = [UIColor colorWithWhite:0.2f alpha:1.f].CGColor;
    _south.layer.shadowOffset = CGSizeMake(0.f, -1.0f);
    _south.layer.shadowOpacity = 0.7f;
    [self.view addSubview:_south];

    // Header Delegate
    _headerVc.headerDelegate = _tvVc;

    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end