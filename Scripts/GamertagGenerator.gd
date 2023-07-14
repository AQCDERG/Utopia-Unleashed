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
	"Crying", "Screaming", "Communistic", "PricklyPeared", "Moronic", "Nani", "Pistachoed", "Spanish"
]

var nouns = [
	"Tww?❓", "Unicorn🦄", "King👑", "Gru👤", "Skies🌌", "Garbaj🗑️", "RienHeartd💔", "Beans🌱", "Kabob🍖",
	"ToyInsanity🎲🌀", "Taffer😈", "Spitfire🔥", "Beast🐾", "Dream💭", "GagscwatchFan🎭🕰️", "GlorzoidFan🌟👽", "Beast👨‍🦳🦁", "UncleBob👴👨",
	"IronCladFan⚙️👤", "VentrixFan🌀👤", "StormShield🌩️🛡️", "Fortnite🎮", "Balbazarbrat👶🤴", "Game🎲", "SpagettiCoder🍝👨‍💻", "GDScripter💻📜",
	"BattlEye⚔️", "BossMan👨‍💼", "WhistleDuck🦆🎵", "Ramesy👨‍🍳", "Gym🏋️", "Library📚", "Work👨‍💻", "💀", 
	"Atvex🏍️", "Fatty_Fat_Skins🍔🍟", "Hoog🏡", "EasyAntiCheat™🛡️⚔️", "Discord💬", "SBB", "KennBone", "MrTickleClown", "CircusBeserkus", "TaiLung", "ESPARTANO","ZaraOP", "Vec", "Loyal", "Lion", "Jc_Dounle_OT", "Rose", "Jack", "Hamburger", "Roxanne", "Elektra", "BIGBERTHA", "SpanishElektra", "Villagers", "Mr.Fani", "Emmology", "BobbleLeague", "Fremento", 
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


