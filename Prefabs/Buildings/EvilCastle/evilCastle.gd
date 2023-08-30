class_name EvilCastle
extends Building

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Buildings/EvilCastle/evilCastle.tscn")
	return _scene

static func getCost(death: CurrencyManager, passion: CurrencyManager) -> void:
	death.remove(10)
	passion.remove(5)