//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "TimeWarnerRemoteViewController.h"
#import "FavoriteChannel.h"
#import "RemotePanel.h"
#import "RemoteButton.h"
#import "CommandCenter.h"

static CGFloat padding = 10.0;

@implementation TimeWarnerRemoteViewController {
    NSArray *_favorites;
    NSArray *_channels;
    NSArray *_extras;
    UITableView *_favTableView;
    UITableView *_extrasTableView;
    enum IRDevice _device;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 1024.0, 528.0);

    // Favorites
    _favorites = @[
        [FavoriteChannel favoriteWithName:@"ABC" channelNumber:@"0010"],
        [FavoriteChannel favoriteWithName:@"CBS" channelNumber:@"0008"],
        [FavoriteChannel favoriteWithName:@"CBS SN" channelNumber:@"0315"],
        [FavoriteChannel favoriteWithName:@"Cinemax" channelNumber:@"0531"],
        [FavoriteChannel favoriteWithName:@"Cinemax-OD" channelNumber:@"0530"],
        [FavoriteChannel favoriteWithName:@"CNBC" channelNumber:@"0049"],
        [FavoriteChannel favoriteWithName:@"CNN" channelNumber:@"0026"],
        [FavoriteChannel favoriteWithName:@"ESPN" channelNumber:@"0300"],
        [FavoriteChannel favoriteWithName:@"ESPN2" channelNumber:@"0301"],
        [FavoriteChannel favoriteWithName:@"FOX" channelNumber:@"0005"],
        [FavoriteChannel favoriteWithName:@"Fox News" channelNumber:@"0037"],
        [FavoriteChannel favoriteWithName:@"Fox Sports 1" channelNumber:@"0400"],
        [FavoriteChannel favoriteWithName:@"Fox Sports SD" channelNumber:@"0322"],
        [FavoriteChannel favoriteWithName:@"FX" channelNumber:@"0108"],
        [FavoriteChannel favoriteWithName:@"Golf Channel" channelNumber:@"0405"],
        [FavoriteChannel favoriteWithName:@"HBO" channelNumber:@"0511"],
        [FavoriteChannel favoriteWithName:@"HBO on Demand" channelNumber:@"0510"],
        [FavoriteChannel favoriteWithName:@"HLN" channelNumber:@"0028"],
        [FavoriteChannel favoriteWithName:@"Movies on Demand" channelNumber:@"0500"],
        [FavoriteChannel favoriteWithName:@"MSNBC" channelNumber:@"0050"],
        [FavoriteChannel favoriteWithName:@"NBC" channelNumber:@"0007"],
        [FavoriteChannel favoriteWithName:@"NBC SN" channelNumber:@"0314"],
        [FavoriteChannel favoriteWithName:@"NFL Network" channelNumber:@"0310"],
        [FavoriteChannel favoriteWithName:@"NFL Redzone" channelNumber:@"0311"],
        [FavoriteChannel favoriteWithName:@"On Demand Portal" channelNumber:@"0001"],
        [FavoriteChannel favoriteWithName:@"PAC-12 Network" channelNumber:@"0375"],
        [FavoriteChannel favoriteWithName:@"PBS" channelNumber:@"0011"],
        [FavoriteChannel favoriteWithName:@"Showtime" channelNumber:@"0551"],
        [FavoriteChannel favoriteWithName:@"Showtime on Demand" channelNumber:@"0550"],
        [FavoriteChannel favoriteWithName:@"TBS" channelNumber:@"0002"],
        [FavoriteChannel favoriteWithName:@"Tennis Channel" channelNumber:@"0406"],
        [FavoriteChannel favoriteWithName:@"TNT" channelNumber:@"0027"],
        [FavoriteChannel favoriteWithName:@"Weather Channel" channelNumber:@"0046"],
    ];

    _channels = @[
        [FavoriteChannel favoriteWithName:@"4 SDHD" channelNumber:@"00004"],
        [FavoriteChannel favoriteWithName:@"A&E" channelNumber:@"00045"],
        [FavoriteChannel favoriteWithName:@"A&E Network " channelNumber:@"00102"],
        [FavoriteChannel favoriteWithName:@"ABC Family " channelNumber:@"00067"],
        [FavoriteChannel favoriteWithName:@"Al Jazeera America" channelNumber:@"00210"],
        [FavoriteChannel favoriteWithName:@"AMC " channelNumber:@"00043"],
        [FavoriteChannel favoriteWithName:@"America's Auction" channelNumber:@"00491"],
        [FavoriteChannel favoriteWithName:@"American Heroes" channelNumber:@"00140"],
        [FavoriteChannel favoriteWithName:@"Animal Planet " channelNumber:@"00064"],
        [FavoriteChannel favoriteWithName:@"Antenna TV" channelNumber:@"01250"],
        [FavoriteChannel favoriteWithName:@"Aspire" channelNumber:@"00185"],
        [FavoriteChannel favoriteWithName:@"Automotive-OD" channelNumber:@"01028"],
        [FavoriteChannel favoriteWithName:@"Azteca America" channelNumber:@"00015"],
        [FavoriteChannel favoriteWithName:@"BBC America " channelNumber:@"00110"],
        [FavoriteChannel favoriteWithName:@"BBC World News" channelNumber:@"00209"],
        [FavoriteChannel favoriteWithName:@"beIN Sports" channelNumber:@"00417"],
        [FavoriteChannel favoriteWithName:@"beIN Sports En Español" channelNumber:@"00443"],
        [FavoriteChannel favoriteWithName:@"BET " channelNumber:@"00070"],
        [FavoriteChannel favoriteWithName:@"Big Ten Network" channelNumber:@"00382"],
        [FavoriteChannel favoriteWithName:@"Big Ten Network 1" channelNumber:@"00388"],
        [FavoriteChannel favoriteWithName:@"Big Ten Network 2" channelNumber:@"00389"],
        [FavoriteChannel favoriteWithName:@"Bravo " channelNumber:@"00040"],
        [FavoriteChannel favoriteWithName:@"BYU-TV" channelNumber:@"00465"],
        [FavoriteChannel favoriteWithName:@"California Channel " channelNumber:@"00229"],
        [FavoriteChannel favoriteWithName:@"Cartoon Network " channelNumber:@"00062"],
        [FavoriteChannel favoriteWithName:@"CCTV News" channelNumber:@"00221"],
        [FavoriteChannel favoriteWithName:@"Centric" channelNumber:@"00182"],
        [FavoriteChannel favoriteWithName:@"Chiller" channelNumber:@"00127"],
        [FavoriteChannel favoriteWithName:@"CineMAX: 5 StarMAX" channelNumber:@"00537"],
        [FavoriteChannel favoriteWithName:@"CineMAX: ActionMAX " channelNumber:@"00533"],
        [FavoriteChannel favoriteWithName:@"CineMAX: CineMAX-East" channelNumber:@"00539"],
        [FavoriteChannel favoriteWithName:@"CineMAX: Latino" channelNumber:@"00536"],
        [FavoriteChannel favoriteWithName:@"CineMAX: MoreMAX " channelNumber:@"00532"],
        [FavoriteChannel favoriteWithName:@"CineMAX: MovieMax" channelNumber:@"00538"],
        [FavoriteChannel favoriteWithName:@"CineMAX: OuterMAX " channelNumber:@"00535"],
        [FavoriteChannel favoriteWithName:@"CineMAX: ThrillerMAX " channelNumber:@"00534"],
        [FavoriteChannel favoriteWithName:@"City TV" channelNumber:@"00024"],
        [FavoriteChannel favoriteWithName:@"Cloo" channelNumber:@"00139"],
        [FavoriteChannel favoriteWithName:@"CNBC World" channelNumber:@"00208"],
        [FavoriteChannel favoriteWithName:@"College Football TWC" channelNumber:@"00385"],
        [FavoriteChannel favoriteWithName:@"Comedy Central " channelNumber:@"00060"],
        [FavoriteChannel favoriteWithName:@"Country Music TV" channelNumber:@"00066"],
        [FavoriteChannel favoriteWithName:@"COZI TV" channelNumber:@"01245"],
        [FavoriteChannel favoriteWithName:@"CPC" channelNumber:@"00019"],
        [FavoriteChannel favoriteWithName:@"Crime & Investigation" channelNumber:@"00137"],
        [FavoriteChannel favoriteWithName:@"CSPAN" channelNumber:@"00021"],
        [FavoriteChannel favoriteWithName:@"CSPAN2" channelNumber:@"00226"],
        [FavoriteChannel favoriteWithName:@"Cutting Edge-OD" channelNumber:@"01003"],
        [FavoriteChannel favoriteWithName:@"CW" channelNumber:@"00006"],
        [FavoriteChannel favoriteWithName:@"Daystar TV Network" channelNumber:@"00463"],
        [FavoriteChannel favoriteWithName:@"Destination America" channelNumber:@"00135"],
        [FavoriteChannel favoriteWithName:@"Discovery Channel " channelNumber:@"00044"],
        [FavoriteChannel favoriteWithName:@"Discovery Family " channelNumber:@"00266"],
        [FavoriteChannel favoriteWithName:@"Disney Channel " channelNumber:@"00063"],
        [FavoriteChannel favoriteWithName:@"Disney Junior US " channelNumber:@"00254"],
        [FavoriteChannel favoriteWithName:@"Disney XD Pacific" channelNumber:@"00265"],
        [FavoriteChannel favoriteWithName:@"Disney-East" channelNumber:@"00252"],
        [FavoriteChannel favoriteWithName:@"E! Entertainment" channelNumber:@"00048"],
        [FavoriteChannel favoriteWithName:@"El Rey Network" channelNumber:@"00145"],
        [FavoriteChannel favoriteWithName:@"Encore " channelNumber:@"00602"],
        [FavoriteChannel favoriteWithName:@"Encore Action " channelNumber:@"00603"],
        [FavoriteChannel favoriteWithName:@"Encore Action-East" channelNumber:@"00610"],
        [FavoriteChannel favoriteWithName:@"Encore Black " channelNumber:@"00604"],
        [FavoriteChannel favoriteWithName:@"Encore Black-East" channelNumber:@"00611"],
        [FavoriteChannel favoriteWithName:@"Encore Classic " channelNumber:@"00605"],
        [FavoriteChannel favoriteWithName:@"Encore Classic-East" channelNumber:@"00612"],
        [FavoriteChannel favoriteWithName:@"Encore Family " channelNumber:@"00608"],
        [FavoriteChannel favoriteWithName:@"Encore Suspense " channelNumber:@"00606"],
        [FavoriteChannel favoriteWithName:@"Encore Suspense-East" channelNumber:@"00613"],
        [FavoriteChannel favoriteWithName:@"Encore Westerns " channelNumber:@"00607"],
        [FavoriteChannel favoriteWithName:@"Encore Westerns-East" channelNumber:@"00614"],
        [FavoriteChannel favoriteWithName:@"Encore-East" channelNumber:@"00609"],
        [FavoriteChannel favoriteWithName:@"Entertainment-OD" channelNumber:@"01002"],
        [FavoriteChannel favoriteWithName:@"ESPN Classic" channelNumber:@"00303"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #1" channelNumber:@"00392"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #2" channelNumber:@"00393"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #3" channelNumber:@"00394"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #4" channelNumber:@"00395"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #5" channelNumber:@"00396"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #6" channelNumber:@"00397"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #7" channelNumber:@"00398"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #8" channelNumber:@"00399"],
        [FavoriteChannel favoriteWithName:@"ESPN Deportes" channelNumber:@"00440"],
        [FavoriteChannel favoriteWithName:@"ESPN Goal Line" channelNumber:@"00371"],
        [FavoriteChannel favoriteWithName:@"ESPNews" channelNumber:@"00302"],
        [FavoriteChannel favoriteWithName:@"ESPNU" channelNumber:@"00370"],
        [FavoriteChannel favoriteWithName:@"Esquire " channelNumber:@"00114"],
        [FavoriteChannel favoriteWithName:@"EVINE" channelNumber:@"00022"],
        [FavoriteChannel favoriteWithName:@"Food Network " channelNumber:@"00051"],
        [FavoriteChannel favoriteWithName:@"Fox Business" channelNumber:@"00206"],
        [FavoriteChannel favoriteWithName:@"Fox College - Atlantic" channelNumber:@"00372"],
        [FavoriteChannel favoriteWithName:@"Fox College - Central" channelNumber:@"00373"],
        [FavoriteChannel favoriteWithName:@"Fox College - Pacific" channelNumber:@"00374"],
        [FavoriteChannel favoriteWithName:@"Fox Deportes" channelNumber:@"00442"],
        [FavoriteChannel favoriteWithName:@"Fox Soccer Plus" channelNumber:@"00419"],
        [FavoriteChannel favoriteWithName:@"Fox Sports 2" channelNumber:@"00401"],
        [FavoriteChannel favoriteWithName:@"Fox Sports Net" channelNumber:@"00320"],
        [FavoriteChannel favoriteWithName:@"FSN HD" channelNumber:@"00031"],
        [FavoriteChannel favoriteWithName:@"Fuse " channelNumber:@"00292"],
        [FavoriteChannel favoriteWithName:@"FXM" channelNumber:@"00632"],
        [FavoriteChannel favoriteWithName:@"FXX " channelNumber:@"00109"],
        [FavoriteChannel favoriteWithName:@"Galavision " channelNumber:@"00827"],
        [FavoriteChannel favoriteWithName:@"GOL TV" channelNumber:@"00416"],
        [FavoriteChannel favoriteWithName:@"Great American Country" channelNumber:@"00295"],
        [FavoriteChannel favoriteWithName:@"GSN " channelNumber:@"00177"],
        [FavoriteChannel favoriteWithName:@"Hallmark Channel " channelNumber:@"00123"],
        [FavoriteChannel favoriteWithName:@"Hallmark Movies" channelNumber:@"00629"],
        [FavoriteChannel favoriteWithName:@"HBO Comedy " channelNumber:@"00515"],
        [FavoriteChannel favoriteWithName:@"HBO Family " channelNumber:@"00514"],
        [FavoriteChannel favoriteWithName:@"HBO Latino" channelNumber:@"00517"],
        [FavoriteChannel favoriteWithName:@"HBO Signature " channelNumber:@"00513"],
        [FavoriteChannel favoriteWithName:@"HBO Zone " channelNumber:@"00516"],
        [FavoriteChannel favoriteWithName:@"HBO-East" channelNumber:@"00518"],
        [FavoriteChannel favoriteWithName:@"HBO2 " channelNumber:@"00512"],
        [FavoriteChannel favoriteWithName:@"HGTV" channelNumber:@"00053"],
        [FavoriteChannel favoriteWithName:@"History " channelNumber:@"00056"],
        [FavoriteChannel favoriteWithName:@"How To-OD" channelNumber:@"01999"],
        [FavoriteChannel favoriteWithName:@"HRTV" channelNumber:@"00412"],
        [FavoriteChannel favoriteWithName:@"HSN" channelNumber:@"00014"],
        [FavoriteChannel favoriteWithName:@"IFC" channelNumber:@"00627"],
        [FavoriteChannel favoriteWithName:@"IndiePlex" channelNumber:@"00621"],
        [FavoriteChannel favoriteWithName:@"Investigation Discovery" channelNumber:@"00138"],
        [FavoriteChannel favoriteWithName:@"ION" channelNumber:@"00071"],
        [FavoriteChannel favoriteWithName:@"ITV" channelNumber:@"00016"],
        [FavoriteChannel favoriteWithName:@"Jewelry Television" channelNumber:@"00023"],
        [FavoriteChannel favoriteWithName:@"KIDS-OD" channelNumber:@"00250"],
        [FavoriteChannel favoriteWithName:@"KUSI" channelNumber:@"00009"],
        [FavoriteChannel favoriteWithName:@"Learning Channel " channelNumber:@"00055"],
        [FavoriteChannel favoriteWithName:@"Lifestyle-OD" channelNumber:@"01007"],
        [FavoriteChannel favoriteWithName:@"Lifetime" channelNumber:@"00032"],
        [FavoriteChannel favoriteWithName:@"Lifetime Movie Network" channelNumber:@"00068"],
        [FavoriteChannel favoriteWithName:@"Lifetime Real Women" channelNumber:@"00174"],
        [FavoriteChannel favoriteWithName:@"Liquidation Channel" channelNumber:@"00492"],
        [FavoriteChannel favoriteWithName:@"LMN" channelNumber:@"00630"],
        [FavoriteChannel favoriteWithName:@"Lo Mejor-OD" channelNumber:@"00800"],
        [FavoriteChannel favoriteWithName:@"LOGO " channelNumber:@"00179"],
        [FavoriteChannel favoriteWithName:@"Loral-OD" channelNumber:@"01020"],
        [FavoriteChannel favoriteWithName:@"Mas" channelNumber:@"00047"],
        [FavoriteChannel favoriteWithName:@"ME TV" channelNumber:@"01255"],
        [FavoriteChannel favoriteWithName:@"Military History" channelNumber:@"00141"],
        [FavoriteChannel favoriteWithName:@"MLB Network" channelNumber:@"00306"],
        [FavoriteChannel favoriteWithName:@"MLBStrike Zone" channelNumber:@"00307"],
        [FavoriteChannel favoriteWithName:@"MNTV" channelNumber:@"00013"],
        [FavoriteChannel favoriteWithName:@"Movie Channel " channelNumber:@"00571"],
        [FavoriteChannel favoriteWithName:@"Movie Channel Extra " channelNumber:@"00572"],
        [FavoriteChannel favoriteWithName:@"Movie Channel-East" channelNumber:@"00573"],
        [FavoriteChannel favoriteWithName:@"Movie Channel-OD" channelNumber:@"00570"],
        [FavoriteChannel favoriteWithName:@"MoviePass-OD" channelNumber:@"00600"],
        [FavoriteChannel favoriteWithName:@"Movies-OD-Free" channelNumber:@"00508"],
        [FavoriteChannel favoriteWithName:@"Movies-OD-Hits" channelNumber:@"00506"],
        [FavoriteChannel favoriteWithName:@"Movies-OD-Kids" channelNumber:@"00507"],
        [FavoriteChannel favoriteWithName:@"MTV" channelNumber:@"00036"],
        [FavoriteChannel favoriteWithName:@"MTV: Tr3s" channelNumber:@"00899"],
        [FavoriteChannel favoriteWithName:@"MTV2 West" channelNumber:@"00119"],
        [FavoriteChannel favoriteWithName:@"Mun2" channelNumber:@"00898"],
        [FavoriteChannel favoriteWithName:@"Music Choice-OD" channelNumber:@"01006"],
        [FavoriteChannel favoriteWithName:@"Music-OD" channelNumber:@"00285"],
        [FavoriteChannel favoriteWithName:@"Music: '70s" channelNumber:@"01929"],
        [FavoriteChannel favoriteWithName:@"Music: '80s" channelNumber:@"01928"],
        [FavoriteChannel favoriteWithName:@"Music: '90s" channelNumber:@"01927"],
        [FavoriteChannel favoriteWithName:@"Music: Adult Alternative" channelNumber:@"01916"],
        [FavoriteChannel favoriteWithName:@"Music: Alternative" channelNumber:@"01915"],
        [FavoriteChannel favoriteWithName:@"Music: Blues" channelNumber:@"01946"],
        [FavoriteChannel favoriteWithName:@"Music: Christian" channelNumber:@"01935"],
        [FavoriteChannel favoriteWithName:@"Music: Classic Country" channelNumber:@"01934"],
        [FavoriteChannel favoriteWithName:@"Music: Classic Rock" channelNumber:@"01918"],
        [FavoriteChannel favoriteWithName:@"Music: Classical" channelNumber:@"01949"],
        [FavoriteChannel favoriteWithName:@"Music: Country Hits" channelNumber:@"01933"],
        [FavoriteChannel favoriteWithName:@"Music: Dance/EDM" channelNumber:@"01903"],
        [FavoriteChannel favoriteWithName:@"Music: Easy Listening" channelNumber:@"01948"],
        [FavoriteChannel favoriteWithName:@"Music: Gospel" channelNumber:@"01911"],
        [FavoriteChannel favoriteWithName:@"Music: Hip-Hop & R&B" channelNumber:@"01905"],
        [FavoriteChannel favoriteWithName:@"Music: Hip-Hop Classics" channelNumber:@"01907"],
        [FavoriteChannel favoriteWithName:@"Music: Hit List" channelNumber:@"01901"],
        [FavoriteChannel favoriteWithName:@"Music: Holidays" channelNumber:@"01941"],
        [FavoriteChannel favoriteWithName:@"Music: Indie" channelNumber:@"01904"],
        [FavoriteChannel favoriteWithName:@"Music: Jazz" channelNumber:@"01945"],
        [FavoriteChannel favoriteWithName:@"Music: Kidz Only!" channelNumber:@"01924"],
        [FavoriteChannel favoriteWithName:@"Music: Light Classical" channelNumber:@"01950"],
        [FavoriteChannel favoriteWithName:@"Music: Love Songs" channelNumber:@"01920"],
        [FavoriteChannel favoriteWithName:@"Music: Metal" channelNumber:@"01914"],
        [FavoriteChannel favoriteWithName:@"Music: Mexicana" channelNumber:@"01938"],
        [FavoriteChannel favoriteWithName:@"Music: Musica Urbana" channelNumber:@"01937"],
        [FavoriteChannel favoriteWithName:@"Music: Party Favorites" channelNumber:@"01922"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Country" channelNumber:@"01931"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Hits" channelNumber:@"01921"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Latino" channelNumber:@"01936"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Rhythmic" channelNumber:@"01902"],
        [FavoriteChannel favoriteWithName:@"Music: R&B Classics" channelNumber:@"01909"],
        [FavoriteChannel favoriteWithName:@"Music: R&B Soul" channelNumber:@"01910"],
        [FavoriteChannel favoriteWithName:@"Music: Rap" channelNumber:@"01906"],
        [FavoriteChannel favoriteWithName:@"Music: Reggae" channelNumber:@"01912"],
        [FavoriteChannel favoriteWithName:@"Music: Rock" channelNumber:@"01913"],
        [FavoriteChannel favoriteWithName:@"Music: Rock Hits" channelNumber:@"01917"],
        [FavoriteChannel favoriteWithName:@"Music: Romances" channelNumber:@"01940"],
        [FavoriteChannel favoriteWithName:@"Music: Singers & Swing" channelNumber:@"01947"],
        [FavoriteChannel favoriteWithName:@"Music: Smooth Jazz" channelNumber:@"01944"],
        [FavoriteChannel favoriteWithName:@"Music: Soft Rock" channelNumber:@"01919"],
        [FavoriteChannel favoriteWithName:@"Music: Solid Gold Oldies" channelNumber:@"01930"],
        [FavoriteChannel favoriteWithName:@"Music: Soundscapes" channelNumber:@"01943"],
        [FavoriteChannel favoriteWithName:@"Music: Stage & Screen" channelNumber:@"01942"],
        [FavoriteChannel favoriteWithName:@"Music: Teen MC" channelNumber:@"01923"],
        [FavoriteChannel favoriteWithName:@"Music: Throwback Jams" channelNumber:@"01908"],
        [FavoriteChannel favoriteWithName:@"Music: Today's Country" channelNumber:@"01932"],
        [FavoriteChannel favoriteWithName:@"Music: Toddler Tunes" channelNumber:@"01925"],
        [FavoriteChannel favoriteWithName:@"Music: Tropicales" channelNumber:@"01939"],
        [FavoriteChannel favoriteWithName:@"Music: Y2K" channelNumber:@"01926"],
        [FavoriteChannel favoriteWithName:@"Music: OD" channelNumber:@"01900"],
        [FavoriteChannel favoriteWithName:@"National Geo Wild" channelNumber:@"00130"],
        [FavoriteChannel favoriteWithName:@"Nature & Knowledge-OD" channelNumber:@"01008"],
        [FavoriteChannel favoriteWithName:@"NBA TV" channelNumber:@"00308"],
        [FavoriteChannel favoriteWithName:@"Nick Jr " channelNumber:@"00257"],
        [FavoriteChannel favoriteWithName:@"Nickelodeon" channelNumber:@"00033"],
        [FavoriteChannel favoriteWithName:@"Nicktoons Network" channelNumber:@"00262"],
        [FavoriteChannel favoriteWithName:@"Nuvo" channelNumber:@"00169"],
        [FavoriteChannel favoriteWithName:@"Oprah Winfrey Network " channelNumber:@"00173"],
        [FavoriteChannel favoriteWithName:@"Outdoor Channel" channelNumber:@"00408"],
        [FavoriteChannel favoriteWithName:@"Ovation TV" channelNumber:@"00187"],
        [FavoriteChannel favoriteWithName:@"Oxygen " channelNumber:@"00171"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Arizona " channelNumber:@"00377"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Bay Area " channelNumber:@"00381"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Los Angeles " channelNumber:@"00376"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Mountain " channelNumber:@"00380"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Oregon " channelNumber:@"00379"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Washington " channelNumber:@"00378"],
        [FavoriteChannel favoriteWithName:@"Palladia" channelNumber:@"00286"],
        [FavoriteChannel favoriteWithName:@"PBS Kids Sprout" channelNumber:@"00255"],
        [FavoriteChannel favoriteWithName:@"Pop" channelNumber:@"00175"],
        [FavoriteChannel favoriteWithName:@"Primetime-OD" channelNumber:@"00100"],
        [FavoriteChannel favoriteWithName:@"QVC" channelNumber:@"00025"],
        [FavoriteChannel favoriteWithName:@"QVC Plus" channelNumber:@"00481"],
        [FavoriteChannel favoriteWithName:@"Radio: EASY 98.1" channelNumber:@"01958"],
        [FavoriteChannel favoriteWithName:@"Radio: JACK100.7" channelNumber:@"01960"],
        [FavoriteChannel favoriteWithName:@"Radio: KCR 96.1" channelNumber:@"01959"],
        [FavoriteChannel favoriteWithName:@"Radio: KGB 101.5" channelNumber:@"01962"],
        [FavoriteChannel favoriteWithName:@"Radio: KMYI 94.1" channelNumber:@"01964"],
        [FavoriteChannel favoriteWithName:@"Radio: KPBS 89.5" channelNumber:@"01963"],
        [FavoriteChannel favoriteWithName:@"Radio: KSDS 88.3" channelNumber:@"01967"],
        [FavoriteChannel favoriteWithName:@"Radio: KSON 97.3" channelNumber:@"01968"],
        [FavoriteChannel favoriteWithName:@"Radio: KUSC 91.5" channelNumber:@"01965"],
        [FavoriteChannel favoriteWithName:@"Radio: KYXY 96.5" channelNumber:@"01966"],
        [FavoriteChannel favoriteWithName:@"Radio: XTRA 91.1" channelNumber:@"01961"],
        [FavoriteChannel favoriteWithName:@"ReelzChannel" channelNumber:@"00128"],
        [FavoriteChannel favoriteWithName:@"Revolt" channelNumber:@"00291"],
        [FavoriteChannel favoriteWithName:@"RLTV" channelNumber:@"00178"],
        [FavoriteChannel favoriteWithName:@"RT" channelNumber:@"00218"],
        [FavoriteChannel favoriteWithName:@"RT in Spanish" channelNumber:@"00838"],
        [FavoriteChannel favoriteWithName:@"Science" channelNumber:@"00136"],
        [FavoriteChannel favoriteWithName:@"SDN" channelNumber:@"00012"],
        [FavoriteChannel favoriteWithName:@"SEC Network" channelNumber:@"00384"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 1" channelNumber:@"00482"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 2" channelNumber:@"00485"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 3" channelNumber:@"00486"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 4" channelNumber:@"00488"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 5" channelNumber:@"00489"],
        [FavoriteChannel favoriteWithName:@"Showtime 2 " channelNumber:@"00552"],
        [FavoriteChannel favoriteWithName:@"Showtime Beyond " channelNumber:@"00555"],
        [FavoriteChannel favoriteWithName:@"Showtime Extreme " channelNumber:@"00554"],
        [FavoriteChannel favoriteWithName:@"Showtime Familyzone " channelNumber:@"00558"],
        [FavoriteChannel favoriteWithName:@"Showtime Next " channelNumber:@"00556"],
        [FavoriteChannel favoriteWithName:@"Showtime Showcase " channelNumber:@"00553"],
        [FavoriteChannel favoriteWithName:@"Showtime Women " channelNumber:@"00557"],
        [FavoriteChannel favoriteWithName:@"Showtime-East" channelNumber:@"00559"],
        [FavoriteChannel favoriteWithName:@"Smithsonian" channelNumber:@"00131"],
        [FavoriteChannel favoriteWithName:@"Spike TV " channelNumber:@"00038"],
        [FavoriteChannel favoriteWithName:@"Sports and Fitness-OD" channelNumber:@"01009"],
        [FavoriteChannel favoriteWithName:@"SundanceTV " channelNumber:@"00625"],
        [FavoriteChannel favoriteWithName:@"Syfy " channelNumber:@"00057"],
        [FavoriteChannel favoriteWithName:@"TCM" channelNumber:@"00631"],
        [FavoriteChannel favoriteWithName:@"Teen Nick" channelNumber:@"00263"],
        [FavoriteChannel favoriteWithName:@"Telemundo" channelNumber:@"00020"],
        [FavoriteChannel favoriteWithName:@"TLC" channelNumber:@"00166"],
        [FavoriteChannel favoriteWithName:@"Travel Channel " channelNumber:@"00069"],
        [FavoriteChannel favoriteWithName:@"truTV " channelNumber:@"00039"],
        [FavoriteChannel favoriteWithName:@"Turner Classic Movies" channelNumber:@"00059"],
        [FavoriteChannel favoriteWithName:@"TV Land " channelNumber:@"00065"],
        [FavoriteChannel favoriteWithName:@"TVG" channelNumber:@"00413"],
        [FavoriteChannel favoriteWithName:@"TWC Community" channelNumber:@"00084"],
        [FavoriteChannel favoriteWithName:@"TWC County" channelNumber:@"00085"],
        [FavoriteChannel favoriteWithName:@"TWC Deportes" channelNumber:@"00058"],
        [FavoriteChannel favoriteWithName:@"TWC Sportsnet SD " channelNumber:@"00035"],
        [FavoriteChannel favoriteWithName:@"UCSD TV" channelNumber:@"01231"],
        [FavoriteChannel favoriteWithName:@"UniMas East" channelNumber:@"00805"],
        [FavoriteChannel favoriteWithName:@"Universal Sports" channelNumber:@"00407"],
        [FavoriteChannel favoriteWithName:@"Univision" channelNumber:@"00017"],
        [FavoriteChannel favoriteWithName:@"Univision Deportes" channelNumber:@"00959"],
        [FavoriteChannel favoriteWithName:@"Univision-East" channelNumber:@"00802"],
        [FavoriteChannel favoriteWithName:@"UP" channelNumber:@"00124"],
        [FavoriteChannel favoriteWithName:@"USA Network " channelNumber:@"00034"],
        [FavoriteChannel favoriteWithName:@"Velocity" channelNumber:@"00403"],
        [FavoriteChannel favoriteWithName:@"VH1 " channelNumber:@"00042"],
        [FavoriteChannel favoriteWithName:@"VH1 Classic " channelNumber:@"00120"],
        [FavoriteChannel favoriteWithName:@"WE TV" channelNumber:@"00054"],
        [FavoriteChannel favoriteWithName:@"WGN" channelNumber:@"00003"]
    ];



    RemotePanel *favPanel = [[RemotePanel alloc] initWithFrame:CGRectMake(padding, 0, 200, self.view.bounds.size.height - padding)];
    [self.view addSubview:favPanel];

//    UILabel *favLbl = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, 0.0, 0.0)];
//    favLbl.textColor = [UIColor paperColorBlue500];
//    favLbl.text = @"Favorites";
//    [favPanel addSubview:favLbl];
//    [favLbl sizeToFit];

    _favTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 /*+ favLbl.bounds.size.height*/, favPanel.bounds.size.width, favPanel.bounds.size.height - (padding /*+ favLbl.bounds.size.height*/)) style:UITableViewStylePlain];
    _favTableView.backgroundColor = [UIColor paperColorGray100];
    _favTableView.delegate = self;
    _favTableView.dataSource = self;
    [favPanel addSubview:_favTableView];

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

    RemoteButton *play = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, playBtnHeight) title:@"Play"];
    [play addTarget:self action:@selector(doPlay) forControlEvents:UIControlEventTouchUpInside];
    play.backgroundColor = [UIColor paperColorGreen400];
    [self.view addSubview:play];
    yCoord += play.bounds.size.height + padding;

    RemoteButton *pause = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Pause"];
    [pause addTarget:self action:@selector(doPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pause];
    yCoord += pause.bounds.size.height + padding;

    RemoteButton *backFifteen = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"-15 Seconds"];
    [backFifteen addTarget:self action:@selector(doBackFifteen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backFifteen];
    yCoord += backFifteen.bounds.size.height + padding;

    RemoteButton *rewind = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Rewind"];
    [rewind addTarget:self action:@selector(doRewind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rewind];
    yCoord += rewind.bounds.size.height + padding;

    RemoteButton *record = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Record"];
    [record addTarget:self action:@selector(doRecord) forControlEvents:UIControlEventTouchUpInside];
    record.backgroundColor = [UIColor paperColorRed400];
    [self.view addSubview:record];
    yCoord += record.bounds.size.height + padding;

    CGFloat halfBtnWidth = (btnWidth - padding) / 2;

    RemoteButton *stop = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, halfBtnWidth, btnHeight) title:@"Stop"];
    [stop addTarget:self action:@selector(doStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];

    RemoteButton *live = [RemoteButton buttonWithFrame:CGRectMake(xCoord + halfBtnWidth + padding, yCoord, halfBtnWidth, btnHeight) title:@"Live"];
    [live addTarget:self action:@selector(doLive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:live];

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

    CGFloat halfWidth = (btnWidth - padding) / 2.f;

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

    RemoteButton *menu = [RemoteButton buttonWithFrame:CGRectMake(xCoord + halfWidth + padding, yCoord, halfWidth, btnHeight) title:@"Menu"];
    [menu addTarget:self action:@selector(doMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menu];
    yCoord += menu.bounds.size.height + padding;

    RemoteButton *exit = [RemoteButton buttonWithFrame:CGRectMake(xCoord, yCoord, btnWidth, btnHeight) title:@"Exit"];
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

    RemoteButton *enterBtn = [RemoteButton buttonWithFrame:CGRectMake(numberSize * 2, yCoord, numberSize, numberSize) title:@"Select"];
    enterBtn.isRaised = false;
    [enterBtn addTarget:self action:@selector(doSelect) forControlEvents:UIControlEventTouchUpInside];
    [numberPanel addSubview:enterBtn];

    // Extras Table
    _extras = @[
        @(IRCommandPowerOnOff),
        @(IRCommandPlusChannel),
        @(IRCommandMinusChannel),
        @(IRCommandPlusDay),
        @(IRCommandMinusDay),
        @(IRCommandA),
        @(IRCommandB),
        @(IRCommandC),
        @(IRCommandD),
        @(IRCommandInfo),
        @(IRCommandOnDemand),
        @(IRCommandStar),
        @(IRCommandPound),
        @(IRCommandSettings),
        @(IRCommandMenu),
        @(IRCommandHelp)
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView == _favTableView ? 2 : 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == _extrasTableView) {
        return nil;
    }

    return section == 0 ? @"Favorites" : @"Channels";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _favTableView) {
        return section == 0 ? [_favorites count] : [_channels count];
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
        if (indexPath.section == 0) {
            cell.textLabel.text = _favorites && [_favorites count] > 0 ? ((FavoriteChannel *) _favorites[indexPath.row]).name : @"None";
            cell.selectionStyle = _favorites && [_favorites count] > 0 ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
        }else {
            cell.textLabel.text = _channels && [_channels count] > 0 ? ((FavoriteChannel *) _channels[indexPath.row]).name : @"None";
            cell.selectionStyle = _channels && [_channels count] > 0 ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
        }
    } else {
        cell.textLabel.text = stringForIRCommand(((enum IRCommand) [_extras[indexPath.row] integerValue]));
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _favTableView) {
        if (indexPath.section == 0) {
            if (!_favorites || [_favorites count] < 1) {
                return;
            }
            FavoriteChannel *fav = _favorites[indexPath.row];
            [self doFavorite:fav.channelNumber];
        }else {
            if (!_channels || [_channels count] < 1) {
                return;
            }
            FavoriteChannel *fav = _channels[indexPath.row];
            [self doFavorite:fav.channelNumber];
        }

    } else {
        [[CommandCenter singleton] sendIRCommand:((enum IRCommand) ([_extras[indexPath.row] integerValue])) toIRDevice:_device];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)doFavorite:(NSString *)favorite {
    for (int i = 0; i < [favorite length]; ++i) {
        NSString * text = [NSString stringWithFormat:@"%c", [favorite characterAtIndex:i]];
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

- (void)doPause {
    [[CommandCenter singleton] sendIRCommand:IRCommandPause toIRDevice:_device];
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

- (void)doPageUp {
    [[CommandCenter singleton] sendIRCommand:IRCommandPageUp toIRDevice:_device];
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

- (void)doPageDown {
    [[CommandCenter singleton] sendIRCommand:IRCommandPageDown toIRDevice:_device];
}

- (void)doInfo {
    [[CommandCenter singleton] sendIRCommand:IRCommandInfo toIRDevice:_device];
}

- (void)doExit {
    [[CommandCenter singleton] sendIRCommand:IRCommandExit toIRDevice:_device];
}

- (void)doNumber:(RemoteButton *)sender {
    NSString * text = sender.titleLabel.text;
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

- (void)doLast {
    [[CommandCenter singleton] sendIRCommand:IRCommandLast toIRDevice:_device];
}

- (void)doBackFifteen {
    [[CommandCenter singleton] sendIRCommand:IRCommandBackFifteenSec toIRDevice:_device];
}

- (void)doMenu {
    [[CommandCenter singleton] sendIRCommand:IRCommandMenu toIRDevice:_device];
}

@end