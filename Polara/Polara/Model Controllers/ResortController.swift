//
//  ResortController.swift
//  Polara
//
//  Created by Carson Buckley on 5/10/19.
//  Copyright © 2019 Foundry. All rights reserved.
//

import Foundation
import Firebase

class ResortController {
    
    //Singleton
    static let sharedInstance = ResortController()
    
    //Base URL
    let baseURL = URL(string: "https://api.weather.com/v3/wx/observations")
    
    //Private init
    private init() {
        self.resorts = createAllResorts()
    }
    
    //Source of Truth
    var resorts: [Resort] = []
    
    //Properties
    let units = "e"
    let language = "en-US"
    let format = "json"
    let apiKey = "9d2908c81003444ea908c81003b44ed4"
    
    //.count = 42
    let resortNames = ["Arapahoe Basin", "Aspen Highlands", "Aspen Mountain", "Beaver Creek", "Breckenridge", "Buttermilk", "Crested Butte", "Cooper", "Copper Mountain", "Echo Mountain", "Eldora", "Granby Ranch", "Hesperus", "Howelsen Hill", "Kendall Mountain", "Keystone", "Loveland", "Monarch", "Powderhorn", "Purgatory", "Silverton", "Snowmass", "Steamboat", "Sunlight", "Telluride", "Vail", "Winter Park", "Wolf Creek", "Alta", "Beaver Mountain", "Brian Head", "Brighton", "Cherry Peak", "Deer Valley", "Eagle Point", "Nordic Valley", "Park City", "Powder Mountain", "Snowbasin", "Snowbird", "Solitude", "Sundance"]
    
    //.count = 42
    let resortLocations = ["Dillon", "Aspen", "Aspen", "Avon", "Breckenridge", "Aspen", "Crested Butte", "Leadville", "Frisco", "Idaho Springs", "Nederland", "Granby", "Hesperus", "Steamboat Springs", "Silverton", "Dillon", "Dillon", "Salida", "Mesa", "Durango", "Silverton", "Snowmass Village", "Steamboat Springs", "Glenwood Springs", "Telluride", "Vail", "Winter Park", "Pagosa Springs", "Alta", "Garden City", "Brian Head", "Brighton", "Richmond", "Park City", "Beaver", "Eden", "Park City", "Eden", "Huntsville", "Snowbird", "Solitude", "Sundance"]
    
    //.count = 14 [UT]
    //.count = 28 [CO]
    //.count = 42 [Total]
    let resortStates = ["CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "CO", "UT", "UT", "UT", "UT", "UT", "UT", "UT", "UT", "UT", "UT", "UT", "UT", "UT", "UT"]
    
    //.count = 42
    //[28: CO]
    //[14: UT]
    
    //Colorado
    //[1] Arapahoe Basin: ______ 39.6424,-105.8723
    //[2] Aspen Highlands: _____ 39.1816,-106.8561
    //[3] Aspen Mountain: ______ 39.1765,-106.8206
    //[4] Beaver Creek: ________ 39.6040,-106.5180
    //[5] Breckenridge: ________ 39.4811,-106.0674
    //[6] Buttermilk: __________ 39.1916,-106.8667
    //[7] Crested Butte: _______ 38.8998,-106.9650
    //[8] Cooper: ______________ 39.3601,-106.3009
    //[9] Copper Mountain: _____ 39.5005,-106.1552
    //[10] Echo Mountain: ______ 39.6847,-105.5193
    //[11] Eldora: _____________ 39.9382,-105.5843
    //[12] Granby Ranch: _______ 40.0446,-105.9063
    //[13] Hesperus: ___________ 37.2991,-108.0549
    //[14] Howelsen Hill: ______ 40.4828,-106.8390
    //[15] Kendall Mountain: ___ 37.7933,-107.6289
    //[16] Keystone: ___________ 39.5729,-105.9463
    //[17] Loveland: ___________ 39.6807,-105.8972
    //[18] Monarch: ____________ 38.5122,-106.3323
    //[19] Powderhorn: _________ 39.0694,-108.1507
    //[20] Purgatory: __________ 37.6302,-107.8140
    //[21] Silverton: __________ 37.8055,-107.6700
    //[22] Snowmass: ___________ 39.2087,-106.9475
    //[23] Steamboat: __________ 40.4572,-106.8052
    //[24] Sunlight: ___________ 39.3998,-107.3387
    //[25] Telluride: __________ 37.9365,-107.8465
    //[26] Vail: _______________ 39.6426,-106.3880
    //[27] Winter Park: ________ 39.8868,-105.7625
    //[28] Wolf Creek: _________ 37.4721,-106.7935
    
    //Utah
    //[1] Alta: ________________ 40.5908,-111.6288
    //[2] Beaver Mountain: _____ 41.9682,-111.5441
    //[3] Brian Head: __________ 37.6926,-112.8476
    //[4] Brighton: ____________ 40.5983,-111.5837
    //[5] Cherry Peak: _________ 41.9264,-111.7567
    //[6] Deer Valley: _________ 40.6373,-111.4782
    //[7] Eagle Point: _________ 38.3203,-112.3838
    //[8] Nordic Valley: _______ 41.3103,-111.8649
    //[9] Park City: ___________ 40.6513,-111.5078
    //[10] Powder Mountain: ____ 41.3788,-111.7808
    //[11] Snowbasin: __________ 41.2160,-111.8568
    //[12] Snowbird: ___________ 40.5810,-111.6567
    //[13] Solitude: ___________ 40.6200,-111.5913
    //[14] Sundance: ___________ 40.3912,-111.5778
    
    let resortCoordinates = ["39.6424,-105.8723", "39.1816,-106.8561", "39.1765,-106.8206", "39.6040,-106.5180", "39.4811,-106.0674", "39.1916,-106.8667", "38.8998,-106.9650", "39.3601,-106.3009", "39.5005,-106.1552", "39.6847,-105.5193", "39.9382,-105.5843", "40.0446,-105.9063", "37.2991,-108.0549", "40.4828,-106.8390", "37.7933,-107.6289", "39.5729,-105.9463", "39.6807,-105.8972", "38.5122,-106.3323", "39.0694,-108.1507", "37.6302,-107.8140", "37.8055,-107.6700", "39.2087,-106.9475", "40.4572,-106.8052", "39.3998,-107.3387", "37.9365,-107.8465", "39.6426,-106.3880", "39.8868,-105.7625", "37.4721,-106.7935", "40.5908,-111.6288", "41.9682,-111.5441", "37.6926,-112.8476", "40.5983,-111.5837", "41.9264,-111.7567", "40.6373,-111.4782", "38.3203,-112.3838", "41.3103,-111.8649", "40.6513,-111.5078", "41.3788,-111.7808", "41.2160,-111.8568", "40.5810,-111.6567", "40.6200,-111.5913", "40.3912,-111.5778"]
    
    //.count = 42
    let resortLatitude = [39.6424, 39.1819, 39.1814, 39.6040, 39.4811, 39.1916, 38.8998, 39.3601, 39.5005, 39.6847, 39.9382, 40.0446, 37.2991, 40.4828, 37.7933, 39.5729, 39.6807, 38.5122, 39.0694, 37.6302, 37.8055, 39.2087, 40.4572, 39.3998, 37.9365, 39.6426, 39.8868, 37.4721, 40.5908, 41.9682, 37.6926, 40.5983, 41.9264, 40.6460, 38.3203, 41.3103, 40.6513, 41.3788, 41.2160, 40.5810, 40.6200, 40.3912]
    
    //.count = 42
    let resortLongitude = [-105.8723, -106.8563, -106.8558, -106.5180, -106.0674, -105.9063, -106.9650, -106.3009, -106.1552, -105.5193, -105.5843, -105.9063, -108.0549, -106.8390, -107.6289, -105.9463, -105.8972, -106.3323, -108.1507, -107.8140, -107.6700, -106.9475, -106.8052, -107.3387, -107.8465, -106.3880, -105.7625, -106.7935, -111.6288, -111.5441, -112.8476, -111.5837, -111.7567, -111.4974, -112.3838, -111.8649, -111.5078, -111.7808, -111.8568, -111.6567, -111.5913, -111.5778]
    
    //.count = 42
    let resortWebsites = ["https://www.arapahoebasin.com/", "https://www.aspensnowmass.com/our-mountains/aspen-highlands", "https://www.aspensnowmass.com/our-mountains/aspen-mountain", "https://www.beavercreek.com/", "https://www.breckenridge.com/", "https://www.aspensnowmass.com/our-mountains/buttermilk", "https://www.skicb.com/", "https://www.skicooper.com/", "https://www.coppercolorado.com/", "https://echomntn.com/", "https://www.eldora.com/", "https://www.granbyranch.com/", "https://www.ski-hesperus.com/", "https://steamboatsprings.net/131/Howelsen-Hill-Ski-Area", "https://www.skikendall.com/", "https://www.keystoneresort.com/", "https://skiloveland.com/", "https://www.skimonarch.com/", "https://www.powderhorn.com/", "https://www.purgatoryresort.com/", "https://silvertonmountain.com/", "https://www.aspensnowmass.com/our-mountains/snowmass", "https://www.steamboat.com/", "https://www.sunlightmtn.com/", "https://www.tellurideskiresort.com/", "https://www.vail.com/", "https://www.winterparkresort.com/", "https://wolfcreekski.com/", "https://www.alta.com/", "http://www.skithebeav.com/", "https://www.brianhead.com/", "https://brightonresort.com/", "http://www.skicherrypeak.com/", "https://www.deervalley.com/", "https://www.eaglepointresort.com/", "https://www.nordicvalley.ski/", "https://www.parkcitymountain.com/", "https://www.powdermountain.com/", "https://www.snowbasin.com/", "https://www.snowbird.com/", "https://www.solitudemountain.com/", "https://www.sundanceresort.com/"]
    
    //.count = 42
    let resortWebsiteNames = ["arapahoebasin.com", "aspensnowmass.com", "aspensnowmass.com", "beavercreek.snow.com", "breckenridge.com", "aspensnowmass.com", "skicb.com", "skicooper.com", "coppercolorado.com", "echomntn.com", "eldora.com", "granbyranch.com", "ski-hesperus.com", "steamboatsprings.net", "skikendall.com", "keystoneresort.com", "skiloveland.com", "skimonarch.com", "powderhorn.com", "purgatoryresort.com", "silvertonmountain.com", "aspensnowmass.com", "steamboat.com", "sunlightmtn.com", "tellurideskiresort.com", "vail.com", "winterparkresort.com", "wolfcreekski.com", "alta.com", "skithebeav.com", "brianhead.com", "brightonresort.com", "skicherrypeak.com", "deervalley.com", "eaglepointresort.com", "nordicvalley.ski", "parkcitymountain.com", "powdermountain.com", "snowbasin.com", "snowbird.com", "solitudemountain.com", "sundanceresort.com"]
    
    //.count = 42
    let resortTopElevation = ["13,050", "11,675", "11,211", "11,440", "9,900", "12,998", "12,162", "11,700", "12,441", "10,650", "10,600", "9,202", "8,888", "7,136", "9,596", "12,408", "11,250", "11,960", "9,850", "10,822", "13,487", "12,510", "10,568", "9,895", "13,150", "11,570", "12,060", "11,904", "11,068", "8,800", "10,920", "10,750", "7,050", "9,570", "10,600", "6,400", "10,026", "9,422", "9,350", "11,000", "10,488", "8,250"]
    
    //.count = 42
    let resortSkiableAcres = ["1,428", "1,010", "675", "1,815", "2,908", "470", "1,547", "470", "2,490", "226", "680", "406", "60", "50", "16", "3,148", "1,800", "800", "1,600", "1,200", "1,819", "3,362", "2,965", "680", "2,000", "5,289", "3,081", "1,600", "2,614", "828", "665", "1,050", "200", "2,026", "650", "120", "7,300", "8,464", "3,000", "2,500", "1,200", "450"]
    
    //.count = 42
    let resortNumberOfTrails = ["147", "144", "76", "44", "187", "149", "121", "60", "140", "13", "53", "38", "26", "17", "4", "128", "94", "63", "63", "85", "-", "94", "165", "67", "148", "195", "166", "77", "116", "48", "71", "66", "29", "103", "40", "22", "324", "154", "104", "169", "80", "44"]
    
    //.count = 42
    let resortMapURL = ["https://maps.apple.com/?address=28194%20US-6,%20Dillon,%20CO%20%2080435,%20United%20States&auid=17930045844284892627&ll=39.642444,-105.872334&lsp=9902&q=Arapahoe%20Basin%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKSCnnrsT0kNAMfz48NEHeFrAOVBeGnVj0kNAQWY/nNGgd1rA", "https://maps.apple.com/?address=133%20Prospector%20Rd,%20Aspen,%20CO%20%2081611,%20United%20States&auid=15523250044386032123&ll=39.181662,-106.856112&lsp=9902&q=Aspen%20Highlands%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARImKTj/ZZ6tlkNAMbQZ83wit1rAObbUi/rTl0NAQfb6R51ktlrAUAM%3D", "https://maps.apple.com/?address=Aspen,%20CO%20%2081611,%20United%20States&auid=10776764610732192148&ll=39.176517,-106.820640&lsp=9902&q=Aspen%20Mountain%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKfpYcKp6lkNAMQEN0FqYtFrAOUYdq4m1lkNAQe2p/WFytFrA", "https://maps.apple.com/?address=26%20Avondale%20Lane,%20Avon,%20CO%20%2081620,%20United%20States&auid=11840150957914424945&ll=39.604043,-106.518057&lsp=9902&q=Beaver%20Creek%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKVMdF3ppyENAMVN0yd0MpFrAOXOv3YfN0ENAQeM48Gq5n1rA", "https://maps.apple.com/?address=Breckenridge%20Ski%20Area,%201521%20Ski%20Hill%20Rd,%20Breckenridge,%20CO%20%2080424,%20United%20States&auid=14384924602206452457&ll=39.481191,-106.067489&lsp=9902&q=Breckenridge%20Ski%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKfyu8kIOskNAMS2i2L7Ji1rAObWGPkUdyUNAQdNdJ7rZfFrA", "https://maps.apple.com/?address=789%20W%20Buttermilk%20Rd,%20Aspen,%20CO%20%2081611,%20United%20States&auid=8340777063690607850&ll=39.191685,-106.866798&lsp=9902&q=Buttermilk%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARImKazkLj4UmkNAMUg0ExLqt1rAOSq6VJo6m0NAQbbZBSAst1rAUAQ%3D", "https://maps.apple.com/?address=11%20Snowmass%20Rd,%20Crested%20Butte,%20CO%20%2081224,%20United%20States&auid=10443168274147923470&ll=38.899865,-106.965075&lsp=9902&q=Crested%20Butte%20Mountain%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKf3TsktbckNAMe6v5W5CvlrAOXup2KeBc0NAQYihDlKFvVrAUAM%3D", "https://maps.apple.com/?address=232%20County%20Road%2029,%20Leadville,%20CO%2080461,%20United%20States&auid=13611431166808232697&ll=39.360134,-106.300997&lsp=9902&q=Ski%20Cooper&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKadcNmSPokNAMUjBF0K4mlrAOS8m0oWeuUNAQbc+6MvOi1rA", "https://maps.apple.com/?address=209%20Ten%20Mile%20Cir,%20Frisco,%20CO%20%2080443,%20United%20States&auid=12940215330800421913&ll=39.500564,-106.155208&lsp=9902&q=Copper%20Mountain&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhCxAQoECAoQARIkKUruNxGJtENAMX5cn3VnkVrAOa9ugA6Yy0NAQYGjYGN2glrA", "https://maps.apple.com/?address=19285%20Hwy%20103,%20Idaho%20Springs,%20CO%2080452,%20United%20States&auid=8808330294066581198&ll=39.684739,-105.519379&lsp=9902&q=Echo%20Mountain&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKbR4DNsM10NAMV+AX92cYVrAOTJOMjcz2ENAQcfgkJ3dYFrAUAM%3D", "https://maps.apple.com/?address=2861%20Eldora%20Ski%20Rd,%20Nederland,%20CO%20%2080466,%20United%20States&auid=13267837229461177257&ll=39.938254,-105.584396&lsp=9902&q=Eldora&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKeK31zhR90NAMTvYrETqZVrAOcq3LY+J+ENAQYTELGrmZFrAUAM%3D", "https://maps.apple.com/?address=1000%20Village%20Rd,%20Granby,%20CO%20%2080446,%20United%20States&auid=2422394720561744730&ll=40.044688,-105.906317&lsp=9902&q=Granby%20Ranch&_ext=ChkKBQgEEOIBCgQIBRADCgQIBhB8CgQIChAAEiYpm1ZlKyUFREAxO16/OWF6WsA5GSyLh0sGREBBTQlK+KB5WsBQAw%3D%3D", "https://maps.apple.com/?address=9848%20Highway%20160,%20Hesperus,%20CO%20%2081326,%20United%20States&auid=3591562302719686704&ll=37.299183,-108.054925&lsp=9902&q=Hesperus%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKSUUbG0rpUJAMejpe5+GBVvAOehHDcY3qUJAQZj4o6izAlvA", "https://maps.apple.com/?address=Steamboat%20Springs,%20CO%20%2080487,%20United%20States&auid=6045323679469540188&ll=40.482800,-106.839000&lsp=9902&q=Howelsen%20Hill%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKfreU/SuPURAMTrYx4bFtVrAOUajjtPpPURAQc7TVNOetVrA", "https://maps.apple.com/?address=CO%20%2081433,%20United%20States&auid=11140035244543242354&ll=37.793330,-107.628950&lsp=9902&q=Kendall%20Mountain&_ext=ChkKBQgEEOIBCgQIBRADCgQIBhASCgQIChAAEiQp1hMgam7lQkAxDljVVVPoWsA5IthaSanlQkBBehLQFS7oWsA%3D", "https://maps.apple.com/?address=Dillon,%20CO%20%2080435,%20United%20States&auid=15920760383320690622&ll=39.572939,-105.946362&lsp=9902&q=Keystone%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKS++0aA4yUNAMccm9kqkfFrAOXuCDIBzyUNAQYdPyRp+fFrA", "https://maps.apple.com/?address=Interstate%2070,%20Georgetown,%20CO%2080444,%20United%20States&auid=9883301906943460316&ll=39.680784,-105.897214&lsp=9902&q=Loveland%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARImKX0xpTCb1kNAMb95oOrIeVrAOfsGy4zB10NAQfNuR60JeVrAUAM%3D", "https://maps.apple.com/?address=23715%20US%20Highway%2050,%20Salida,%20CO%20%2081201,%20United%20States&auid=16962929702259592312&ll=38.512231,-106.332346&lsp=9902&q=Monarch%20Mountain&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKXbRrDPxQENAMaqUkLOnlVrAOcPDojiuQUNAQVIlwlkylVrA", "https://maps.apple.com/?address=48338%20Powderhorn%20Rd,%20Mesa,%20CO%2081643,%20United%20States&auid=1446024478586379726&ll=39.069436,-108.150712&lsp=9902&q=Powderhorn%20Mountain%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKc6xcg9aiENAMZV7Y9IgClvAOUyHmGuAiUNAQUtc5T9jCVvA", "https://maps.apple.com/?address=1%20Skier%20Pl,%20Durango,%20CO%20%2081301,%20United%20States&auid=18287222386444228075&ll=37.630224,-107.814009&lsp=9902&q=Purgatory%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKarDG9Qq0EJAMX/LFDl29FrAOSiZQTBR0UJAQeUzcmG881rAUAM%3D", "https://maps.apple.com/?address=Greene%20St,%20Silverton,%20CO%20%2081433,%20United%20States&ll=37.805511,-107.670040&q=Greene%20St&_ext=EiYpu90fyofmQkAxOAmlEz/rWsA5ObNFJq7nQkBBQM6ty4TqWsBQBA%3D%3D", "https://maps.apple.com/?address=Aspen,%20CO%20%2081611,%20United%20States&auid=16169147531516231841&ll=39.208768,-106.947570&lsp=9902&q=Snowmass%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARImKVA7V+AhmkNAMYwt+4oFvVrAOc4QfTxIm0NAQe4TpJhHvFrAUAQ%3D", "https://maps.apple.com/?address=2305%20Mount%20Werner%20Cir,%20Steamboat%20Springs,%20CO%20%2080487,%20United%20States&auid=10047544661253797836&ll=40.457258,-106.805241&lsp=9902&q=Steamboat%20Ski%20%26%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKXZF5HP+LkRAMb3wukAcu1rAOZgJ5XgMRkRAQUIPReP1q1rA", "https://maps.apple.com/?address=10901%20County%20Road%20117,%20Glenwood%20Springs,%20CO%20%2081601,%20United%20States&auid=4525627071790288677&ll=39.399860,-107.338775&lsp=9902&q=Sunlight%20Mountain%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKSiaYlqRs0NAMfQGYwe31lrAOaZviLa3tENAQdxbxor41VrAUAM%3D", "https://maps.apple.com/?address=560%20Mountain%20Village%20Blvd,%20Telluride,%20CO%20%2081435,%20United%20States&auid=6372208114941472201&ll=37.936568,-107.846512&lsp=9902&q=Telluride%20Ski%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKfk5T3dK90JAMYKMUdyS9lrAOXcPddNw+EJAQVpAhj/Y9VrAUAQ%3D", "https://maps.apple.com/?address=Vail,%20Vail,%20CO%20%2081657,%20United%20States&auid=1708937740619247130&ll=39.642636,-106.388056&lsp=9902&q=Vail%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKS8wBYu4xkNAMQC/ClFSoFrAOV1LhWPH3UNAQf9A9X1ZkVrA", "https://maps.apple.com/?address=85%20Parsenn%20Rd,%20Parshall,%20CO%2080482,%20United%20States&auid=16574858164367803985&ll=39.886825,-105.762514&lsp=9902&q=Winter%20Park%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARImKc42klDw8ENAMR2gfe8scVrAOUwMuKwW8kNAQeG+jB9tcFrAUAQ%3D", "https://maps.apple.com/?address=U.S.%20160,%20Pagosa%20Springs,%20CO%2081147,%20United%20States&auid=12378013919086695971&ll=37.472116,-106.793504&lsp=9902&q=Wolf%20Creek%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKYW9AQTksEJAMYo+EtoMulrAOU82agr1x0JAQXPB7a2Eq1rA", "https://maps.apple.com/?address=10484%20E%20Little%20Cottonwood,%20Salt%20Lake%20City,%20UT%2084121,%20United%20States&auid=13508687140801481306&ll=40.590818,-111.628819&lsp=9902&q=Alta%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARImKU+E/5fSSkRAMdMQvpWb6VvAOc1ZJfT4S0RAQfeD4cXZ6FvAUAQ%3D", "https://maps.apple.com/?address=UT-243,%20Logan,%20UT%2084321,%20United%20States&auid=1390926821370430140&ll=41.968143,-111.541461&lsp=9902&q=Beaver%20Mountain%20Ski%20Area&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKZmKQ91Y+0RAMdGnGB0K41vAORdgaTl//ERAQWdInClE4lvAUAQ%3D", "https://maps.apple.com/?address=329%20S%20Highway%20143,%20Brian%20Head,%20UT%2084719,%20United%20States&auid=13016882788013584227&ll=37.692659,-112.847643&lsp=9902&q=Brian%20Head%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKYyqkN4ezUJAMWPeUlKJPVzAOa/iuKwv5EJAQZwhQUD2LlzA", "https://maps.apple.com/?address=8302%20S%20Brighton%20Loop%20Rd,%20Brighton,%20UT%20%2084121,%20United%20States&auid=3499917518695055082&ll=40.598305,-111.583714&lsp=9902&q=Brighton%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKW5AOitYSkRAMQvrxruj5lvAOVeVfVcETURAQXiazHjb41vA", "https://maps.apple.com/?address=Wasatch-Cache%20National%20Forest,%20E%2011000%20N,%20Logan,%20UT%2084321,%20United%20States&auid=3644558029035784220&ll=41.926435,-111.756763&lsp=9902&q=Cherry%20Peak%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKYib+A+O9URAMX9MMY3S8FvAOeZufJLg90RAQWMd2Dvt71vAUAM%3D", "https://maps.apple.com/?address=2250%20Deer%20Valley%20Dr%20S,%20Park%20City,%20UT%2084060,%20United%20States&auid=398553415224470547&ll=40.637343,-111.478204&lsp=9902&q=Deer%20%20Valley%20Ski%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKR3zD40LRkRAMdn6sj4z5lvAOdqqL2MZXURAQSYFzY4C11vA", "https://maps.apple.com/?address=150%20W%20Village%20Dr,%20Beaver,%20UT%20%2084713,%20United%20States&auid=18265396636734439553&ll=38.320330,-112.383823&lsp=9902&q=Eagle%20Point&_ext=ChkKBQgEEOIBCgQIBRADCgQIBhALCgQIChAAEiYp3bHYF2soQ0Ax+mt9y+4YXMA5W4f+c5EpQ0BBWh3aMjMYXMBQAw%3D%3D", "https://maps.apple.com/?address=3567%20Nordic%20Valley%20Way,%20Eden,%20UT%20%2084310,%20United%20States&auid=16401143806477562144&ll=41.310356,-111.864949&lsp=9902&q=Nordic%20Valley&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABImKbYeRcgspkRAMaCXzk1o91vAOTT0aiRTp0RAQShyzmKk9lvAUAQ%3D", "https://maps.apple.com/?address=1345%20Lowell%20Ave,%20Park%20City,%20UT%20%2084060,%20United%20States&auid=11099391919501335499&ll=40.651390,-111.507835&lsp=9902&q=Park%20City%20Mountain%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKUMPa+D9TURAMQoNafmm5lvAOebuzjUnWURAQRbfUPjs31vA", "https://maps.apple.com/?address=Powder%20Mountain%20Ski%20Area,%206965%20Powder%20Mountain%20Rd,%20Logan,%20UT%2084310,%20United%20States&auid=17865118238507739704&ll=41.378829,-111.780878&lsp=9902&q=Powder%20Mountain%20Winter%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKTYq6+T0pERAMaGzdAGo+VvAOS+3nPkBvERAQWBMi9BL6lvA", "https://maps.apple.com/?address=3925%20SR-226,%20Ogden,%20UT%20%2084317,%20United%20States&auid=10851509147299430841&ll=41.216056,-111.856892&lsp=9902&q=Snowbasin%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKYIwuw0fkERAMYvFEJKA/lvAOduS8Ewsp0RAQXM67xEu71vA", "https://maps.apple.com/?address=9385%20S%20Snowbird%20Center%20Dr,%20Snowbird,%20UT%2084092,%20United%20States&auid=7334230097116659462&ll=40.581017,-111.656778&lsp=9902&q=Snowbird&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARIkKaSHA9HVPkRAMfT0aF+f8VvAOVoPzrXjVURAQQwLl+xx4lvA", "https://maps.apple.com/?address=12000%20E%20Big%20Cottonwood%20Canyon%20Rd,%20Solitude,%20UT%2084121,%20United%20States&auid=1262676710455468072&ll=40.620034,-111.591373&lsp=9902&q=Solitude%20Mountain%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQABIkKeU7j17UQ0RAMQozZOVw7VvAObXjMDniWkRAQfacgzRB3lvA", "https://maps.apple.com/?address=8841%20Alpine%20Loop%20Rd,%20Provo,%20UT%20%2084604-5538,%20United%20States&auid=1649870217694871170&ll=40.391277,-111.577889&lsp=9902&q=Sundance%20Mountain%20Resort&_ext=ChoKBQgEEOIBCgQIBRADCgUIBhDcAQoECAoQARImKZs+loqDMURAMStqdRJd5VvAORkUvOapMkRAQYugkdSb5FvAUAQ%3D"]
    
    //.count = 42
    let resortAddress = ["28194 US-6 Dillon, CO 80435", "75 Boomerang Road Aspen, CO 81611", "133 Prospector Road Aspen, CO 81611", "26 Avondale Lane Avon, CO 81620", "1521 Ski Hill Road Breckenridge, CO 80424", "38700 CO-82 Aspen, CO 81611", "11 Snowmass Road Crested Butte, CO 81224", "232 County Road 29 Leadville, CO 80461", "209 Ten Mile Circle Frisco, CO 80443", "19285 Highway 103 Idaho Springs, CO 80452", "2861 Eldora Ski Road Nederland, CO 80466", "1000 Village Road Granby, CO 80446", "9848 Highway 160 Hesperus, CO 81326", "245 Howelsen Parkway Steamboat Springs, CO 80477", "1 Kendall Place Silverton, CO 81433","Dillon, CO 80435", "I-70 Dillon, CO 80435", "23715 US-50 Salida, CO 81201", "48338 Powderhorn Rd Mesa, CO 81643", "1 Skier Pl Durango, CO 81301", "6226 State Hwy 110 Silverton, CO 81433", "120 Lower Carriage Way Snowmass Village, CO 81615", "2305 Mt Werner Cir Steamboat Springs, CO 80487", "10901 Co Rd 117 Glenwood Springs, CO 81601", "565 Mountain Village Blvd Telluride, CO 81435", "P.O. Box 7 Vail, CO 81658", "85 Parsenn RoadWinter Park, CO 80482", "US-160 Pagosa Springs, CO 81147", "Highway 210 Alta, UT 84092", "40000 East Highway 89 Garden City, UT 84028", "329 UT-143 Brian Head, UT 84719", "8302 S Brighton Loop Rd Brighton, UT 84121", "3200 E 11000 N Richmond, UT 84333", "2250 Deer Valley Dr S, Park City, UT 84060", "150 S W Village Cir Beaver, UT 84713", "3567 Nordic Valley Way Eden, UT 84310", "1345 Lowell Ave Park City, UT 84060", "6965 E Powder Mountain Rd Eden, UT 84310", "3925 Snow Basin Rd Huntsville, UT 84317", "9385 S Snowbird Center Dr Snowbird, UT 84092", "12000 Big Cottonwood Canyon Rd Solitude, UT 84121", "8841 N Alpine Loop Rd Sundance, UT 84604"]
    
    //.count = 42
    let resortPhoneNumber = ["(970) 468-0718", "(970) 923-1227", "(970) 923-1227", "(970) 923-1227", "(800) 789-7669", "(970) 754-4636", "(877) 547-5143", "(719) 486-2277", "(866) 841-2481", "(720) 899-2100", "(303) 440-8700", "(888) 850-4615", "(970) 385-2199", "(970) 879-8499", "(970) 387-5522", "(970) 754-0001", "(800) 736-3754", "(719) 530-5000", "(970) 268-5355", "(970) 247-9000", "(970) 387-5706", "(970) 923-1227", "(970) 879-6111", "(970) 945-7491", "(800) 778-8581", "(970) 754-8245", "(970) 726-1564", "(970) 264-5639", "(801) 572-3939", "(435) 946-3610", "(435) 677-2035", "(801) 532-4731", "(435) 200-5050", "(435) 649-1000", "(435) 438-3700", "(801) 745-3511", "(435) 649-8111", "(801) 745-3772", "(801) 620-1000", "(801) 933-2222", "(801) 534-1400", "(801) 225-4107"]
    
    //.count =
//    let resortEmail = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    
    
    
    func createAllResorts() -> [Resort] {
        var resorts: [Resort] = []
        for (index, resortName) in resortNames.enumerated() {
            let location = resortLocations[index]
            let state = resortStates[index]
            let coordinates = resortCoordinates[index]
//            let latitude = resortLatitude[index]
//            let longitude = resortLongitude[index]
            let website = resortWebsites[index]
            let websiteFormat = resortWebsiteNames[index]
            let elevation = resortTopElevation[index]
            let skiableAcres = resortSkiableAcres[index]
            let numberOfTrails = resortNumberOfTrails[index]
            let address = resortAddress[index]
            let number = resortPhoneNumber[index]
            let mapURL = resortMapURL[index]
            let resort = Resort(name: resortName, location: location, state: state, coordinates: coordinates, elevation: elevation, acres: skiableAcres, trails: numberOfTrails, address: address, phoneNumber: number, website: website, websiteNameFormat: websiteFormat, mapURL: mapURL)
            resorts.append(resort)
        }
        return resorts
    }
    
//    func coordinates() {
//        let latitude = resortLatitude.compactMap(Double.init)
//        let longitude = resortLongitude.compactMap(Double.init)
//    }
    
    func fetchTemperature(with coordinates: String, units: String, language: String, format: String, apiKey: String, completion: @escaping (Temperature?) -> Void) {
        
        //1. Construct the proper URL/URLRequest
        guard let baseURL = baseURL?.appendingPathComponent("current"),
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { completion(nil) ; return }
        
        let querySearchTermItem = URLQueryItem(name: "geocode", value: coordinates)
        let queryUnits = URLQueryItem(name: "units", value: units)
        let queryLanguage = URLQueryItem(name: "language", value: language)
        let queryFormat = URLQueryItem(name: "format", value: format)
        let queryApiKey = URLQueryItem(name: "apiKey", value: apiKey)
        components.queryItems = [querySearchTermItem, queryUnits, queryLanguage, queryFormat, queryApiKey]
        guard let finalURL = components.url else { completion(nil) ; return }
        print(finalURL.absoluteString)
        
        //2. Call the DataTask - Don't forget to decode and .resume()
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            print("The Data Task just got back with some data")
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function) ❌")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            
            do {
                let temperature = try JSONDecoder().decode(Temperature.self, from: data)
                completion(temperature)
                print(temperature)
            
            } catch {
                print("\(error.localizedDescription) \(error) in function: \(#function) ❌")
                completion(nil)
                return
            }
        } .resume()
    }
    
//    func filterResorts() {
//        let filterByState = resortStates.filter { "" }
//    }
}

