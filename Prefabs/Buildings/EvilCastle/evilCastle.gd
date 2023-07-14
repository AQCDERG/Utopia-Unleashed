class_name EvilCastle
extends Building

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Buildings/EvilCastle/evilCastle.tscn")
	return _scene

static var _currencyCost: Array[Currency]
static func GetCurrencyCost() -> Array[Currency]:
	if _currencyCost == null:
		_currencyCost = [
      Currency.new(Currency.Type.DEATH, 10),
      Currency.new(Currency.Type.PASSION, 5),
    ]
	print("FLFOFLOF")
	return _currencyCost
