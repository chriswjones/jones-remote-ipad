//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "BluRayRemoteViewController.h"
#import "RemotePanel.h"
#import "RemoteButton.h"
#import "CommandCenter.h"

static CGFloat padding = 10.0;

@implementation BluRayRemoteViewController {
    NSArray *_extras;
    UITableView *_extrasTableView;
    enum IRDevice _device;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 1024.0, 528.0);
    _device = IRDeviceBluRay;

    // FF, Rewind, Play, etc
    CGFloat btnWidth = 170.f;
    CGFloat playBtnHeight = 130.f;
    CGFloat btnHeight = (self.view.bounds.size.height - playBtnHeight - (padding * 7.f)) / 6.f;
    CGFloat xCoord = self.view.bounds.size.width - padding - btnWidth;
    CGFloat yCoord = 0.f;

    RemoteButton *fastForward = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Fast Forward"];
    [fastForward addTarget:self action:@selector(doFastForward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fastForward];
    yCoord += fastForward.bounds.size.height + padding;

    RemoteButton *rewind = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Rewind"];
    [rewind addTarget:self action:@selector(doRewind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rewind];
    yCoord += rewind.bounds.size.height + padding;

    RemoteButton *play = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, playBtnHeight) title:@"Play"];
    [play addTarget:self action:@selector(doPlay) forControlEvents:UIControlEventTouchUpInside];
    play.backgroundColor = [UIColor paperColorGreen400];
    [self.view addSubview:play];
    yCoord += play.bounds.size.height + padding;

    RemoteButton *pause = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Pause"];
    [pause addTarget:self action:@selector(doPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pause];
    yCoord += pause.bounds.size.height + padding;

    RemoteButton *stop = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Stop"];
    [stop addTarget:self action:@selector(doStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
    yCoord += stop.bounds.size.height + padding;

    RemoteButton *skipBack = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Skip Back"];
    [skipBack addTarget:self action:@selector(doSkipBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBack];
    yCoord += skipBack.bounds.size.height + padding;

    RemoteButton *skipForward = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Skip Forward"];
    [skipForward addTarget:self action:@selector(doSkipForward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipForward];

    // Direction Pad
    btnWidth = 300.f;
    CGFloat vertBtnHeight = 100.f;
    CGFloat vertBtnWidth = (btnWidth - (2.f * padding)) / 3.f;
    btnHeight = (self.view.bounds.size.height - vertBtnHeight - (padding * 7.f)) / 6.f;;
    xCoord -= (padding * 3) + btnWidth;
    yCoord = 0.f;

    RemoteButton *diskMenu = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Disk Menu"];
    [diskMenu addTarget:self action:@selector(doDiskMenu) forControlEvents:UIControlEventTouchUpInside];
    diskMenu.backgroundColor = [UIColor paperColorLightBlue300];
    [self.view addSubview:diskMenu];
    yCoord += diskMenu.bounds.size.height + padding;

    RemoteButton *openClose = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Open / Close"];
    [openClose addTarget:self action:@selector(doOpenClose) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openClose];
    yCoord += openClose.bounds.size.height + padding;

    RemoteButton *up = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Up"];
    [up addTarget:self action:@selector(doUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:up];
    yCoord += up.bounds.size.height + padding;

    RemoteButton *left = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, vertBtnWidth * 0.75f, vertBtnHeight) title:@"Left"];
    [left addTarget:self action:@selector(doLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left];

    RemoteButton *enter = [RemoteButton buttonWithFrame:CGRectMake(xCoord + padding + (vertBtnWidth * .75f), yCoord, vertBtnWidth * 1.5f, vertBtnHeight) title:@"Enter"];
    [enter addTarget:self action:@selector(doEnter) forControlEvents:UIControlEventTouchUpInside];
    enter.backgroundColor = [UIColor paperColorGreen400];
    [self.view addSubview:enter];

    RemoteButton *right = [RemoteButton buttonWithFrame:CGRectMake(xCoord + (2 * padding) + (vertBtnWidth * 2.25f), yCoord, vertBtnWidth * 0.75f, vertBtnHeight) title:@"Right"];
    [right addTarget:self action:@selector(doRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    yCoord += right.bounds.size.height + padding;

    RemoteButton *down = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Down"];
    [down addTarget:self action:@selector(doDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:down];
    yCoord += down.bounds.size.height + padding;

    RemoteButton *back = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Back"];
    [back addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];

    // Number Pad
    xCoord -= (padding * 3);
    CGFloat panelWidth = xCoord - padding - 200.f - (padding * 3); //todo
    xCoord = padding + 200.f + (padding * 3); //todo
    CGFloat numberSize = panelWidth / 3.f;

    RemotePanel *numberPanel = [[RemotePanel alloc] initWithFrame:CGRectMake(xCoord, 0, panelWidth, numberSize * 4)];
    [self.view addSubview:numberPanel];

    xCoord = 0.f;
    yCoord = 0.f;

    for (int i = 1; i < 11; ++i) {
        if (i == 4 || i == 7) {
            xCoord = 0;
            yCoord += numberSize;
        } else if (i == 10) {
            xCoord = numberSize;
            yCoord += numberSize;
        } else if (i > 1) {
            xCoord += numberSize;
        }

        RemoteButton *numberBtn = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, numberSize, numberSize) title:[NSString stringWithFormat:@"%d", i == 10 ? 0 : i]];
        numberBtn.isRaised = false;
        [numberBtn addTarget:self action:@selector(doNumber:) forControlEvents:UIControlEventTouchUpInside];
        [numberPanel addSubview:numberBtn];
    }

    RemoteButton *titleBtn = [RemoteButton buttonWithFrame:CGRectMake(0, yCoord, numberSize, numberSize) title:@"Title"];
    titleBtn.isRaised = false;
    [titleBtn addTarget:self action:@selector(doTitle) forControlEvents:UIControlEventTouchUpInside];
    [numberPanel addSubview:titleBtn];

    RemoteButton *infoBtn = [RemoteButton buttonWithFrame:CGRectMake(numberSize * 2, yCoord, numberSize, numberSize) title:@"Info"];
    infoBtn.isRaised = false;
    [infoBtn addTarget:self action:@selector(doInfo) forControlEvents:UIControlEventTouchUpInside];
    [numberPanel addSubview:infoBtn];

    // Extras Table
    _extras = @[
        @(IRCommandHome),
        @(IRCommandRepeat),
        @(IRCommandClear),
        @(IRCommandZoom),
        @(IRCommandMarker),
        @(IRCommandSearch),
        @(IRCommandRed),
        @(IRCommandGreen),
        @(IRCommandYellow),
        @(IRCommandBlue),
    ];

    yCoord = numberPanel.bounds.size.height + (padding);
    xCoord = padding + 200.f + (padding * 3); //todo
    RemotePanel *extrasPanel = [[RemotePanel alloc] initWithFrame:CGRectMake(xCoord, yCoord, numberPanel.bounds.size.width, self.view.bounds.size.height - yCoord - padding)];
    [self.view addSubview:extrasPanel];

    _extrasTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extrasPanel.bounds.size.width, extrasPanel.bounds.size.height) style:UITableViewStylePlain];
    _extrasTableView.backgroundColor = [UIColor paperColorGray100];
    _extrasTableView.delegate = self;
    _extrasTableView.dataSource = self;
    [extrasPanel addSubview:_extrasTableView];
}

#pragma mark - Favorites Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_extras count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = [UIColor paperColorGray100];
    cell.textLabel.text = stringForIRCommand(((enum IRCommand) [_extras[indexPath.row] integerValue]));
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[CommandCenter singleton] sendIRCommand:((enum IRCommand) ([_extras[indexPath.row] integerValue])) toIRDevice:_device];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)doFastForward {
    [[CommandCenter singleton] sendIRCommand:IRCommandFastForward toIRDevice:_device];
}

- (void)doRewind {
    [[CommandCenter singleton] sendIRCommand:IRCommandRewind toIRDevice:_device];
}

- (void)doPlay {
    [[CommandCenter singleton] sendIRCommand:IRCommandPlay toIRDevice:_device];
}

- (void)doPause {
    [[CommandCenter singleton] sendIRCommand:IRCommandPause toIRDevice:_device];
}

- (void)doStop {
    [[CommandCenter singleton] sendIRCommand:IRCommandStop toIRDevice:_device];
}

- (void)doSkipForward {
    [[CommandCenter singleton] sendIRCommand:IRCommandSkipForward toIRDevice:_device];
}

- (void)doSkipBack {
    [[CommandCenter singleton] sendIRCommand:IRCommandSkipBack toIRDevice:_device];
}

- (void)doOpenClose {
    [[CommandCenter singleton] sendIRCommand:IRCommandOpenClose toIRDevice:_device];
}

- (void)doDiskMenu {
    [[CommandCenter singleton] sendIRCommand:IRCommandDiskMenu toIRDevice:_device];
}

- (void)doUp {
    [[CommandCenter singleton] sendIRCommand:IRCommandUp toIRDevice:_device];
}

- (void)doLeft {
    [[CommandCenter singleton] sendIRCommand:IRCommandLeft toIRDevice:_device];
}

- (void)doEnter {
    [[CommandCenter singleton] sendIRCommand:IRCommandEnter toIRDevice:_device];
}

- (void)doRight {
    [[CommandCenter singleton] sendIRCommand:IRCommandRight toIRDevice:_device];
}

- (void)doDown {
    [[CommandCenter singleton] sendIRCommand:IRCommandDown toIRDevice:_device];
}

- (void)doTitle {
    [[CommandCenter singleton] sendIRCommand:IRCommandTitle toIRDevice:_device];
}

- (void)doBack {
    [[CommandCenter singleton] sendIRCommand:IRCommandBack toIRDevice:_device];
}

- (void)doInfo {
    [[CommandCenter singleton] sendIRCommand:IRCommandInfo toIRDevice:_device];
}

- (void)doNumber:(RemoteButton *)sender {
    NSString *text = sender.titleLabel.text;
    if ([text isEqualToString:@"0"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand0 toIRDevice:_device];
    } else if ([text isEqualToString:@"1"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand1 toIRDevice:_device];
    } else if ([text isEqualToString:@"2"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand2 toIRDevice:_device];
    } else if ([text isEqualToString:@"3"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand3 toIRDevice:_device];
    } else if ([text isEqualToString:@"4"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand4 toIRDevice:_device];
    } else if ([text isEqualToString:@"5"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand5 toIRDevice:_device];
    } else if ([text isEqualToString:@"6"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand6 toIRDevice:_device];
    } else if ([text isEqualToString:@"7"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand7 toIRDevice:_device];
    } else if ([text isEqualToString:@"8"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand8 toIRDevice:_device];
    } else if ([text isEqualToString:@"9"]) {
        [[CommandCenter singleton] sendIRCommand:IRCommand9 toIRDevice:_device];
    }
}

@end