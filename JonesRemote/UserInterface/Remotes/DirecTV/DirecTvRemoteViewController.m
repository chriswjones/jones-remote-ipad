//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "DirecTvRemoteViewController.h"
#import "FavoriteChannel.h"
#import "RemotePanel.h"
#import "RemoteButton.h"
#import "CommandCenter.h"

static CGFloat padding = 10.0;

@implementation DirecTvRemoteViewController {
    NSArray *_favorites;
    NSArray *_extras;
    UITableView *_favTableView;
    UITableView *_extrasTableView;
    enum IRDevice _device;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 1024.0, 528.0);
    _device = IRDeviceCenterTv;

    // Favorites
    _favorites = @[
        [FavoriteChannel favoriteWithName:@"ABC" channelNumber:@"0010"],
        [FavoriteChannel favoriteWithName:@"CBS" channelNumber:@"0008"],
        [FavoriteChannel favoriteWithName:@"CBS SN" channelNumber:@"0221"],
        [FavoriteChannel favoriteWithName:@"CNBC" channelNumber:@"0355"],
        [FavoriteChannel favoriteWithName:@"CNN" channelNumber:@"0202"],
        [FavoriteChannel favoriteWithName:@"ESPN" channelNumber:@"0206"],
        [FavoriteChannel favoriteWithName:@"ESPN2" channelNumber:@"0209"],
        [FavoriteChannel favoriteWithName:@"Fox" channelNumber:@"0069"],
        [FavoriteChannel favoriteWithName:@"Fox News" channelNumber:@"0360"],
        [FavoriteChannel favoriteWithName:@"Fox Sports 1" channelNumber:@"0219"],
        [FavoriteChannel favoriteWithName:@"Fox Sports SD" channelNumber:@"0694"],
        [FavoriteChannel favoriteWithName:@"FX" channelNumber:@"0248"],
        [FavoriteChannel favoriteWithName:@"Golf Channel" channelNumber:@"0218"],
        [FavoriteChannel favoriteWithName:@"HLN" channelNumber:@"0204"],
        [FavoriteChannel favoriteWithName:@"MSNBC" channelNumber:@"0356"],
        [FavoriteChannel favoriteWithName:@"NBC" channelNumber:@"0039"],
        [FavoriteChannel favoriteWithName:@"NBC SN" channelNumber:@"0220"],
        [FavoriteChannel favoriteWithName:@"NFL Mix" channelNumber:@"0702"],
        [FavoriteChannel favoriteWithName:@"NFL Network" channelNumber:@"0212"],
        [FavoriteChannel favoriteWithName:@"On Demand Portal" channelNumber:@"1000"],
        [FavoriteChannel favoriteWithName:@"PBS" channelNumber:@"0015"],
        [FavoriteChannel favoriteWithName:@"TBS" channelNumber:@"0247"],
        [FavoriteChannel favoriteWithName:@"Tennis Channel" channelNumber:@"0217"],
        [FavoriteChannel favoriteWithName:@"TNT" channelNumber:@"0245"],
        [FavoriteChannel favoriteWithName:@"Weather Channel" channelNumber:@"0362"],
    ];

    RemotePanel *favPanel = [[RemotePanel alloc] initWithFrame:CGRectMake(padding, 0, 200, self.view.bounds.size.height - padding)];
    [self.view addSubview:favPanel];

    UILabel *favLbl = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 0.0, 0.0)];
    favLbl.textColor = [UIColor paperColorBlue500];
    favLbl.text = @"Favorites";
    [favPanel addSubview:favLbl];
    [favLbl sizeToFit];

    _favTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, padding + favLbl.bounds.size.height, favPanel.bounds.size.width, favPanel.bounds.size.height - (padding + favLbl.bounds.size.height)) style:UITableViewStylePlain];
    _favTableView.backgroundColor = [UIColor paperColorGray100];
    _favTableView.delegate = self;
    _favTableView.dataSource = self;
    [favPanel addSubview:_favTableView];

    // FF, Rewind, Play, etc
    CGFloat btnWidth = 170.f;
    CGFloat playBtnHeight = 130.f;
    CGFloat btnHeight = (self.view.bounds.size.height - playBtnHeight - (padding * 6.f)) / 5.f;
    CGFloat xCoord = self.view.bounds.size.width - padding - btnWidth;
    CGFloat yCoord = 0.f;

    RemoteButton *fastForward = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Fast Forward"];
    [fastForward addTarget:self action:@selector(doFastForward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fastForward];
    yCoord += fastForward.bounds.size.height + padding;

    RemoteButton *forwardThirty = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"+30 Seconds"];
    [forwardThirty addTarget:self action:@selector(doForwardThirty) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forwardThirty];
    yCoord += forwardThirty.bounds.size.height + padding;

    RemoteButton *play = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, playBtnHeight) title:@"Play / Pause"];
    [play addTarget:self action:@selector(doPlay) forControlEvents:UIControlEventTouchUpInside];
    play.backgroundColor = [UIColor paperColorGreen400];
    [self.view addSubview:play];
    yCoord += play.bounds.size.height + padding;

    RemoteButton *backSix = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"-6 Seconds"];
    [backSix addTarget:self action:@selector(doBackSix) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backSix];
    yCoord += backSix.bounds.size.height + padding;

    RemoteButton *rewind = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Rewind"];
    [rewind addTarget:self action:@selector(doRewind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rewind];
    yCoord += rewind.bounds.size.height + padding;

    RemoteButton *record = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Record"];
    [record addTarget:self action:@selector(doRecord) forControlEvents:UIControlEventTouchUpInside];
    record.backgroundColor = [UIColor paperColorRed400];
    [self.view addSubview:record];
    yCoord += record.bounds.size.height + padding;

    // Direction Pad
    btnWidth = 300.f;
    CGFloat vertBtnHeight = 100.f;
    CGFloat vertBtnWidth = (btnWidth - (2.f * padding)) / 3.f;
    btnHeight = (self.view.bounds.size.height - vertBtnHeight - (padding * 8.f)) / 7.f;;
    xCoord -= (padding * 3) + btnWidth;
    yCoord = 0.f;

    RemoteButton *guide = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Guide"];
    [guide addTarget:self action:@selector(doGuide) forControlEvents:UIControlEventTouchUpInside];
    guide.backgroundColor = [UIColor paperColorLightBlue300];
    [self.view addSubview:guide];
    yCoord += guide.bounds.size.height + padding;

    RemoteButton *recordings = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Recordings"];
    [recordings addTarget:self action:@selector(doRecordings) forControlEvents:UIControlEventTouchUpInside];
    recordings.backgroundColor = [UIColor paperColorAmber300];
    [self.view addSubview:recordings];
    yCoord += recordings.bounds.size.height + padding;

    RemoteButton *up = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Up"];
    [up addTarget:self action:@selector(doUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:up];
    yCoord += up.bounds.size.height + padding;

    RemoteButton *left = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, vertBtnWidth * 0.75f, vertBtnHeight) title:@"Left"];
    [left addTarget:self action:@selector(doLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left];

    RemoteButton *select = [RemoteButton buttonWithFrame:CGRectMake(xCoord + padding + (vertBtnWidth * .75f), yCoord, vertBtnWidth * 1.5f, vertBtnHeight) title:@"Select"];
    [select addTarget:self action:@selector(doSelect) forControlEvents:UIControlEventTouchUpInside];
    select.backgroundColor = [UIColor paperColorGreen400];
    [self.view addSubview:select];

    RemoteButton *right = [RemoteButton buttonWithFrame:CGRectMake(xCoord + (2 * padding) + (vertBtnWidth * 2.25f), yCoord, vertBtnWidth * 0.75f, vertBtnHeight) title:@"Right"];
    [right addTarget:self action:@selector(doRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    yCoord += right.bounds.size.height + padding;

    RemoteButton *down = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Down"];
    [down addTarget:self action:@selector(doDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:down];
    yCoord += down.bounds.size.height + padding;

    CGFloat halfWidth = (btnWidth - padding) / 2.f ;

    RemoteButton *pageUp = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, halfWidth, btnHeight) title:@"Page +"];
    [pageUp addTarget:self action:@selector(doPageUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pageUp];

    RemoteButton *pageDown = [RemoteButton buttonWithFrame:CGRectMake(xCoord + halfWidth + padding, yCoord, halfWidth, btnHeight) title:@"Page -"];
    [pageDown addTarget:self action:@selector(doPageDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pageDown];

    yCoord += down.bounds.size.height + padding;

    RemoteButton *info = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, halfWidth, btnHeight) title:@"Info"];
    [info addTarget:self action:@selector(doInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:info];

    RemoteButton *exit = [RemoteButton buttonWithFrame:CGRectMake(xCoord + halfWidth + padding, yCoord, halfWidth, btnHeight) title:@"Exit"];
    [exit addTarget:self action:@selector(doExit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exit];

    // Number Pad
    xCoord -= (padding * 3);
    CGFloat panelWidth = xCoord - padding - _favTableView.bounds.size.width - (padding * 3);
    xCoord = padding + _favTableView.bounds.size.width + (padding * 3);
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

    RemoteButton *lastBtn = [RemoteButton buttonWithFrame:CGRectMake(0, yCoord, numberSize, numberSize) title:@"Last"];
    lastBtn.isRaised = false;
    [lastBtn addTarget:self action:@selector(doLast) forControlEvents:UIControlEventTouchUpInside];
    [numberPanel addSubview:lastBtn];

    RemoteButton *enterBtn = [RemoteButton buttonWithFrame:CGRectMake(numberSize * 2, yCoord, numberSize, numberSize) title:@"Enter"];
    enterBtn.isRaised = false;
    [enterBtn addTarget:self action:@selector(doEnter) forControlEvents:UIControlEventTouchUpInside];
    [numberPanel addSubview:enterBtn];

    // Extras Table
    _extras = @[
        @(IRCommandPlusChannel),
        @(IRCommandMinusChannel),
        @(IRCommandRedDot),
        @(IRCommandDash),
    ];

    yCoord = numberPanel.bounds.size.height + (padding);
    xCoord = padding + _favTableView.bounds.size.width + (padding * 3);
    RemotePanel *extrasPanel = [[RemotePanel alloc] initWithFrame:CGRectMake(xCoord, yCoord, numberPanel.bounds.size.width, self.view.bounds.size.height - yCoord - padding)];
    [self.view addSubview:extrasPanel];

    _extrasTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extrasPanel.bounds.size.width, extrasPanel.bounds.size.height) style:UITableViewStylePlain];
    _extrasTableView.backgroundColor = [UIColor paperColorGray100];
    _extrasTableView.delegate = self;
    _extrasTableView.dataSource = self;
    [extrasPanel addSubview:_extrasTableView];
}

- (void)bindInput:(enum IRDevice)irDevice {
    _device = irDevice;
}

#pragma mark - Favorites Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _favTableView) {
        return _favorites && [_favorites count] > 0 ? [_favorites count] : 1;
    } else {
        return [_extras count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = [UIColor paperColorGray100];

    if (tableView == _favTableView) {
        cell.textLabel.text = _favorites && [_favorites count] > 0 ? ((FavoriteChannel *) _favorites[indexPath.row]).name : @"None";
        cell.selectionStyle = _favorites && [_favorites count] > 0 ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    } else {
        cell.textLabel.text = stringForIRCommand(((enum IRCommand) [_extras[indexPath.row] integerValue]));
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _favTableView) {
        if (!_favorites || [_favorites count] < 1) {
            return;
        }
        FavoriteChannel *fav = _favorites[indexPath.row];
        [self doFavorite:fav.channelNumber];
    } else {
        [[CommandCenter singleton] sendIRCommand:((enum IRCommand) ([_extras[indexPath.row] integerValue])) toIRDevice:_device];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)doFavorite:(NSString *)favorite {
    for (int i = 0; i < [favorite length]; ++i) {
        NSString *text = [NSString stringWithFormat:@"%c", [favorite characterAtIndex:i]];
        if ([text isEqualToString:@"0"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand0 toIRDevice:_device];
        } else if ([text isEqualToString:@"1"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand1 toIRDevice:_device];
        } else if ([text isEqualToString:@"2"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand2 toIRDevice:_device];
        } else if ([text isEqualToString:@"3"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand3 toIRDevice:_device];
        } else if ([text isEqualToString:@"4"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand4 toIRDevice:_device];
        } else if ([text isEqualToString:@"5"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand5 toIRDevice:_device];
        } else if ([text isEqualToString:@"6"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand6 toIRDevice:_device];
        } else if ([text isEqualToString:@"7"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand7 toIRDevice:_device];
        } else if ([text isEqualToString:@"8"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand8 toIRDevice:_device];
        } else if ([text isEqualToString:@"9"]) {
            [[CommandCenter singleton] sendQueableIRCommand:IRCommand9 toIRDevice:_device];
        }
    }
}

- (void)doFastForward {
    [[CommandCenter singleton] sendIRCommand:IRCommandFastForward toIRDevice:_device];
}

- (void)doRewind {
    [[CommandCenter singleton] sendIRCommand:IRCommandRewind toIRDevice:_device];
}

- (void)doPlay {
    [[CommandCenter singleton] sendIRCommand:IRCommandPlay toIRDevice:_device];
}

- (void)doStop {
    [[CommandCenter singleton] sendIRCommand:IRCommandStop toIRDevice:_device];
}

- (void)doLive {
    [[CommandCenter singleton] sendIRCommand:IRCommandLive toIRDevice:_device];
}

- (void)doRecord {
    [[CommandCenter singleton] sendIRCommand:IRCommandRecord toIRDevice:_device];
}

- (void)doGuide {
    [[CommandCenter singleton] sendIRCommand:IRCommandGuide toIRDevice:_device];
}

- (void)doRecordings {
    [[CommandCenter singleton] sendIRCommand:IRCommandRecordedShows toIRDevice:_device];
}

- (void)doBackSix {
    [[CommandCenter singleton] sendIRCommand:IRCommandBackSixSec toIRDevice:_device];
}

- (void)doForwardThirty {
    [[CommandCenter singleton] sendIRCommand:IRCommandForwardThirtySec toIRDevice:_device];
}

- (void)doUp {
    [[CommandCenter singleton] sendIRCommand:IRCommandUp toIRDevice:_device];
}

- (void)doLeft {
    [[CommandCenter singleton] sendIRCommand:IRCommandLeft toIRDevice:_device];
}

- (void)doSelect {
    [[CommandCenter singleton] sendIRCommand:IRCommandSelect toIRDevice:_device];
}

- (void)doRight {
    [[CommandCenter singleton] sendIRCommand:IRCommandRight toIRDevice:_device];
}

- (void)doDown {
    [[CommandCenter singleton] sendIRCommand:IRCommandDown toIRDevice:_device];
}

- (void)doPageUp {
    [[CommandCenter singleton] sendIRCommand:IRCommandPlusChannel toIRDevice:_device];
}

- (void)doPageDown {
    [[CommandCenter singleton] sendIRCommand:IRCommandMinusChannel toIRDevice:_device];
}

- (void)doInfo {
    [[CommandCenter singleton] sendIRCommand:IRCommandInfo toIRDevice:_device];
}

- (void)doLast {
    [[CommandCenter singleton] sendIRCommand:IRCommandLast toIRDevice:_device];
}

- (void)doEnter {
    [[CommandCenter singleton] sendIRCommand:IRCommandEnter toIRDevice:_device];
}

- (void)doExit {
    [[CommandCenter singleton] sendIRCommand:IRCommandExit toIRDevice:_device];
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