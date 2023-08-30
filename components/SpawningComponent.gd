extends Node3D

@export var spawnerTime: int
@export var spawnerBuilding: Building
@export var type: Animal.Type
@export var maxSoldierAmount: int
var soldierAmount: int

var world: World

var building: Building
func _enter_tree() -> void:
	world = Game.world

func _ready() -> void: 
	print("DONE")
	_createAndConfigureIncomeTimer()

func spawnUnit():
	if(soldierAmount >= maxSoldierAmount):
		print("OK")
		return
	match type:
		Animal.Type.DWARF:
			world.animalCreator.spawnDwarf(spawnerBuilding)
		_:
			world.animalCreator.spawnHunter(spawnerBuilding)
	soldierAmount += 1

func _createAndConfigureIncomeTimer() -> void:
	print("DDID")
	var timer: Timer = Timer.new()
	timer.wait_time = spawnerTime
	timer.one_shot = false
	timer.timeout.connect(spawnUnit)
	add_child(timer)
	timer.start()
