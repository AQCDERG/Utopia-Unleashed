class_name LogCabin
extends Building

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Buildings/LogCabin/LogCabin.tscn")
	return _scene

static func getCost(honor: CurrencyManager, passion: CurrencyManager) -> void:
	honor.remove(5)
	passion.remove(5)
