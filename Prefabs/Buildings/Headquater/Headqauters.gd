class_name HeadQuarters
extends Building

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Buildings/Headquater/headqauters.tscn")
	return _scene

static func getCost(honor: CurrencyManager, mana: CurrencyManager, harmony: CurrencyManager, life: CurrencyManager) -> void:
	honor.remove(20)
	mana.remove(10)
	harmony.remove(5)
	life.remove(1)