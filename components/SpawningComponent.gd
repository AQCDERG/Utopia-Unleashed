extends Node3D

@export var spawnerTime: int
@export var spawnerBuilding: Building
@export var type: Animal.Type
@export var type2: Animal.Type
@export var maxSoldierAmount: int
var soldierAmount: int

var world: World

var building: Building
func _enter_tree() -> void:
	world = Game.world

func _ready() -> void: 
	_createAndConfigureIncomeTimer()

func spawnUnit():
	if(soldierAmount >= maxSoldierAmount):
		return
	match type:
		Animal.Type.DWARF:
			world.animalCreator.spawnDwarf(spawnerBuilding)
		Animal.Type.HELL_HOUND:
			world.animalCreator.spawnWolf(spawnerBuilding)
		Animal.Type.CANNON:
			world.animalCreator.spawnCannon(spawnerBuilding)
		_:
			world.animalCreator.spawnHunter(spawnerBuilding)
	soldierAmount += 1
	if(type2 == Animal.Type.NONE):
		return
	match type2:
		Animal.Type.HUNTER:
			world.animalCreator.spawnDwarf(spawnerBuilding)
		Animal.Type.HELL_HOUND:
			world.animalCreator.spawnWolf(spawnerBuilding)
		Animal.Type.CANNON:
			world.animalCreator.spawnCannon(spawnerBuilding)
		_:
			world.animalCreator.spawnHunter(spawnerBuilding)
	soldierAmount += 1



func _createAndConfigureIncomeTimer() -> void:
	var timer: Timer = Timer.new()
	timer.wait_time = spawnerTime
	timer.one_shot = false
	timer.timeout.connect(spawnUnit)
	add_child(timer)
	timer.start()
