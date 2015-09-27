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
        [FavoriteChannel favoriteWithName:@"4 SDHD" channelNumber:@"0004"],
        [FavoriteChannel favoriteWithName:@"A&E" channelNumber:@"0045"],
        [FavoriteChannel favoriteWithName:@"A&E Network " channelNumber:@"0102"],
        [FavoriteChannel favoriteWithName:@"ABC Family " channelNumber:@"0067"],
        [FavoriteChannel favoriteWithName:@"Al Jazeera America" channelNumber:@"0210"],
        [FavoriteChannel favoriteWithName:@"AMC " channelNumber:@"0043"],
        [FavoriteChannel favoriteWithName:@"America's Auction" channelNumber:@"0491"],
        [FavoriteChannel favoriteWithName:@"American Heroes" channelNumber:@"0140"],
        [FavoriteChannel favoriteWithName:@"Animal Planet " channelNumber:@"0064"],
        [FavoriteChannel favoriteWithName:@"Antenna TV" channelNumber:@"1250"],
        [FavoriteChannel favoriteWithName:@"Aspire" channelNumber:@"0185"],
        [FavoriteChannel favoriteWithName:@"Automotive-OD" channelNumber:@"1028"],
        [FavoriteChannel favoriteWithName:@"Azteca America" channelNumber:@"0015"],
        [FavoriteChannel favoriteWithName:@"BBC America " channelNumber:@"0110"],
        [FavoriteChannel favoriteWithName:@"BBC World News" channelNumber:@"0209"],
        [FavoriteChannel favoriteWithName:@"beIN Sports" channelNumber:@"0417"],
        [FavoriteChannel favoriteWithName:@"beIN Sports En Español" channelNumber:@"0443"],
        [FavoriteChannel favoriteWithName:@"BET " channelNumber:@"0070"],
        [FavoriteChannel favoriteWithName:@"Big Ten Network" channelNumber:@"0382"],
        [FavoriteChannel favoriteWithName:@"Big Ten Network 1" channelNumber:@"0388"],
        [FavoriteChannel favoriteWithName:@"Big Ten Network 2" channelNumber:@"0389"],
        [FavoriteChannel favoriteWithName:@"Bravo " channelNumber:@"0040"],
        [FavoriteChannel favoriteWithName:@"BYU-TV" channelNumber:@"0465"],
        [FavoriteChannel favoriteWithName:@"California Channel " channelNumber:@"0229"],
        [FavoriteChannel favoriteWithName:@"Cartoon Network " channelNumber:@"0062"],
        [FavoriteChannel favoriteWithName:@"CCTV News" channelNumber:@"0221"],
        [FavoriteChannel favoriteWithName:@"Centric" channelNumber:@"0182"],
        [FavoriteChannel favoriteWithName:@"Chiller" channelNumber:@"0127"],
        [FavoriteChannel favoriteWithName:@"CineMAX: 5 StarMAX" channelNumber:@"0537"],
        [FavoriteChannel favoriteWithName:@"CineMAX: ActionMAX " channelNumber:@"0533"],
        [FavoriteChannel favoriteWithName:@"CineMAX: CineMAX-East" channelNumber:@"0539"],
        [FavoriteChannel favoriteWithName:@"CineMAX: Latino" channelNumber:@"0536"],
        [FavoriteChannel favoriteWithName:@"CineMAX: MoreMAX " channelNumber:@"0532"],
        [FavoriteChannel favoriteWithName:@"CineMAX: MovieMax" channelNumber:@"0538"],
        [FavoriteChannel favoriteWithName:@"CineMAX: OuterMAX " channelNumber:@"0535"],
        [FavoriteChannel favoriteWithName:@"CineMAX: ThrillerMAX " channelNumber:@"0534"],
        [FavoriteChannel favoriteWithName:@"City TV" channelNumber:@"0024"],
        [FavoriteChannel favoriteWithName:@"Cloo" channelNumber:@"0139"],
        [FavoriteChannel favoriteWithName:@"CNBC World" channelNumber:@"0208"],
        [FavoriteChannel favoriteWithName:@"College Football TWC" channelNumber:@"0385"],
        [FavoriteChannel favoriteWithName:@"Comedy Central " channelNumber:@"0060"],
        [FavoriteChannel favoriteWithName:@"Country Music TV" channelNumber:@"0066"],
        [FavoriteChannel favoriteWithName:@"COZI TV" channelNumber:@"1245"],
        [FavoriteChannel favoriteWithName:@"CPC" channelNumber:@"0019"],
        [FavoriteChannel favoriteWithName:@"Crime & Investigation" channelNumber:@"0137"],
        [FavoriteChannel favoriteWithName:@"CSPAN" channelNumber:@"0021"],
        [FavoriteChannel favoriteWithName:@"CSPAN2" channelNumber:@"0226"],
        [FavoriteChannel favoriteWithName:@"Cutting Edge-OD" channelNumber:@"1003"],
        [FavoriteChannel favoriteWithName:@"CW" channelNumber:@"0006"],
        [FavoriteChannel favoriteWithName:@"Daystar TV Network" channelNumber:@"0463"],
        [FavoriteChannel favoriteWithName:@"Destination America" channelNumber:@"0135"],
        [FavoriteChannel favoriteWithName:@"Discovery Channel " channelNumber:@"0044"],
        [FavoriteChannel favoriteWithName:@"Discovery Family " channelNumber:@"0266"],
        [FavoriteChannel favoriteWithName:@"Disney Channel " channelNumber:@"0063"],
        [FavoriteChannel favoriteWithName:@"Disney Junior US " channelNumber:@"0254"],
        [FavoriteChannel favoriteWithName:@"Disney XD Pacific" channelNumber:@"0265"],
        [FavoriteChannel favoriteWithName:@"Disney-East" channelNumber:@"0252"],
        [FavoriteChannel favoriteWithName:@"E! Entertainment" channelNumber:@"0048"],
        [FavoriteChannel favoriteWithName:@"El Rey Network" channelNumber:@"0145"],
        [FavoriteChannel favoriteWithName:@"Encore " channelNumber:@"0602"],
        [FavoriteChannel favoriteWithName:@"Encore Action " channelNumber:@"0603"],
        [FavoriteChannel favoriteWithName:@"Encore Action-East" channelNumber:@"0610"],
        [FavoriteChannel favoriteWithName:@"Encore Black " channelNumber:@"0604"],
        [FavoriteChannel favoriteWithName:@"Encore Black-East" channelNumber:@"0611"],
        [FavoriteChannel favoriteWithName:@"Encore Classic " channelNumber:@"0605"],
        [FavoriteChannel favoriteWithName:@"Encore Classic-East" channelNumber:@"0612"],
        [FavoriteChannel favoriteWithName:@"Encore Family " channelNumber:@"0608"],
        [FavoriteChannel favoriteWithName:@"Encore Suspense " channelNumber:@"0606"],
        [FavoriteChannel favoriteWithName:@"Encore Suspense-East" channelNumber:@"0613"],
        [FavoriteChannel favoriteWithName:@"Encore Westerns " channelNumber:@"0607"],
        [FavoriteChannel favoriteWithName:@"Encore Westerns-East" channelNumber:@"0614"],
        [FavoriteChannel favoriteWithName:@"Encore-East" channelNumber:@"0609"],
        [FavoriteChannel favoriteWithName:@"Entertainment-OD" channelNumber:@"1002"],
        [FavoriteChannel favoriteWithName:@"ESPN Classic" channelNumber:@"0303"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #1" channelNumber:@"0392"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #2" channelNumber:@"0393"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #3" channelNumber:@"0394"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #4" channelNumber:@"0395"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #5" channelNumber:@"0396"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #6" channelNumber:@"0397"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #7" channelNumber:@"0398"],
        [FavoriteChannel favoriteWithName:@"ESPN College Xtra #8" channelNumber:@"0399"],
        [FavoriteChannel favoriteWithName:@"ESPN Deportes" channelNumber:@"0440"],
        [FavoriteChannel favoriteWithName:@"ESPN Goal Line" channelNumber:@"0371"],
        [FavoriteChannel favoriteWithName:@"ESPNews" channelNumber:@"0302"],
        [FavoriteChannel favoriteWithName:@"ESPNU" channelNumber:@"0370"],
        [FavoriteChannel favoriteWithName:@"Esquire " channelNumber:@"0114"],
        [FavoriteChannel favoriteWithName:@"EVINE" channelNumber:@"0022"],
        [FavoriteChannel favoriteWithName:@"Food Network " channelNumber:@"0051"],
        [FavoriteChannel favoriteWithName:@"Fox Business" channelNumber:@"0206"],
        [FavoriteChannel favoriteWithName:@"Fox College - Atlantic" channelNumber:@"0372"],
        [FavoriteChannel favoriteWithName:@"Fox College - Central" channelNumber:@"0373"],
        [FavoriteChannel favoriteWithName:@"Fox College - Pacific" channelNumber:@"0374"],
        [FavoriteChannel favoriteWithName:@"Fox Deportes" channelNumber:@"0442"],
        [FavoriteChannel favoriteWithName:@"Fox Soccer Plus" channelNumber:@"0419"],
        [FavoriteChannel favoriteWithName:@"Fox Sports 2" channelNumber:@"0401"],
        [FavoriteChannel favoriteWithName:@"Fox Sports Net" channelNumber:@"0320"],
        [FavoriteChannel favoriteWithName:@"FSN HD" channelNumber:@"0031"],
        [FavoriteChannel favoriteWithName:@"Fuse " channelNumber:@"0292"],
        [FavoriteChannel favoriteWithName:@"FXM" channelNumber:@"0632"],
        [FavoriteChannel favoriteWithName:@"FXX " channelNumber:@"0109"],
        [FavoriteChannel favoriteWithName:@"Galavision " channelNumber:@"0827"],
        [FavoriteChannel favoriteWithName:@"GOL TV" channelNumber:@"0416"],
        [FavoriteChannel favoriteWithName:@"Great American Country" channelNumber:@"0295"],
        [FavoriteChannel favoriteWithName:@"GSN " channelNumber:@"0177"],
        [FavoriteChannel favoriteWithName:@"Hallmark Channel " channelNumber:@"0123"],
        [FavoriteChannel favoriteWithName:@"Hallmark Movies" channelNumber:@"0629"],
        [FavoriteChannel favoriteWithName:@"HBO Comedy " channelNumber:@"0515"],
        [FavoriteChannel favoriteWithName:@"HBO Family " channelNumber:@"0514"],
        [FavoriteChannel favoriteWithName:@"HBO Latino" channelNumber:@"0517"],
        [FavoriteChannel favoriteWithName:@"HBO Signature " channelNumber:@"0513"],
        [FavoriteChannel favoriteWithName:@"HBO Zone " channelNumber:@"0516"],
        [FavoriteChannel favoriteWithName:@"HBO-East" channelNumber:@"0518"],
        [FavoriteChannel favoriteWithName:@"HBO2 " channelNumber:@"0512"],
        [FavoriteChannel favoriteWithName:@"HGTV" channelNumber:@"0053"],
        [FavoriteChannel favoriteWithName:@"History " channelNumber:@"0056"],
        [FavoriteChannel favoriteWithName:@"How To-OD" channelNumber:@"1999"],
        [FavoriteChannel favoriteWithName:@"HRTV" channelNumber:@"0412"],
        [FavoriteChannel favoriteWithName:@"HSN" channelNumber:@"0014"],
        [FavoriteChannel favoriteWithName:@"IFC" channelNumber:@"0627"],
        [FavoriteChannel favoriteWithName:@"IndiePlex" channelNumber:@"0621"],
        [FavoriteChannel favoriteWithName:@"Investigation Discovery" channelNumber:@"0138"],
        [FavoriteChannel favoriteWithName:@"ION" channelNumber:@"0071"],
        [FavoriteChannel favoriteWithName:@"ITV" channelNumber:@"0016"],
        [FavoriteChannel favoriteWithName:@"Jewelry Television" channelNumber:@"0023"],
        [FavoriteChannel favoriteWithName:@"KIDS-OD" channelNumber:@"0250"],
        [FavoriteChannel favoriteWithName:@"KUSI" channelNumber:@"0009"],
        [FavoriteChannel favoriteWithName:@"Learning Channel " channelNumber:@"0055"],
        [FavoriteChannel favoriteWithName:@"Lifestyle-OD" channelNumber:@"1007"],
        [FavoriteChannel favoriteWithName:@"Lifetime" channelNumber:@"0032"],
        [FavoriteChannel favoriteWithName:@"Lifetime Movie Network" channelNumber:@"0068"],
        [FavoriteChannel favoriteWithName:@"Lifetime Real Women" channelNumber:@"0174"],
        [FavoriteChannel favoriteWithName:@"Liquidation Channel" channelNumber:@"0492"],
        [FavoriteChannel favoriteWithName:@"LMN" channelNumber:@"0630"],
        [FavoriteChannel favoriteWithName:@"Lo Mejor-OD" channelNumber:@"0800"],
        [FavoriteChannel favoriteWithName:@"LOGO " channelNumber:@"0179"],
        [FavoriteChannel favoriteWithName:@"Loral-OD" channelNumber:@"1020"],
        [FavoriteChannel favoriteWithName:@"Mas" channelNumber:@"0047"],
        [FavoriteChannel favoriteWithName:@"ME TV" channelNumber:@"1255"],
        [FavoriteChannel favoriteWithName:@"Military History" channelNumber:@"0141"],
        [FavoriteChannel favoriteWithName:@"MLB Network" channelNumber:@"0306"],
        [FavoriteChannel favoriteWithName:@"MLBStrike Zone" channelNumber:@"0307"],
        [FavoriteChannel favoriteWithName:@"MNTV" channelNumber:@"0013"],
        [FavoriteChannel favoriteWithName:@"Movie Channel " channelNumber:@"0571"],
        [FavoriteChannel favoriteWithName:@"Movie Channel Extra " channelNumber:@"0572"],
        [FavoriteChannel favoriteWithName:@"Movie Channel-East" channelNumber:@"0573"],
        [FavoriteChannel favoriteWithName:@"Movie Channel-OD" channelNumber:@"0570"],
        [FavoriteChannel favoriteWithName:@"MoviePass-OD" channelNumber:@"0600"],
        [FavoriteChannel favoriteWithName:@"Movies-OD-Free" channelNumber:@"0508"],
        [FavoriteChannel favoriteWithName:@"Movies-OD-Hits" channelNumber:@"0506"],
        [FavoriteChannel favoriteWithName:@"Movies-OD-Kids" channelNumber:@"0507"],
        [FavoriteChannel favoriteWithName:@"MTV" channelNumber:@"0036"],
        [FavoriteChannel favoriteWithName:@"MTV: Tr3s" channelNumber:@"0899"],
        [FavoriteChannel favoriteWithName:@"MTV2 West" channelNumber:@"0119"],
        [FavoriteChannel favoriteWithName:@"Mun2" channelNumber:@"0898"],
        [FavoriteChannel favoriteWithName:@"Music Choice-OD" channelNumber:@"1006"],
        [FavoriteChannel favoriteWithName:@"Music-OD" channelNumber:@"0285"],
        [FavoriteChannel favoriteWithName:@"Music: '70s" channelNumber:@"1929"],
        [FavoriteChannel favoriteWithName:@"Music: '80s" channelNumber:@"1928"],
        [FavoriteChannel favoriteWithName:@"Music: '90s" channelNumber:@"1927"],
        [FavoriteChannel favoriteWithName:@"Music: Adult Alternative" channelNumber:@"1916"],
        [FavoriteChannel favoriteWithName:@"Music: Alternative" channelNumber:@"1915"],
        [FavoriteChannel favoriteWithName:@"Music: Blues" channelNumber:@"1946"],
        [FavoriteChannel favoriteWithName:@"Music: Christian" channelNumber:@"1935"],
        [FavoriteChannel favoriteWithName:@"Music: Classic Country" channelNumber:@"1934"],
        [FavoriteChannel favoriteWithName:@"Music: Classic Rock" channelNumber:@"1918"],
        [FavoriteChannel favoriteWithName:@"Music: Classical" channelNumber:@"1949"],
        [FavoriteChannel favoriteWithName:@"Music: Country Hits" channelNumber:@"1933"],
        [FavoriteChannel favoriteWithName:@"Music: Dance/EDM" channelNumber:@"1903"],
        [FavoriteChannel favoriteWithName:@"Music: Easy Listening" channelNumber:@"1948"],
        [FavoriteChannel favoriteWithName:@"Music: Gospel" channelNumber:@"1911"],
        [FavoriteChannel favoriteWithName:@"Music: Hip-Hop & R&B" channelNumber:@"1905"],
        [FavoriteChannel favoriteWithName:@"Music: Hip-Hop Classics" channelNumber:@"1907"],
        [FavoriteChannel favoriteWithName:@"Music: Hit List" channelNumber:@"1901"],
        [FavoriteChannel favoriteWithName:@"Music: Holidays" channelNumber:@"1941"],
        [FavoriteChannel favoriteWithName:@"Music: Indie" channelNumber:@"1904"],
        [FavoriteChannel favoriteWithName:@"Music: Jazz" channelNumber:@"1945"],
        [FavoriteChannel favoriteWithName:@"Music: Kidz Only!" channelNumber:@"1924"],
        [FavoriteChannel favoriteWithName:@"Music: Light Classical" channelNumber:@"1950"],
        [FavoriteChannel favoriteWithName:@"Music: Love Songs" channelNumber:@"1920"],
        [FavoriteChannel favoriteWithName:@"Music: Metal" channelNumber:@"1914"],
        [FavoriteChannel favoriteWithName:@"Music: Mexicana" channelNumber:@"1938"],
        [FavoriteChannel favoriteWithName:@"Music: Musica Urbana" channelNumber:@"1937"],
        [FavoriteChannel favoriteWithName:@"Music: Party Favorites" channelNumber:@"1922"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Country" channelNumber:@"1931"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Hits" channelNumber:@"1921"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Latino" channelNumber:@"1936"],
        [FavoriteChannel favoriteWithName:@"Music: Pop Rhythmic" channelNumber:@"1902"],
        [FavoriteChannel favoriteWithName:@"Music: R&B Classics" channelNumber:@"1909"],
        [FavoriteChannel favoriteWithName:@"Music: R&B Soul" channelNumber:@"1910"],
        [FavoriteChannel favoriteWithName:@"Music: Rap" channelNumber:@"1906"],
        [FavoriteChannel favoriteWithName:@"Music: Reggae" channelNumber:@"1912"],
        [FavoriteChannel favoriteWithName:@"Music: Rock" channelNumber:@"1913"],
        [FavoriteChannel favoriteWithName:@"Music: Rock Hits" channelNumber:@"1917"],
        [FavoriteChannel favoriteWithName:@"Music: Romances" channelNumber:@"1940"],
        [FavoriteChannel favoriteWithName:@"Music: Singers & Swing" channelNumber:@"1947"],
        [FavoriteChannel favoriteWithName:@"Music: Smooth Jazz" channelNumber:@"1944"],
        [FavoriteChannel favoriteWithName:@"Music: Soft Rock" channelNumber:@"1919"],
        [FavoriteChannel favoriteWithName:@"Music: Solid Gold Oldies" channelNumber:@"1930"],
        [FavoriteChannel favoriteWithName:@"Music: Soundscapes" channelNumber:@"1943"],
        [FavoriteChannel favoriteWithName:@"Music: Stage & Screen" channelNumber:@"1942"],
        [FavoriteChannel favoriteWithName:@"Music: Teen MC" channelNumber:@"1923"],
        [FavoriteChannel favoriteWithName:@"Music: Throwback Jams" channelNumber:@"1908"],
        [FavoriteChannel favoriteWithName:@"Music: Today's Country" channelNumber:@"1932"],
        [FavoriteChannel favoriteWithName:@"Music: Toddler Tunes" channelNumber:@"1925"],
        [FavoriteChannel favoriteWithName:@"Music: Tropicales" channelNumber:@"1939"],
        [FavoriteChannel favoriteWithName:@"Music: Y2K" channelNumber:@"1926"],
        [FavoriteChannel favoriteWithName:@"Music: OD" channelNumber:@"1900"],
        [FavoriteChannel favoriteWithName:@"National Geo Wild" channelNumber:@"0130"],
        [FavoriteChannel favoriteWithName:@"Nature & Knowledge-OD" channelNumber:@"1008"],
        [FavoriteChannel favoriteWithName:@"NBA TV" channelNumber:@"0308"],
        [FavoriteChannel favoriteWithName:@"Nick Jr " channelNumber:@"0257"],
        [FavoriteChannel favoriteWithName:@"Nickelodeon" channelNumber:@"0033"],
        [FavoriteChannel favoriteWithName:@"Nicktoons Network" channelNumber:@"0262"],
        [FavoriteChannel favoriteWithName:@"Nuvo" channelNumber:@"0169"],
        [FavoriteChannel favoriteWithName:@"Oprah Winfrey Network " channelNumber:@"0173"],
        [FavoriteChannel favoriteWithName:@"Outdoor Channel" channelNumber:@"0408"],
        [FavoriteChannel favoriteWithName:@"Ovation TV" channelNumber:@"0187"],
        [FavoriteChannel favoriteWithName:@"Oxygen " channelNumber:@"0171"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Arizona " channelNumber:@"0377"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Bay Area " channelNumber:@"0381"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Los Angeles " channelNumber:@"0376"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Mountain " channelNumber:@"0380"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Oregon " channelNumber:@"0379"],
        [FavoriteChannel favoriteWithName:@"Pac-12 Washington " channelNumber:@"0378"],
        [FavoriteChannel favoriteWithName:@"Palladia" channelNumber:@"0286"],
        [FavoriteChannel favoriteWithName:@"PBS Kids Sprout" channelNumber:@"0255"],
        [FavoriteChannel favoriteWithName:@"Pop" channelNumber:@"0175"],
        [FavoriteChannel favoriteWithName:@"Primetime-OD" channelNumber:@"0100"],
        [FavoriteChannel favoriteWithName:@"QVC" channelNumber:@"0025"],
        [FavoriteChannel favoriteWithName:@"QVC Plus" channelNumber:@"0481"],
        [FavoriteChannel favoriteWithName:@"Radio: EASY 98.1" channelNumber:@"1958"],
        [FavoriteChannel favoriteWithName:@"Radio: JACK100.7" channelNumber:@"1960"],
        [FavoriteChannel favoriteWithName:@"Radio: KCR 96.1" channelNumber:@"1959"],
        [FavoriteChannel favoriteWithName:@"Radio: KGB 101.5" channelNumber:@"1962"],
        [FavoriteChannel favoriteWithName:@"Radio: KMYI 94.1" channelNumber:@"1964"],
        [FavoriteChannel favoriteWithName:@"Radio: KPBS 89.5" channelNumber:@"1963"],
        [FavoriteChannel favoriteWithName:@"Radio: KSDS 88.3" channelNumber:@"1967"],
        [FavoriteChannel favoriteWithName:@"Radio: KSON 97.3" channelNumber:@"1968"],
        [FavoriteChannel favoriteWithName:@"Radio: KUSC 91.5" channelNumber:@"1965"],
        [FavoriteChannel favoriteWithName:@"Radio: KYXY 96.5" channelNumber:@"1966"],
        [FavoriteChannel favoriteWithName:@"Radio: XTRA 91.1" channelNumber:@"1961"],
        [FavoriteChannel favoriteWithName:@"ReelzChannel" channelNumber:@"0128"],
        [FavoriteChannel favoriteWithName:@"Revolt" channelNumber:@"0291"],
        [FavoriteChannel favoriteWithName:@"RLTV" channelNumber:@"0178"],
        [FavoriteChannel favoriteWithName:@"RT" channelNumber:@"0218"],
        [FavoriteChannel favoriteWithName:@"RT in Spanish" channelNumber:@"0838"],
        [FavoriteChannel favoriteWithName:@"Science" channelNumber:@"0136"],
        [FavoriteChannel favoriteWithName:@"SDN" channelNumber:@"0012"],
        [FavoriteChannel favoriteWithName:@"SEC Network" channelNumber:@"0384"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 1" channelNumber:@"0482"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 2" channelNumber:@"0485"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 3" channelNumber:@"0486"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 4" channelNumber:@"0488"],
        [FavoriteChannel favoriteWithName:@"Shop Zeal 5" channelNumber:@"0489"],
        [FavoriteChannel favoriteWithName:@"Showtime 2 " channelNumber:@"0552"],
        [FavoriteChannel favoriteWithName:@"Showtime Beyond " channelNumber:@"0555"],
        [FavoriteChannel favoriteWithName:@"Showtime Extreme " channelNumber:@"0554"],
        [FavoriteChannel favoriteWithName:@"Showtime Familyzone " channelNumber:@"0558"],
        [FavoriteChannel favoriteWithName:@"Showtime Next " channelNumber:@"0556"],
        [FavoriteChannel favoriteWithName:@"Showtime Showcase " channelNumber:@"0553"],
        [FavoriteChannel favoriteWithName:@"Showtime Women " channelNumber:@"0557"],
        [FavoriteChannel favoriteWithName:@"Showtime-East" channelNumber:@"0559"],
        [FavoriteChannel favoriteWithName:@"Smithsonian" channelNumber:@"0131"],
        [FavoriteChannel favoriteWithName:@"Spike TV " channelNumber:@"0038"],
        [FavoriteChannel favoriteWithName:@"Sports and Fitness-OD" channelNumber:@"1009"],
        [FavoriteChannel favoriteWithName:@"SundanceTV " channelNumber:@"0625"],
        [FavoriteChannel favoriteWithName:@"Syfy " channelNumber:@"0057"],
        [FavoriteChannel favoriteWithName:@"TCM" channelNumber:@"0631"],
        [FavoriteChannel favoriteWithName:@"Teen Nick" channelNumber:@"0263"],
        [FavoriteChannel favoriteWithName:@"Telemundo" channelNumber:@"0020"],
        [FavoriteChannel favoriteWithName:@"TLC" channelNumber:@"0166"],
        [FavoriteChannel favoriteWithName:@"Travel Channel " channelNumber:@"0069"],
        [FavoriteChannel favoriteWithName:@"truTV " channelNumber:@"0039"],
        [FavoriteChannel favoriteWithName:@"Turner Classic Movies" channelNumber:@"0059"],
        [FavoriteChannel favoriteWithName:@"TV Land " channelNumber:@"0065"],
        [FavoriteChannel favoriteWithName:@"TVG" channelNumber:@"0413"],
        [FavoriteChannel favoriteWithName:@"TWC Community" channelNumber:@"0084"],
        [FavoriteChannel favoriteWithName:@"TWC County" channelNumber:@"0085"],
        [FavoriteChannel favoriteWithName:@"TWC Deportes" channelNumber:@"0058"],
        [FavoriteChannel favoriteWithName:@"TWC Sportsnet SD " channelNumber:@"0035"],
        [FavoriteChannel favoriteWithName:@"UCSD TV" channelNumber:@"1231"],
        [FavoriteChannel favoriteWithName:@"UniMas East" channelNumber:@"0805"],
        [FavoriteChannel favoriteWithName:@"Universal Sports" channelNumber:@"0407"],
        [FavoriteChannel favoriteWithName:@"Univision" channelNumber:@"0017"],
        [FavoriteChannel favoriteWithName:@"Univision Deportes" channelNumber:@"0959"],
        [FavoriteChannel favoriteWithName:@"Univision-East" channelNumber:@"0802"],
        [FavoriteChannel favoriteWithName:@"UP" channelNumber:@"0124"],
        [FavoriteChannel favoriteWithName:@"USA Network " channelNumber:@"0034"],
        [FavoriteChannel favoriteWithName:@"Velocity" channelNumber:@"0403"],
        [FavoriteChannel favoriteWithName:@"VH1 " channelNumber:@"0042"],
        [FavoriteChannel favoriteWithName:@"VH1 Classic " channelNumber:@"0120"],
        [FavoriteChannel favoriteWithName:@"WE TV" channelNumber:@"0054"],
        [FavoriteChannel favoriteWithName:@"WGN" channelNumber:@"0003"]
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