class_name ManaDog
extends Building

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Buildings/ManaDog/manaGenerator.tscn")
	return _scene

static var _currencyCost: Array[Currency]
static func GetCurrencyCost() -> Array[Currency]:
	if _currencyCost == null:
		_currencyCost = [
      Currency.new(Currency.Type.MANA, 10),
      Currency.new(Currency.Type.HARMONY, 10),
    ]
	return _currencyCost 

@export var mana_generation_amount: int
@export var mana_generation_time: float


func _ready():
	super() #calls parent _ready
	_createAndConfigureTimer()


func _createAndConfigureTimer() -> void:
	var timer: Timer = Timer.new()
	timer.wait_time = mana_generation_time
	timer.one_shot = false
	timer.timeout.connect(_generateMana)
	add_child(timer)
	timer.start()

func _generateMana() -> void:
	Game.world.mana.add(mana_generation_amount)