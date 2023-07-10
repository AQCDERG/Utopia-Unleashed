class_name LogCabin
extends Building

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Buildings/LogCabin/LogCabin.tscn")
	return _scene

static var _currencyCost: Array[Currency]
static func GetCurrencyCost() -> Array[Currency]:
	if _currencyCost == null:
		_currencyCost = [
			Currency.new(Currency.Type.HONOR, 5),
			Currency.new(Currency.Type.PASSION, 5)
		]
	return _currencyCost 
