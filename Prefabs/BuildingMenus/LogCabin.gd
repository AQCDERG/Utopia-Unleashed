extends Control
@onready var spawnHunterButton: Button = %Hunter
@onready var animalSpawnerManager: AnimalCreationManager = %AnimalCreationManager
@onready var buildingMenuManager: BuildingMenuManager = %BuildingMenuManager
var building: Building
func _ready() -> void: 
	spawnHunterButton.pressed.connect(spawnHunter)

func spawnHunter():
	if(buildingMenuManager.buildingCreated == null):
		return
	building = buildingMenuManager.buildingCreated
	animalSpawnerManager.spawnHunter(building)
