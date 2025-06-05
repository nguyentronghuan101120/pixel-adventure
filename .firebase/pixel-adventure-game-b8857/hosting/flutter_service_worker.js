'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "5a1324d56888d4c3c80e622e9c148922",
"version.json": "8722153f1b3ecfe9d8b05eeedcf2228e",
"index.html": "04df8283b5571d1c76df208aada1f9fb",
"/": "04df8283b5571d1c76df208aada1f9fb",
"main.dart.js": "52a26e56f3e70430558c1e42161bfb35",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "078b4b083f3c0fcbcc148db10643643d",
"icons/favicon-16x16.png": "078b4b083f3c0fcbcc148db10643643d",
"icons/favicon.ico": "28e089bfa3adfcdc2529037770537f11",
"icons/apple-icon.png": "8e47c5751b4b96cb03bd2e3ffb16e50f",
"icons/apple-icon-144x144.png": "2b7824124b5dfe62a6ce5e7b13df19df",
"icons/android-icon-192x192.png": "3923907d122e9d04bf95c5286f132a08",
"icons/apple-icon-precomposed.png": "8e47c5751b4b96cb03bd2e3ffb16e50f",
"icons/apple-icon-114x114.png": "7d0f559c1b073e756f543622b6272622",
"icons/ms-icon-310x310.png": "e40bb7ee815eabc71112fbb984b5683d",
"icons/ms-icon-144x144.png": "2b7824124b5dfe62a6ce5e7b13df19df",
"icons/apple-icon-57x57.png": "bb031e489a160320ba4780209aca2ccd",
"icons/apple-icon-152x152.png": "489e97b0a9e1476b9419dad7505b27ae",
"icons/ms-icon-150x150.png": "a8b29d7b31d312e1e05e0769099a8be0",
"icons/android-icon-72x72.png": "6ab1a40106d6ecce1dcb3f871e1ec6d1",
"icons/android-icon-96x96.png": "c21d43b8b56d94daacc1efb46bcfc5ac",
"icons/android-icon-36x36.png": "6854999ea651481ccad8d8b69f331537",
"icons/apple-icon-180x180.png": "7ab44114a9cd9278683ff0bb65e593df",
"icons/favicon-96x96.png": "c21d43b8b56d94daacc1efb46bcfc5ac",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/android-icon-48x48.png": "141bef8b8d8c3b48111f36b5245249bd",
"icons/apple-icon-76x76.png": "1475aa0f77034339966258794ca8809a",
"icons/apple-icon-60x60.png": "491b7a7897fb0d0f8cd4f2a407a7d498",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/android-icon-144x144.png": "2b7824124b5dfe62a6ce5e7b13df19df",
"icons/apple-icon-72x72.png": "6ab1a40106d6ecce1dcb3f871e1ec6d1",
"icons/apple-icon-120x120.png": "82e3fb0913076215ca2f6b821dab2487",
"icons/favicon-32x32.png": "5d539c0fcc3e2eab975507e003a12871",
"icons/ms-icon-70x70.png": "6640a011d792128d30f0ebf9825c2678",
"manifest.json": "b08f4ea1819f780baa8cd3841958ca0a",
"assets/AssetManifest.json": "284b250733f1beb6b0098902232bec1a",
"assets/NOTICES": "d326270a1a35db67b7af4e63b78f9a3f",
"assets/FontManifest.json": "445e11affb5aaa3dd6652e81abde29fd",
"assets/AssetManifest.bin.json": "0e1d999fdf9f9e0ba81c120ce33a13ba",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "7bf935360a1bf8718129da83187b60e1",
"assets/fonts/MaterialIcons-Regular.otf": "ed15c09b9740c75b7efeb57ce7117e03",
"assets/assets/images/Background/Gray.png": "31fb9bc36ec926ee64d999d3387b7e09",
"assets/assets/images/Background/Yellow.png": "c3f96416e21f366bc0c3635ce5b530d5",
"assets/assets/images/Background/Pink.png": "31b5e360eb9610c58138bb7cfdfb96a1",
"assets/assets/images/Background/Blue.png": "f86e07aab82505fc49710152f83cc385",
"assets/assets/images/Background/Green.png": "e6eeace8a9d516f2e9768e5228e824fb",
"assets/assets/images/Background/Brown.png": "45c9c887fa73b0ade76974de63ab9157",
"assets/assets/images/Background/Purple.png": "f8cc6aa8fd738e6e4db8b6607b7e6c37",
"assets/assets/images/Main%2520Characters/Virtual%2520Guy/Idle%2520(32x32).png": "1cb575929ac10fe13dfafa61d78ba28d",
"assets/assets/images/Main%2520Characters/Virtual%2520Guy/Jump%2520(32x32).png": "f28e95fc98b251913baf3a21d5602381",
"assets/assets/images/Main%2520Characters/Virtual%2520Guy/Fall%2520(32x32).png": "5eb8c32845fad5fcc7794247eb91aed0",
"assets/assets/images/Main%2520Characters/Virtual%2520Guy/Hit%2520(32x32).png": "bbd39134a77e658b0b9b64ded537972c",
"assets/assets/images/Main%2520Characters/Virtual%2520Guy/Run%2520(32x32).png": "016f388a07f71a930fd79a7a806d5da8",
"assets/assets/images/Main%2520Characters/Virtual%2520Guy/Double%2520Jump%2520(32x32).png": "612926916a3e8c5deff2023722c465ac",
"assets/assets/images/Main%2520Characters/Virtual%2520Guy/Wall%2520Jump%2520(32x32).png": "76cbdd4a22d50bd65ac02be8a5eb1547",
"assets/assets/images/Main%2520Characters/Pink%2520Man/Idle%2520(32x32).png": "1b35f85f1241dc1f0597cafbe1eac7f6",
"assets/assets/images/Main%2520Characters/Pink%2520Man/Jump%2520(32x32).png": "cafaf2f48f36c9a6655a37f9c1c47b4a",
"assets/assets/images/Main%2520Characters/Pink%2520Man/Fall%2520(32x32).png": "a20bd61d76132e4301fcfe7aa02ca9ba",
"assets/assets/images/Main%2520Characters/Pink%2520Man/Hit%2520(32x32).png": "5d93268a09fb2959e1755da4ba201f9e",
"assets/assets/images/Main%2520Characters/Pink%2520Man/Run%2520(32x32).png": "25fcce89dfb6673a81d384091c87353d",
"assets/assets/images/Main%2520Characters/Pink%2520Man/Double%2520Jump%2520(32x32).png": "c76baa04d956c9d985c79643d7b2f672",
"assets/assets/images/Main%2520Characters/Pink%2520Man/Wall%2520Jump%2520(32x32).png": "955d352171a2b666ae705b6205856ce1",
"assets/assets/images/Main%2520Characters/Desappearing%2520(96x96).png": "1284313649da02eccc0d3ed6796996a3",
"assets/assets/images/Main%2520Characters/Mask%2520Dude/Idle%2520(32x32).png": "29c95dbb63a9bf44c42821aa0cf49de8",
"assets/assets/images/Main%2520Characters/Mask%2520Dude/Jump%2520(32x32).png": "99da59b514370539951a76ba1fe51821",
"assets/assets/images/Main%2520Characters/Mask%2520Dude/Fall%2520(32x32).png": "469d2d7814fa8258325eb5d305808315",
"assets/assets/images/Main%2520Characters/Mask%2520Dude/Hit%2520(32x32).png": "d03a7bbce7fbda59dd057397f86a8899",
"assets/assets/images/Main%2520Characters/Mask%2520Dude/Run%2520(32x32).png": "b04bbc82dc692516a4b13c0d9d5b9ebd",
"assets/assets/images/Main%2520Characters/Mask%2520Dude/Double%2520Jump%2520(32x32).png": "5afb26aa4240eff1eab105eb3263ab83",
"assets/assets/images/Main%2520Characters/Mask%2520Dude/Wall%2520Jump%2520(32x32).png": "552254b40eac6d10d2c3d779edb92116",
"assets/assets/images/Main%2520Characters/Ninja%2520Frog/Idle%2520(32x32).png": "cb655be6f9354444720c7ce1dbd61dae",
"assets/assets/images/Main%2520Characters/Ninja%2520Frog/Jump%2520(32x32).png": "4f048ccbc783c8eb3824be9651da8a34",
"assets/assets/images/Main%2520Characters/Ninja%2520Frog/Fall%2520(32x32).png": "ef8f3627041b7ae2a1dc76dfc3e419f3",
"assets/assets/images/Main%2520Characters/Ninja%2520Frog/Hit%2520(32x32).png": "4c1ba2bf4e576409abbbd1aacc91d51d",
"assets/assets/images/Main%2520Characters/Ninja%2520Frog/Run%2520(32x32).png": "fb191b4e6ac599286c38e496a700cfd2",
"assets/assets/images/Main%2520Characters/Ninja%2520Frog/Double%2520Jump%2520(32x32).png": "351c1df6eb5ac94209e8e490ab816879",
"assets/assets/images/Main%2520Characters/Ninja%2520Frog/Wall%2520Jump%2520(32x32).png": "37ec0be0f82c3750a07efa558c032ee7",
"assets/assets/images/Main%2520Characters/Appearing%2520(96x96).png": "9449bf1f8d68ac08331aa091d6095e34",
"assets/assets/images/Traps/Saw/Off.png": "66d27386fec46e0b052941957d9bdc22",
"assets/assets/images/Traps/Saw/Chain.png": "69669f8f421b508058cdf1232dc49e28",
"assets/assets/images/Traps/Saw/On%2520(38x38).png": "817477a39df8b330334e3866c1cb574b",
"assets/assets/images/Traps/Rock%2520Head/Blink%2520(42x42).png": "79bec88f1bab85f2d3304eb64c52e6c6",
"assets/assets/images/Traps/Rock%2520Head/Idle.png": "d627e29f18b4c88d698fada937fdb4f0",
"assets/assets/images/Traps/Rock%2520Head/Left%2520Hit%2520(42x42).png": "29e183472fc139814d5245a14b0c2ebd",
"assets/assets/images/Traps/Rock%2520Head/Top%2520Hit%2520(42x42).png": "a7bc34c2035ccb90c16b7693209d03fd",
"assets/assets/images/Traps/Rock%2520Head/Bottom%2520Hit%2520(42x42).png": "a8905ebb8b4ca7775d234e61b70b0e04",
"assets/assets/images/Traps/Rock%2520Head/Right%2520Hit%2520(42x42).png": "c2e11c4f2e75253e649d39f6e0dcb46d",
"assets/assets/images/Traps/Spikes/Idle.png": "64c275b1b14a4c8cd49088ce8ebf0db5",
"assets/assets/images/Hello.png": "a55305158db44491131714a2496e6054",
"assets/assets/images/Menu/Buttons/Levels.png": "5364f08108b6f75ff31b5b7c84f9789a",
"assets/assets/images/Menu/Buttons/Achievements.png": "b9bb58144606336efcd4862d35482f47",
"assets/assets/images/Menu/Buttons/Leaderboard.png": "e3854b8ad5633b1f8017d08b7a783047",
"assets/assets/images/Menu/Buttons/Volume.png": "60060aab64ff40a0a996820f64a308b3",
"assets/assets/images/Menu/Buttons/Settings.png": "a56908d71e428647c51e73af372739ab",
"assets/assets/images/Menu/Buttons/Restart.png": "45fe1343f546485e8e288b122467f2fd",
"assets/assets/images/Menu/Buttons/Next.png": "2f75777c57c36c83c6140bbd7b97a5e1",
"assets/assets/images/Menu/Buttons/Play.png": "23f2b2a41eb467518bbfef795d876dc8",
"assets/assets/images/Menu/Buttons/Previous.png": "c63a3a14721d926b03801f38b81b66a6",
"assets/assets/images/Menu/Buttons/Back.png": "661cfd0fdba294a951eb63c556684a64",
"assets/assets/images/Menu/Buttons/Close.png": "5c3a207383c5642288b01d314855a42a",
"assets/assets/images/Menu/Text/Text%2520(Black)%2520(8x10).png": "33dfcfb4172f57930890a12c80f23201",
"assets/assets/images/Menu/Text/Text%2520(White)%2520(8x10).png": "493235653c61f14237c213dec97a9f2f",
"assets/assets/images/Menu/Levels/48.png": "768351a97acbbd8428ca33b073c7a866",
"assets/assets/images/Menu/Levels/49.png": "e4482f7db83104af60eaf931a8b2b1c1",
"assets/assets/images/Menu/Levels/14.png": "3ebc69f789c0e9dcee5cf8ab5824a11b",
"assets/assets/images/Menu/Levels/28.png": "b4f5454651b31f958f55ba10f2102662",
"assets/assets/images/Menu/Levels/29.png": "617b1485fcef9a94953b0608f6dd4215",
"assets/assets/images/Menu/Levels/01.png": "d7f6549e6809bd7867b8eddd75e6bf21",
"assets/assets/images/Menu/Levels/15.png": "54f287e88233a1920a1eb939d96e3b5b",
"assets/assets/images/Menu/Levels/03.png": "1f9f974b587331877eed69671dd0e4eb",
"assets/assets/images/Menu/Levels/17.png": "286c8805e99d6970b39b38f7be879b1f",
"assets/assets/images/Menu/Levels/16.png": "fad064526892b2616b527a15bf77fe4c",
"assets/assets/images/Menu/Levels/02.png": "08508f40b546910b1402b3112090f91b",
"assets/assets/images/Menu/Levels/06.png": "51a447ce69fcff71e80170c780f9c28f",
"assets/assets/images/Menu/Levels/12.png": "04accdc4c4f1d3d280b68d470534a78f",
"assets/assets/images/Menu/Levels/13.png": "493285cf2283a88931bc4d22bbe8e349",
"assets/assets/images/Menu/Levels/07.png": "c88c31a2ad1ec997f056c337bb14fd69",
"assets/assets/images/Menu/Levels/39.png": "c889d1617a2130f2454ed940eb55e2a6",
"assets/assets/images/Menu/Levels/11.png": "6ff53942f0ce0fcb9a306e580fa97f39",
"assets/assets/images/Menu/Levels/05.png": "616f770983d550594de6dce58cdfd5b8",
"assets/assets/images/Menu/Levels/04.png": "1b53eb9a9fcb93f627f874626999b9eb",
"assets/assets/images/Menu/Levels/10.png": "ce544e6879468566e1b066c7f19d56c2",
"assets/assets/images/Menu/Levels/38.png": "b765f20e7e7a16b59262a0ba5e245a20",
"assets/assets/images/Menu/Levels/35.png": "4ca4713c74ec75f1735473f080cbb1b0",
"assets/assets/images/Menu/Levels/21.png": "00647eca8e6ed0149fb651a55eed68d5",
"assets/assets/images/Menu/Levels/09.png": "baed976d717bd3d06dfee2ea39d78001",
"assets/assets/images/Menu/Levels/08.png": "7cf0a9570d1e462911f42f3b53e050f7",
"assets/assets/images/Menu/Levels/20.png": "84affb6c644a02eeb2ca3289a4478f33",
"assets/assets/images/Menu/Levels/34.png": "4fbd87c9be43814740cb1e07429183c4",
"assets/assets/images/Menu/Levels/22.png": "6ac40e97760aee2267872319a5ac1c06",
"assets/assets/images/Menu/Levels/36.png": "0a3663508994f5a64b59b0fd318f8396",
"assets/assets/images/Menu/Levels/37.png": "dc22ace9201c806fdf9fc9cb438d5175",
"assets/assets/images/Menu/Levels/23.png": "c01e777908fc433e2f7e3d48a1af9ada",
"assets/assets/images/Menu/Levels/27.png": "40265837ef70a977c1acb2efe19b40b1",
"assets/assets/images/Menu/Levels/33.png": "682046f85570a44f0902dbc7583615bf",
"assets/assets/images/Menu/Levels/32.png": "4e1f62217b65790564c3f903b65e4637",
"assets/assets/images/Menu/Levels/26.png": "4c60a5b7b5675434f647d2964402a84f",
"assets/assets/images/Menu/Levels/18.png": "4f675585ad0a1944e9fc80e5e6dcb486",
"assets/assets/images/Menu/Levels/30.png": "b9d3d9c462ea5f310879644dc22b90ca",
"assets/assets/images/Menu/Levels/24.png": "6127aab3b8ff227fa95e49c8facf53d2",
"assets/assets/images/Menu/Levels/25.png": "38f83ad87ce5b9e1033a9808b27232d0",
"assets/assets/images/Menu/Levels/31.png": "7332e2ccf70241eef0d3c837eba8560c",
"assets/assets/images/Menu/Levels/19.png": "c976c40625f767184f1abe468db5f375",
"assets/assets/images/Menu/Levels/42.png": "13b602a32df5aae75a97615edc7c57a9",
"assets/assets/images/Menu/Levels/43.png": "9526f399e906a5b10330d8b3a679a4d7",
"assets/assets/images/Menu/Levels/41.png": "1ec256afdf7de31a869bc88fddff9943",
"assets/assets/images/Menu/Levels/40.png": "332ce8ae0ea6da6ce0dfe0dab7da5496",
"assets/assets/images/Menu/Levels/44.png": "1b9f7f955f3e615a21cf8198a6b8ed35",
"assets/assets/images/Menu/Levels/50.png": "b87c87dec1916d3bee96ce69ec9fbb03",
"assets/assets/images/Menu/Levels/45.png": "d1153f6c9c605634f08a1f5e594e9260",
"assets/assets/images/Menu/Levels/47.png": "30b54134f5a79564400ea90e451d7c18",
"assets/assets/images/Menu/Levels/46.png": "5e1bacd2980de985fe15bc3eac170f11",
"assets/assets/images/Terrain/Terrain%2520(16x16).png": "df891f02449c0565d51e2bf7823a0e38",
"assets/assets/images/Items/Checkpoints/Checkpoint/Checkpoint%2520(No%2520Flag).png": "9126203dc833ec3b7dfb7a05e41910e5",
"assets/assets/images/Items/Checkpoints/Checkpoint/Checkpoint%2520(Flag%2520Idle)(64x64).png": "dd8752c20a0f69ab173f1ead16044462",
"assets/assets/images/Items/Checkpoints/Checkpoint/Checkpoint%2520(Flag%2520Out)%2520(64x64).png": "c4730e5429a75691e2d2a9351c76738e",
"assets/assets/images/Items/Fruits/Collected.png": "0aa8cdedde5af58d5222c2db1e0a96de",
"assets/assets/images/Items/Fruits/Bananas.png": "03466a1dbd95724e705efe17e72c1c4e",
"assets/assets/images/Items/Fruits/Pineapple.png": "0740bf84a38504383c80103d60582217",
"assets/assets/images/Items/Fruits/Cherries.png": "fc2a60aee885c33d0d10e643157213e4",
"assets/assets/images/Items/Fruits/Orange.png": "60e0f68620c442b9403a477bbe3588ed",
"assets/assets/images/Items/Fruits/Apple.png": "de3dbfa7d33e6bb344d0560e36d8bf53",
"assets/assets/images/Items/Fruits/Melon.png": "eb6f978fbf95d76587bcf656c649540b",
"assets/assets/images/Items/Fruits/Strawberry.png": "568a3f91b8f6102f1b518c1aba0e8e09",
"assets/assets/images/Items/Fruits/Kiwi.png": "3d903dd9bf3421c31a5373b0920c876e",
"assets/assets/images/20%2520Enemies.png": "73730ecfde474d999a027b06288751b6",
"assets/assets/images/custom/box1.png": "5fed87ce8c2146ea5ad11bab3b71e1c9",
"assets/assets/images/custom/box3.png": "4d924a235e0ea563c80e72d0a006d9b2",
"assets/assets/images/custom/box2.png": "f01592325d2772626536d28d444b7060",
"assets/assets/images/Enemies/Skull/Red%2520Particle.png": "fd603f22922a768d414b1de8b5fbd0d4",
"assets/assets/images/Enemies/Skull/Idle%25201%2520(52x54).png": "872d23e78ae9fd34510a673a64886a04",
"assets/assets/images/Enemies/Skull/Idle%25202%2520(52x54).png": "c266245d8cf3abe7a052c6f4e4d32527",
"assets/assets/images/Enemies/Skull/Hit%2520Wall%25201%2520(52x54).png": "182c863d04dae298ac20e1a020c10203",
"assets/assets/images/Enemies/Skull/Hit%2520(52x54).png": "52da4fd7869f977042792ead172c6e63",
"assets/assets/images/Enemies/Skull/Hit%2520Wall%25202%2520(52x54).png": "7327ee74b3944662d0f429bc8c9f0557",
"assets/assets/images/Enemies/Skull/Orange%2520Particle.png": "30aa9b8dc71c556e91573845d8ea029e",
"assets/assets/images/Enemies/Radish/Leafs.png": "c3837aabb9f5b565e3cd1e38c6e29915",
"assets/assets/images/Enemies/Radish/Idle%25202%2520(30x38).png": "d54d96d8a428f9ea22c7509217d12cd0",
"assets/assets/images/Enemies/Radish/Idle%25201%2520(30x38).png": "fca6305299182c58f920ddb54a5b7f53",
"assets/assets/images/Enemies/Radish/Hit%2520(30x38).png": "5adc10c5b89f2642a4c10a0da0b1c90b",
"assets/assets/images/Enemies/Radish/Run%2520(30x38).png": "d0d3ff59320e7c9ea44dcead669dddfd",
"assets/assets/images/Enemies/Snail/Shell%2520Wall%2520Hit%2520(38x24).png": "80d9a81c7c3d8d8e5d2cbdc0b28734d7",
"assets/assets/images/Enemies/Snail/Shell%2520Idle%2520(38x24).png": "2bc757a2ee0a293adf050c72ea8dbb19",
"assets/assets/images/Enemies/Snail/Idle%2520(38x24).png": "05e1cbcf2c9c9420ec96ddbfe4a2680f",
"assets/assets/images/Enemies/Snail/Snail%2520without%2520shell.png": "345df192e0ce642e275cb07b97f7e025",
"assets/assets/images/Enemies/Snail/Walk%2520(38x24).png": "793fde1396db7a63a9a5e2e8566237e6",
"assets/assets/images/Enemies/Snail/Hit%2520(38x24).png": "1ed36e32a5ef463bbd8a1e31b824e6cc",
"assets/assets/images/Enemies/Snail/Shell%2520Top%2520Hit%2520(38x24).png": "eddcefae600333acc7862187108cf943",
"assets/assets/images/Enemies/Turtle/Idle%25201%2520(44x26).png": "fa31c3423c2039df86fc53276e8fb93c",
"assets/assets/images/Enemies/Turtle/Spikes%2520out%2520(44x26).png": "38b86e6a34e67c7d90e749cf2d4a0057",
"assets/assets/images/Enemies/Turtle/Idle%25202%2520(44x26).png": "0f16e318c9fbc51488eefec751a1eeb5",
"assets/assets/images/Enemies/Turtle/Spikes%2520in%2520(44x26).png": "7666f68741e022e3a97eec5558841e52",
"assets/assets/images/Enemies/Turtle/Hit%2520(44x26).png": "101ecd12b80ad14dc961a9b78b01d10e",
"assets/assets/images/Enemies/Mushroom/Idle%2520(32x32).png": "58e048ad4afa7199353949f5fa48c134",
"assets/assets/images/Enemies/Mushroom/Hit.png": "6a2f4c95e2d228163548e373a49ef680",
"assets/assets/images/Enemies/Mushroom/Run%2520(32x32).png": "f4455c243603b217cbd950a3d49e62cd",
"assets/assets/images/Enemies/Slime/Hit%2520(44x30).png": "1e8cef3c01446d8f5f520246cb18bf5e",
"assets/assets/images/Enemies/Slime/Particles%2520(62x16).png": "0ea75cbca462433c0165dd710e363081",
"assets/assets/images/Enemies/Slime/Idle-Run%2520(44x30).png": "18c00de4ccc9a5026237c945ff226a4c",
"assets/assets/images/Enemies/Bee/Bullet.png": "863468dcbd22e06ae7c8f312fb18d153",
"assets/assets/images/Enemies/Bee/Hit%2520(36x34).png": "3c0e8d639eff15518bca5b9f7989bdc0",
"assets/assets/images/Enemies/Bee/Idle%2520(36x34).png": "c7d30f26eb55a96699a308eb1fbd0acb",
"assets/assets/images/Enemies/Bee/Bullet%2520Pieces.png": "767967808e69f8d6a3a1f0dae675dce0",
"assets/assets/images/Enemies/Bee/Attack%2520(36x34).png": "d6bd004e2b12a43722c631643877e8bb",
"assets/assets/images/Enemies/Plant/Bullet.png": "1a985c94b3be8edad1ac00fb0699a9d4",
"assets/assets/images/Enemies/Plant/Hit%2520(44x42).png": "efb4028e101d93c8ffa5c981993ecd8a",
"assets/assets/images/Enemies/Plant/Attack%2520(44x42).png": "c9ee7c260dce8622dbdfa9beb159edcf",
"assets/assets/images/Enemies/Plant/Bullet%2520Pieces.png": "3a9fe786da5fd480da45fd9747db93b4",
"assets/assets/images/Enemies/Plant/Idle%2520(44x42).png": "6e660bbbcead5dc8cce7df034036c8c8",
"assets/assets/images/Enemies/FatBird/Idle%2520(40x48).png": "0b6761a02604ce1904ed4f9bfc562dc9",
"assets/assets/images/Enemies/FatBird/Hit%2520(40x48).png": "18992fcbcc089d072ed6f665743abafe",
"assets/assets/images/Enemies/FatBird/Fall%2520(40x48).png": "8532ffe2e5106462bcb56bbdb878ad5a",
"assets/assets/images/Enemies/FatBird/Ground%2520(40x48).png": "0fb9ed85a696c9f7151da9b8cff56764",
"assets/assets/images/Enemies/Chameleon/Run%2520(84x38).png": "26c68c327500fe45d2fe6f6d48c54d2c",
"assets/assets/images/Enemies/Chameleon/Hit%2520(84x38).png": "ef602abaebdbcc47ae142a8ec6111cf7",
"assets/assets/images/Enemies/Chameleon/Attack%2520(84x38).png": "232005d4ed479f6d43a1bc23d5ceebce",
"assets/assets/images/Enemies/Chameleon/Idle%2520(84x38).png": "1ffec858376f730875a949ca482826cc",
"assets/assets/images/Enemies/Duck/Jump%2520(36x36).png": "20b3da5f187d30c5ad3c86247db3fe65",
"assets/assets/images/Enemies/Duck/Idle%2520(36x36).png": "d6cba5a4fd60730f3a12e6d99114e02d",
"assets/assets/images/Enemies/Duck/Fall%2520(36x36).png": "f53849bbbded13f598ae35e66a4fe0a7",
"assets/assets/images/Enemies/Duck/Hit%2520(36x36).png": "36b4a73cd85c6ac5bfd95dfd7c04cd7b",
"assets/assets/images/Enemies/Duck/Jump%2520Anticipation%2520(36x36).png": "29fdd555276124b82c9151f38c03492d",
"assets/assets/images/Enemies/Bunny/Jump.png": "66baaa5c420c81f6bb26839961ab0867",
"assets/assets/images/Enemies/Bunny/Hit%2520(34x44).png": "b0f49c8fc0d4468127826c7ac4378f54",
"assets/assets/images/Enemies/Bunny/Fall.png": "ee19796c76bd2d7e1ed87123458f518f",
"assets/assets/images/Enemies/Bunny/Run%2520(34x44).png": "c4d7e1212b3d337f0be0e6bb476fd288",
"assets/assets/images/Enemies/Bunny/Idle%2520(34x44).png": "5ad6e9c9c31e4679b7147d406371b4d4",
"assets/assets/images/Enemies/Ghost/Gost%2520Particles%2520(48x16).png": "ebc69a624328a2854dd39af7ff8cd9d4",
"assets/assets/images/Enemies/Ghost/Idle%2520(44x30).png": "6545a172dfd2d3bdfe32d8db33822cfe",
"assets/assets/images/Enemies/Ghost/Appear%2520(44x30).png": "7dbcc1b1b6fd12afdd5dc558a5b07a90",
"assets/assets/images/Enemies/Ghost/Hit%2520(44x30).png": "f7b602662245356ef0fdce4240842bfc",
"assets/assets/images/Enemies/Ghost/Desappear%2520(44x30).png": "0c9c842fcf097f1db31e59d39f2fe478",
"assets/assets/images/Enemies/BlueBird/Flying%2520(32x32).png": "96b92c11650df1cb24b18b4dce30dc37",
"assets/assets/images/Enemies/BlueBird/Hit%2520(32x32).png": "d6f11c57b99d6eaa8e3e1c1ba8a01f28",
"assets/assets/images/Enemies/Chicken/Idle%2520(32x34).png": "540724fcaccd692f5d3adb169fa8db2b",
"assets/assets/images/Enemies/Chicken/Run%2520(32x34).png": "58190fdf957eaba5b783bbe2df837c2e",
"assets/assets/images/Enemies/Chicken/Hit%2520(32x34).png": "1a0b324bc2c06c132f6e17d509928a34",
"assets/assets/images/Enemies/Bat/Idle%2520(46x30).png": "33ff43b920fb19d66c2b8ad6164fb2d0",
"assets/assets/images/Enemies/Bat/Ceiling%2520In%2520(46x30).png": "7e10917c9db181457e409d9f1e176647",
"assets/assets/images/Enemies/Bat/Hit%2520(46x30).png": "7eaa7663096d5491a7fd01167a78f577",
"assets/assets/images/Enemies/Bat/Ceiling%2520Out%2520(46x30).png": "25f70ccf6545e1142b2c71f54d231dd8",
"assets/assets/images/Enemies/Bat/Flying%2520(46x30).png": "7986dfad436b4607994d3fe1ecced6ce",
"assets/assets/images/Enemies/Rocks/Rock2_Idle%2520(32x28).png": "7057681c0c21c55f0266d819c8a617c3",
"assets/assets/images/Enemies/Rocks/Rock3_Hit%2520(22x18).png": "3a5a4976cfe664d279d2f81487ee5c90",
"assets/assets/images/Enemies/Rocks/Rock2_Run%2520(32x28).png": "7c2d8c15ed7b4823bc21a464f748d476",
"assets/assets/images/Enemies/Rocks/Rock1_Idle%2520(38x34).png": "e6cb8a2ec957aa6164e3729b8d829e83",
"assets/assets/images/Enemies/Rocks/Rock1_Run%2520(38x34).png": "fc84b09d7ff4fd53da8d86626bca70a6",
"assets/assets/images/Enemies/Rocks/Rock2_Hit%2520(32x28).png": "f052a48054ce5b06217032c72e31d138",
"assets/assets/images/Enemies/Rocks/Rock3_Run%2520(22x18).png": "c5cd938ee706eb7e9b8051076229d36f",
"assets/assets/images/Enemies/Rocks/Rock1_Hit.png": "3e538b96d9d80ba5e4d31056936ebb17",
"assets/assets/images/Enemies/Rocks/Rock3_Idle%2520(22x18).png": "69e6ae3cb950dc31544c7a16cbd48fd8",
"assets/assets/images/Enemies/Rino/Idle%2520(52x34).png": "f7f722ca434152f30908bf8dba89d843",
"assets/assets/images/Enemies/Rino/Hit%2520Wall%2520(52x34).png": "35a772b435d59b7bc71a2b80126c6c84",
"assets/assets/images/Enemies/Rino/Hit%2520(52x34).png": "ad515777809254cd120cef62fb37ac4b",
"assets/assets/images/Enemies/Rino/Run%2520(52x34).png": "ec606d010f9bc60557b58c4ec855524e",
"assets/assets/images/Enemies/AngryPig/Idle%2520(36x30).png": "7c68ecd6f8880776bb4ec3e5879be9a2",
"assets/assets/images/Enemies/AngryPig/Hit%25202%2520(36x30).png": "551e92922393af72d2dcb0acb7b34141",
"assets/assets/images/Enemies/AngryPig/Hit%25201%2520(36x30).png": "bb60d5ed56661d74486bd0e9a52895a2",
"assets/assets/images/Enemies/AngryPig/Walk%2520(36x30).png": "ce06f2c96e2ac0c6cd14e854a870e3e8",
"assets/assets/images/Enemies/AngryPig/Run%2520(36x30).png": "a69cd13d8345e6906c400416553f6042",
"assets/assets/images/Enemies/Trunk/Bullet.png": "4ee6624c19514d734351978ad50bcfdc",
"assets/assets/images/Enemies/Trunk/Attack%2520(64x32).png": "f60bc0c750357fbdace60ffe687ed9fb",
"assets/assets/images/Enemies/Trunk/Idle%2520(64x32).png": "9e4f5a2fe3ce00d4ad64859845a7ef0a",
"assets/assets/images/Enemies/Trunk/Bullet%2520Pieces.png": "a74632012dcebb913c092bb492628d90",
"assets/assets/images/Enemies/Trunk/Run%2520(64x32).png": "4b6173eb09f0816c898e5a73edbd020f",
"assets/assets/images/Enemies/Trunk/Hit%2520(64x32).png": "30b82b960f33a1b8be30c1a2a70c68fe",
"assets/assets/images/hud/jump_button.png": "57aeb7625da4804b14f1d72c025b6c2d",
"assets/assets/tiles/Pixel%2520Adventure.tsx": "00cd71dc13de6af4fc0ceb560889d8b3",
"assets/assets/tiles/Boxes.tsx": "44f420fb7417d528a9b0b2e842c3ec97",
"assets/assets/tiles/level_01.tmx": "afaf5214020b57941ace41a0f99f7d3e",
"assets/assets/tiles/Idle.tsx": "d61a34a57aaddbdb991fc48971726f4f",
"assets/assets/tiles/level2.tmx": "0e40eb0aa9fb7d38de21f16728703207",
"assets/assets/tiles/level3.tmx": "4ebe45947e0edfa745183010c6477ae2",
"assets/assets/tiles/level1.tmx": "7ad218910fe54fa27b01ff0f681ae8fb",
"assets/assets/tiles/untitled.tiled-session": "d56758fa3a8b7228d76ff446268fb561",
"assets/assets/tiles/untitled.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/traps.tsx": "b78578a260fb60a8342a3ebbcbdc24c5",
"assets/assets/audio/jump.wav": "c8ccf78e4d753a69c46e82f7729756f9",
"assets/assets/audio/complete.wav": "ac0271ffe78d9877dbc683975065ff02",
"assets/assets/audio/collect.wav": "fc38bf15e8c36d45b24878fb50fba13c",
"assets/assets/audio/background.mp3": "d517987e47276252257d2894c8471d7a",
"assets/assets/audio/hit.wav": "234c5def46cd0911cf2b68f504e870a8",
"assets/assets/fonts/pixel_mania.ttf": "be3b1ac41c8dd4e1d64acd77a23c2f43",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
