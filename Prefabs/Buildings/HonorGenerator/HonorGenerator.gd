extends Building

@export var honor_generation_amount: int
@export var honor_generation_time: float


func _ready():
	super() #calls parent _ready
	_createAndConfigureTimer()


func _createAndConfigureTimer() -> void:
	var timer: Timer = Timer.new()
	timer.wait_time = honor_generation_time
	timer.one_shot = false
	timer.timeout.connect(_generateHonor)
	add_child(timer)
	timer.start()

func _generateHonor() -> void:
	Game.world.honor.add(honor_generation_amount)
