extends Building

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