extends Node
class_name GamertagGenerator

enum CaseType {
	LOWER = 0,
	UPPER = 1,
	CAPITALIZE = 2
}

const MINIMUM_NUMBER: int = 1
const MAXIMUM_NUMBER: int = 999

var adjectives = [
	"Babbler", "FrownyFace", "Jacked", "Cracked", "ShredOff", "NPC", "Green", 
	"Fat", "Super", "Mr.", "AH_NO_GOD_DAMIT", "Scandinavian", "PackaPunched",
	"SuckerPunched", "Lego", "Hacking", "", "@", "Gosh_Ne_Nestam", 
	"Crying", "Screaming", "Communistic", "PricklyPeared", "Moronic", "Nani", "Pistachoed", "Spanish", "Sweaty",
	"Whispering", "PuzzleFaced", "Bursting", "Fragmented", "CrumbleDown", "Automaton", "Azure", "Tubby", 
	"Ultra", "Dr.", "OH_PLEASE_NO", "Polynesian", "Compressed", "Uppercutted", "Kinetico", "Bypassing", "📧", 
	"Egad_A_Goomba", "Blubbering", "Shrieking", "Socialistic", "SpinyPalm", "Nitwitted", "Que", "Pomegranated", 
	"Greek", "Flustered", "Twilighted", "Frostbitten", "Zigzagged", "Lopsided", "Gritty", "HyperActive", 
	"Pixelated", "Cheesecaked", "Turbulent", "Wavelength", "OH_MY_PIXELS", "Celtic", "Deflated", "RoundhouseKicked", 
	"Rubberized", "Decrypting", "☯️", "Gee_Wiz_Wally", "Wheezing", "Squawking", "Capitalistic", "SpikyDurian", 
	"Boneheaded", "Kore", "Strawberried", "Portuguese", "Clammy", "Cybernetic", "Ablaze", "Sunbaked", "Kaleidoscopic", 
	"Yodeling", "Undulated", "Zeppelin", "OH_DOODLE_DO", "Afro-Asian", "Twisted", "DropKicked", "Geodesic", "Smoldering", 
	"☠️", "BAM_ZOINKS", "Murmuring", "Wailing", "Materialistic", "VelvetyKiwi", "Brainless", "Como", 
	"Caramelized", "Filipino", "Misted", "👑", "Lit", "Savage", "FOMO", "Vibe Check", "On Fleek", "Stan", "Cap/No Cap", 
	"Clout", "Ghosting", "Gucci", "Flex", "Woke", "Shook", "Slay", "Goals", "Simp", "Tea", "Bae", "Yeet", 
	"Lowkey", "Highkey", "GOAT", "Suss", "Drip", "Fit", "Hypebeast", "Extra", "Salty", "Fire", "Spill the tea", 
	"Snatched", "Receipts", "Shade", "Basic", "Cancelled", "I'm dead", 
	"Glow up", "Clap back", "Finna", "Big Yikes", "Boomer", "Bye Felicia", "Cringe", "Egirl", "Eboy", "Finsta", 
	"Gas", "Get the bag", "Hundo P", "JOMO", "Karen", "Lurk", "Noob", "On God", "Periodt", "Pressed", "Pull up", 
	"Ratchet", "Ship", "Slide into the DMs", "Snack", "Spam", "Squad", "Swerve", "Thicc", "Throw shade", "Trolls", 
	"Turnt", "VSCO girl", "Woke", "Ya yeet", "Zaddy", "Zoomer", "Dank", "Bruh", "Swag", "Savage", "Chill", "Lit", 
	"Dope", "Mood", "Flex", "No cap", "Ghost", "RIP", "Swole", "Ride or die", "Secure the bag", "Fam", "Gassed", "Suss", "IAttackable",
	"ILightable", "ISavagable", "IFomoable", "IVibeCheckable", "IOnFleekable", "IStanable", "ICapNoCapable", 
	"ICloutable", "IGhostable", "IGucciable", "IFlexing", "IWakable", "IShookable", "ISlayable", 
	"IGoalable", "ISimpable", "ITeaing", "IBaeing", "IYeetable", "ILowkeying", "IHighkeyable", 
	"IGoatable", "ISussable", "IDrippable", "IFittable", "IHypebeastable", "IExtraable", 
	"ISalting", "IFiring", "ISpillTeaing", "ISnatchable", "IReceiptable", "IShadable", 
	"IBasicing", "ICancelable", "IImDead", "IGlowUpable", "IClapBackable", "IFinnaable", 
	"IBigYikesing", "IBoomable", "IByeFeliciaable", "ICringable", "IEgirlable", "IEboyable", 
	"IFinstaable", "IGasable", "IGetTheBagable", "IHundoPing", "IJomoing", "IKarenable", "ILurking", 
	"INoobing", "IOnGodding", "IPeriodtable", "IPressable", "IPullUpable", "IRatchettable", 
	"IShippable", "ISlideIntoDMsable", "ISnackable", "ISpamming", "ISquaddable", "ISwervable", 
	"IThiccable", "IThrowShadeable", "ITrollable", "ITurntable", "IVscoGirlable", "IWakable", 
	"IYaYeetable", "IZaddiable", "IZoomable", "IDankable", "IBruhing", "ISwagable", "ISavagable", 
	"IChillable", "ILightable", "IDopable", "IMoodable", "IFlexing", "INoCapable", "IGhostable", 
	"IRippable", "ISwoleable", "IRideOrDieable", "ISecureTheBagable", "IFamable", "IGasable", "ISussing", 
	"Kawaii", "Desu", "Neko", "Hime", "Yume", "Kumo", "Sakura", "Hoshi", "Tsuki", "Usagi", "Mochi", 
	"Tenshi", "Hana", "Chibi", "Amai", "Doki", "Mikan", "Momo", "Fuwafuwa", "Ume", "Kira", "Aoi", 
	"Haru", "Shiroi", "Koi", "UwuSakuraSenpai", "Yuki", "Ringo", 
	"Miruku", "Ran", "Yasashii", "Umi", "Kaze", "Kuma", "Koneko", "Purin", 
	"Ichigo", "Ribbon", "Yōsei", "Pikapika", "Yasai", "Panda", "Niji", "Happī", 
	"Karafuru", "Sora", "Mizuiro", "Risu", "Hinata", "Himawari", "Momoiro", "Kitsune", 
	"Yozora", "Kabocha", "Nyanko", "Kirakira", "Yukiko", "Matsuri", "Murasaki", 
	"Hoshizora", "Kinoko", "Asa", "Yoru", "Hotaru", "Mizutama", "Fushigi", "Sugoi",
	"Yamabuki", "Sakurambo", "Himesama", "Tori", "Kemuri", "Mahō", "Hikari", "Yūki", "きれい",
	"おいしい",	"大きい",	"小さい",	"高い",	"低い",	"安い",	"暑い",	"寒い",	"長い",
	"短い",	"広い",	"狭い",	"かわいい",	"うるさい",	"静か",	"明るい",	"暗い",	"簡単",
	"難しい",	"重い",	"軽い",	"弱い",	"強い",	"早い",	"遅い",	"新しい",	"古い",	"若い",
	"年寄り",	"少し",	"多い",	"少ない",	"楽しい",	"つまらない"
]

var nouns = [
	"Daniala Nili👑", "Daniala Nili👑","Daniala Nili👑","Daniala Nili👑","Daniala Nili👑",
	"Tww?❓", "PxiniChinny", "Unicorn🦄", "King👑", "Gru👤", "Skies🌌", "Garbaj🗑️", "RienHeartd💔", "Beans🌱", "Kabob🍖",
	"ToyInsanity🎲🌀", "Taffer😈", "Spitfire🔥", "Beast🐾", "Dream💭", "GagscwatchFan🎭🕰️", 
	"GlorzoidFan🌟👽", "Beast👨‍🦳🦁", "UncleBob👴👨", "IronCladFan⚙️👤", "VentrixFan🌀👤", "StormShield🌩️🛡️", 
	"Fortnite🎮", "Balbazarbrat👶🤴", "ACQDERG" , "Game🎲", "SpagettiCoder🍝👨‍💻", "GDScripter💻📜",
	"BattlEye⚔️", "BossMan👨‍💼", "WhistleDuck🦆🎵", "Ramesy👨‍🍳", "Gym🏋️", "Library📚", "Work👨‍💻", "💀", 
	"Atvex🏍️", "Fatty_Fat_Skins🍔🍟", "Hoog🏡", "EasyAntiCheat™🛡️⚔️", "Discord💬", "SBB", "KennBone", 
	"MrTickleClown", "CircusBeserkus", "TaiLung", "ESPARTANO","ZaraOP", "Vec", "Loyal", "Lion", "Jc_Dounle_OT",
	"Rose", "Jack", "Hamburger", "Roxanne", "Elektra", "BIGBERTHA","Rose🌹" ,"SpanishElektra", "Villagers", "Mr.Fani", 
	"Emmology", "BobbleLeague", "Fremento", "NPCArmy", "Jamacian", "Man", "JavaMaster☕💻",
	"BlowDartDart", "Gymetry", "ZypherWind🌬️", "BakersDozen🍞🔢", "DawnTreader🌅⛵", "JacketZipper", "GalaxyWatch🌌⌚", 
	"MysticMariner🔮⚓", "EpicSage📖🦉", "ZestZebra🦓🍋", "StellarNova⭐💥", "PizzaPan🍕🍳", "APC",
	"InfinityJester♾️🃏", "HoneyBee🍯🐝", "WizardWhiskers🧙‍♂️🐈", "CottonCandy🍬🍭", "ShroomScribe🍄✍️", 
	"CryptoKnight🔐⚔️", "BlinkButterfly🦋👁️", "VulcanVanguard🔥🛡️", "PolarPulse❄️💓", "AsteroidAce🌑🏆", "RainbowRaven🌈🦅", 
	"PhantomPhoenix👻🔥", "QuantumQuokka🔬🦘", "RoaringRaptor🗣️🦖", "AstronautAnt👨‍🚀🐜", "CryoCheetah❄️🐆", "RocketRaccoon🚀🦝",
	"LaughingLemur😂🐒", "FrostFire🔥❄️", "VexingViper🐍", "QuartzQueen👸🏼💎", "TurboTurtle🐢💨", "PlasmaPeacock🔬🦚", "EmperorEagle👑🦅", "NeonNarwhal🌈🦄",
	"KawaiiHoshiChan🌸", "DesuDesuYukiKun💮", "ChibiMochiSan🍡", "NekoNyaChan🐱", "KiraKiraStarSenpai✨", 
	"PikaPikaYumeChan🌠", "HanaBlossomKun🌺", "TenshiAngelSenpai👼", "KumaCuddlesChan🐻", "AoiBlueKun🔵", 
	"YumeDreamerSenpai🌜", "AiLoveChan❤️", "MikanTangerineKun", "RinMelodySenpai🎵", "UsagiBunnyChan🐰", 
	"HaruSpringKun🌸", "AmaiSweetieSenpai🍬", "KirakiraSparkleChan✨", "MomoPeachyKun", "UmePlumSenpai", 
	"ShiroiAngelChan⚪", "FuwafuwaFluffyKun☁️", "KoiLoveSenpai💖", "TsukiMoonChan🌙", "SpaghettiCoder🍝", 
	"BugGenerator🐜", "CoffeeToCodeConverter☕", "BruteForceMaster💪", "EternalDebugger🕵️‍♂️", 
	"StackOverflowSurvivor💻", "InfiniteLoopCreator🔄", "GitCommitGuru👨‍💻", "CodeNinja🥷", "SyntaxErrorSpecialist❌", 
	"KeyboardWarrior⌨️", "AlgorithmWizard🧙‍♂️", "RecursiveRebel🔄", "RefactoringGuru👨‍💼", "ConsoleCowboy🤠", 
	"RubberDuckDebugger🦆", "MidnightCoder🌃", "CtrlC-CtrlVExpert🔁", "404NotFound❗", "CodeJuggler🤹‍♂️", 
	"IndentationCzar💅", "IDEWhisperer👂", "ScriptSurgeon🩺", "BrowserTamer🌐", "BugSquasher👾", 
	"JustGoogleItGuy🔍", "CodePoet🖊️", "Commentator💬", "ProductionPusher🏭", "RaceConditionRacer🏁", 
	"FunctionPharaoh🤴", "HeisenbugHandler👀", "SemicolonSeeker🔎", "CompilerWhisperer👂", "ExceptionExterminator👾", 
	"PseudocodePioneer👨‍🔬", "CacheCowboy🤠", "IfElseIllusionist💼", "TheUnhandledException⚠️", "PerlPlague🔮", 
	"BashBasher👊", "PHPunisher🛡️", "CSharpCrusher💥", "RacketRuckus🎾", "COBOLChaos🔥", "RubyRuckus💎", 
	"FortranFury🔥", "AssemblyAnarchy💣", "JavaJester🃏", "LispLunatic🌀", "SwiftSwatter🦟", "LuaLasher🌙", 
	"HaskellHavoc🌪️", "Brainfr*ckBane💀", "PrologPrankster🃏", 
	"HeisenbergHacker 🧪", "BlueSkyCoder 💎", "WalterWhiteHat 🥼", "SaulGoodmanDev 👔",
	"GusFringForce 🍗", "HankSchrader007 🚔", "LosPollosHacker 🐔", "PinkmanProgrammer 🚬",
	"TucoTerrorCodes 💣", "SkylerScripter 💼", "BadgerByte 🦡", "SkinnyPetePython 🐍",
	"JaneJavaScript ✈️", "ComboCompiler 🕹️", "LydiaLinuxLover 👩‍💻", "MarieMarkupQueen 💜",
	"GaleGeek 📚", "VictorVector 🔪", "TortugaTerminal 🐢", "FlynnFramework ♿",
	"GruGenius 🍌", "MinionMaster 👷", "AgnesAdventurer 🦄", "VectorVillain 🚁",
	"MargoMischief 👧", "EdithEvilGenius 😈", "DrNefarioCoder 👓", "LucyLaserBeam 🔫",
	"MrPerkinsProgrammer 👴", "KyleTheHacker 🧑‍🎤", "ScarletOverkillScripter 👩‍🦰", "AntonioAntagonist 🕵️",
	"FeloniusGruForce 🕴️", "BobTheMinion 🟨", "StuartScripting 🎸", "TimTheMinion 🍎",
	"PhilTheProgrammer 🍕", "KevinTheEvilDev 👽", "DaveDespicableCoder 🍦", "JerryTheJoker 🃏",
	"IntelliJInnovator 💡", "CodeCompletionChamp 🏆", "RefactoringMaster 🔄", "DebuggingGuru 🐞",
	"ShortcutsSensei 🥋", "InspectionInspector 👮", "WreckItWizard 🎮", "RalphTheDestroyer 💪",
	"FixItFrenzy 🔨", "VanellopeVirtuoso 🍬", "CyBugCrusher 🦟", "SugarRushSpeedster 🏎️",
	"FelixTheFixer 🎖️", "TaffytaTroublemaker 🍭", "CalhounCoder 💻", "KingCandyCoder 👑",
	"SourBillSmasher 🔨", "MintyMischief 🍬", "Q*BertQuizzer ❓", "GeneTheGamer 🎮",
	"ShankSharpshooter 🏹", "YesssTheYouTuber 📹", "SlaughterRaceRacer 🏍️", "ZangeefZapper ⚡",
	"KnowsMoreThanYou 🧠", "DoubleStripeDestroyer 🌩️","WhitespaceWrangler⚪", 
	"PascalPunisher💥", "VBScriptVandal🔨", "DelphiDaredevil😈", "BanditBuster🤠", "GoldRushGuru🏅", 
	"RustlerRounder🐄", "SheriffStar⭐", "CattleKing🐂", "ProspectorPete⛏️", "GunSlingerGreg🔫", "BountyHunterBob💰", "SaloonSally🍺", 
	"StagecoachSteve🐎",	"DynamiteDan💣", "OutlawOllie🦹", "GunslingerGus🔫", "WantedWilly🔍", "CowboyCoder💻",
	"RevolverRalph🔫", "PrairiePat🌾", "DeputyDaisy👮", "RattlesnakeRider🐍", "HorseHustlerHarry🐎",
	"CanyonCruiser🏜️", "WildWestWendy🤠", "PioneerPaul⛺", "LassoLarry🤠", "GoldPannerGary🥇",
	"TumbleweedTravis🍂", "RancherRiley🐂", "BootHillBilly🥾", "FrontierFanny🏞️", "CactusCarl🌵",
	"BattleRoyaleBuddy🔫", "ChugJugChampion🏆", "FortniteFanatic🎮", "EpicEmoteExpert💃", "SkinCollector🕴️",
	"LlamaLooter🦙", "StormSurvivor🌩️", "PleasantParkPatrol🏡", "TiltedTowersTerror😱", "SlurpJuiceSipper🍹",
	"ChestChaser💼", "SupplyDropSurfer🪂", "SoloShowdownSoldier🚶", "DuoDominator👥", "SquadLeader👑",
	"VictoryRoyaleVanquisher🏆", "RocketRider🚀", "GliderGuru🪂", "PickaxePro🪓", "DustyDepotDweller🏚️",
	"LazyLakeLander🏞️", "FrenzyFarmFarmer🚜", "RetailRowRusher🏬", "SaltySpringsSwimmer🏊", "CraggyCliffsClimber🧗",
	"GoldScarGatherer🔶", "PumpShotgunPulverizer🔫", "SnobbyShoresSocialite🏖️", "FortniteFlosser💃", "DefaultSkinDynamo💥",
	"BloxBuilderBuddy🧱", "ObbyOvercomer🏃", "TycoonTycoon💰", "RthroRunner🏃‍♀️", "RobuxRich🤑",
	"ScriptingSavant📜", "GameDevGuru🎮", "LuaLover🖥️", "RoleplayRuler👑", "AdoptMeAdmirer👶",
	"JailbreakJumper🚔", "MadCityMaster🏙️", "MeepCityMogul🌃", "TowerOfHellHero🔥", "MurderMysteryMagnate🔍",
	"BubbleGumBlower🍬", "BeeSwarmSwatter🐝", "ArsenalAce🔫", "RoyaleHighRoyalty👸", "SharkBiteSurvivor🦈",
	"ThemeParkTycoon🎡", "VehicleSimulatorSpeedster🏎️", "BrookhavenBuddy🏡", "DoomspireDemolisher💣", "PiggyPlayer🐷",
	"IslandsofAdventureAdventurer🏝️", "SuperheroSimulator🦸", "ZombieStrikeSlayer🧟", "RobloxianHighschooler🏫", 
	"FishingSimulatorFisherman🎣",  "Reza 🌼", "Mehran 🌺", "Ali 🌷", "Hossein 🌸", "Mohammad 🌹",
	"Fatima 🌻", "Zahra 🌼", "Mina 🌺", "Sara 🌷", "Leyla 🌸",
	"Darius 🌹", "Cyrus 🌻", "Arash 🌼", "Javad 🌺", "Behnam 🌷",
	"Roxana 🌸", "Shirin 🌹", "Anahita 🌻", "Parisa 🌼", "Simin 🌺",
	"Bijan 🌷", "Kamran 🌸", "Shahram 🌹", "Maziar 🌻", "Babak 🌼",
	"Maryam 🌺", "Nasrin 🌷", "Shadi 🌸", "Tahereh 🌹", "Azadeh 🌻",
	"Zare 🌼", "Khosravi 🌺", "Mousavi 🌷", "Jafari 🌸", "Ghasemi 🌹",
	"Farahani 🌻", "Rezai 🌼", "Karimi 🌺", "Saeedi 🌷", "Moradi 🌸",
	"Ebrahimi 🌹", "Rahimi 🌻", "Mohammadi 🌼", "Ahmadi 🌺", "Gholami 🌷",
	"Rostami 🌸", "Rezaei 🌹", "Emami 🌻", "Mirzaei 🌼", "Sharifi 🌺",
	"Nouri 🌷", "Hashemi 🌸", "Hosseini 🌹", "Kazemi 🌻", "Mehdizadeh 🌼",
	"Shahbazi 🌺", "Naderi 🌷", "Mahmoudi 🌸", "Salehi 🌹", "Tehrani 🌻",
	"Akbarpour 🌼", "Kazempour 🌺", "Eslampour 🌷", "Rahimpour 🌸", "Jahangirpour 🌹",
	"Nasirpour 🌻", "Hashempour 🌼", "Farahpour 🌺", "Gholampour 🌷", "Rezapour 🌸",
	"Mirzapour 🌹", "Shahpour 🌻", "Mehdipour 🌼", "Karimpour 🌺", "Hosseinpour 🌷",
	"AliabadiPour 🌸", "Khatampour 🌹", "Nourpour 🌻", "Zamanpour 🌼", "Yazdanpour 🌺",
	"Valipour 🌷", "Sharifpour 🌸", "Mansourpour 🌹", "Khosropour 🌻", "Ghanbarpour 🌼",
	"AbbasPour 🌸", "Rashidpour 🌻", "Majidpour 🌺", "Taherpour 🌼", 
	"Habibpour 🌹", "Saeidpour 🌷", "Hamidpour 🌸", "Davoudpour 🌻", 
	"Kouroshpour 🌺", "Masoudpour 🌼", "MortezaPour 🌹", "Fereidounpour 🌷", 
	"Jafarpour 🌸", "Hassanpour 🌻", "Samanpour 🌺", "Naderpour 🌼", 
	"Salarpour 🌹", "Aminpour 🌷", "Babakpour 🌸", "Daryapour 🌻", 
	"FaramarzPour 🌺", "Mansourpour 🌼", "Parvizpour 🌹", "Ehsanpour 🌷",
	"Arashpour 🌸", "Raminpour 🌻", "Vahidpour 🌺", "Kianpour 🌼", 
	"Behzadpour 🌹", "Shahabpour 🌷", "Bahmanpour 🌸", "Yasharpour 🌻",
	"Li 🌸", "Chen 🌺", "Nguyen 🌼", "Kim 🌻", "Patel 🌹", "Wong 🌷", "Wang 🌸", "Tan 🌺", 
	"Lee 🌼", "Liu 🌻", "Lin 🌹", "Tran 🌷", "Zhang 🌸", "Chan 🌺", "Ho 🌼", "Yamamoto 🌻", 
	"Huynh 🌹", "Yang 🌷", "Pham 🌸", "Lim 🌺", "Nakamura 🌼", "Suzuki 🌻", "Saito 🌹", "Le 🌷", 
	"Yoshida 🌸", "Huang 🌺", "Park 🌼", "Khan 🌻", "James 🍔", "John 🍟", "Robert 🍕", "Michael 🌭", 
	"William 🍦", "David 🍩", "Joseph 🍪", "Charles 🥤", 
	"Thomas 🍗", "Christopher 🍿", "Daniel 🥪", "Matthew 🥓", 
	"Anthony 🌮", "Donald 🌯", "Mark 🥞", "Paul 🍫", 
	"Steven 🍭", "Andrew 🍮", "Kenneth 🍨", "George 🍧", 
	"Joshua 🍰", "Kevin 🎂", "Brian 🍬", "Edward 🍫", 
	"Mary 🍔", "Jennifer 🍟", "Linda 🍕", "Patricia 🌭", 
	"Elizabeth 🍦", "Susan 🍩", "Jessica 🍪", "Sarah 🥤", 
	"Karen 🍗", "Nancy 🍿", "Lisa 🥪", "Betty Bacon🥓", 
	"Laura 🌮", "Helen 🌯", "Sandra 🥞", "Donna 🍫",  "Patel 🍛", "Sharma 🥘", "Reddy 🍚", "Gupta 🍲",
	"Singh 🥭", "Chopra 🍜", "Deshmukh 🍠", "Verma 🌽", 
	"Krishnan 🥥", "Agarwal 🍆", "Bose 🌶️", "Banerjee 🍅", 
	"Dutta 🍞", "Kumar 🍢", "Nair 🥦", "Menon 🥬", 
	"Rao 🥒", "Sethi 🍠", "Malhotra 🍋", "Kapoor 🍌"
]

var special_chars = ["!", "@", "#", "$", "%", "&", "*"]
var globalName: String
func generateGamerTag() -> String:
	randomize()

	var adjective: String = adjectives.pick_random()
	var noun: String = nouns.pick_random()
	
	var gamer_tag: String = adjective + "_" + noun

	gamer_tag = _addNumberRandomly(gamer_tag)
	gamer_tag = _addSpecialCharRandomly(gamer_tag) 
	gamer_tag = _addWasTakenRandomly(gamer_tag)
	gamer_tag = _addMovesLikeJager(gamer_tag)
	gamer_tag = _changeCaseRandomly(gamer_tag)
	globalName = gamer_tag
	return gamer_tag

func getGamerTag() -> String:
	return globalName

func _addNumberRandomly(input: String) -> String:
	if(randi_range(1, 2) == 1):
		return input + str(randi_range(MINIMUM_NUMBER, MAXIMUM_NUMBER))
	else:
		return input

func _addSpecialCharRandomly(input: String) -> String:
	if(randi_range(1, 4) == 1):
		return input + special_chars.pick_random()
	else:
		return input

func _addWasTakenRandomly(input: String) -> String:
	if(randi_range(1,20) == 1):
		return input + "_was_taken"
	else:
		return input
func _addMovesLikeJager(input: String) -> String:
	if(randi_range(1,500) == 1):
		return input + "_GOT_THE_MOVES_LIKE_JAGER"
	else:
		return input
func _changeCaseRandomly(input: String) -> String:
	# Keys are like "LOWER", "UPPER", "CAPITALIZE
	var randomCase: CaseType = CaseType.values().pick_random() # randi_range(CaseType.LOWER, CaseType.CAPITALIZE)
	match randomCase:
		CaseType.LOWER:
			return input.to_lower()
		CaseType.UPPER:
			return input.to_upper()
		CaseType.CAPITALIZE:
			return input.capitalize()
		_:
			push_error("Invalid case type")
			return input


