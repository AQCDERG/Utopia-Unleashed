class_name Hunter
extends Animal

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Animals/Hellhound/Hellhound.tscn")
	return _scene

static var _currencyCost: Array[Currency]
static func GetCurrencyCost() -> Array[Currency]:
	if _currencyCost == null:
		_currencyCost = [
      Currency.new(Currency.Type.HONOR, 5),
      Currency.new(Currency.Type.LIFE, 1)
    ]
	return _currencyCost

static func IsAbleToBePurchased() -> bool:
	return true