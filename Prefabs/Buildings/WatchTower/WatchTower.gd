extends DefenderBuilding
class_name WatchTower

static var _scene: PackedScene

func _ready() -> void:
	super._ready()


static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Buildings/WatchTower/WatchTower.tscn")
	return _scene

static func getCost(honor: CurrencyManager, passion: CurrencyManager, death: CurrencyManager) -> void:
	honor.remove(5)
	passion.remove(10)
	death.remove(1)
