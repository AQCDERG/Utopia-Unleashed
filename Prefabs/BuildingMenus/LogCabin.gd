extends Control
@onready var spawnHunterButton: Button = %Hunter

@onready var world: World = Game.world

var building: Building
func _ready() -> void: 
	spawnHunterButton.pressed.connect(spawnHunter)
func spawnHunter():
	world.animalCreator.spawnHunter(building)
