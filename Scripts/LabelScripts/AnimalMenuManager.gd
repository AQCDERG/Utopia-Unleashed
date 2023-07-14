class_name AnimalMenuManager
extends Node

@onready var animalGamerTag: RichTextLabel = %AnimalGamerTag
@onready var animalHealth: RichTextLabel = %AnimalHealth
@onready var animalAction: RichTextLabel = %AnimalAction
var lavaDeerMenu := preload("res://Prefabs/AnimalMenus/LavaDeer/LavaDeerMenu.tscn")
var hellHoundMenu := preload("res://Prefabs/AnimalMenus/Hellhound/HellhoundMenu.tscn")
var hunterMenu := preload("res://Prefabs/AnimalMenus/Hunter/HunterMenu.tscn")


var world: World
var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())
	world = Game.world

func _ready() -> void:
	world.onAnimalAdded.connect(_on_animal_created)


func _on_animal_created(animal: Animal):
	animal.clickDetection.onMouseLeftClicked.connect(_on_specific_animal_clicked.bind(animal))

func _on_specific_animal_clicked(animal: Animal) -> void:
	createAnimalMenu(animal)
	animalGamerTag.text = animal.gamerTag.username
	animalHealth.text = str(animal.health.getHealth())
	if(animal.actionManager.getCurrentAction() == AnimalActionManager.ActionType.WANDERING):
		animalAction.text = "Wandering"

func createAnimalMenu(animal: Animal):
	if(animal.type == Animal.Type.LAVA_DEER):
		if(get_child(0) != null): #only one animal menu can exsist
			return
		var lavaDeerMenuScene = lavaDeerMenu.instantiate()
		var healthLabel = lavaDeerMenuScene.get_child(0).get_child(3) #health label is third index of the child of the scene
		var nameLabel = lavaDeerMenuScene.get_child(0).get_child(0)
		healthLabel.text = str(animal.health.getHealth())
		nameLabel.text = animal.gamerTag.username
		add_child(lavaDeerMenuScene)

	if(animal.type == Animal.Type.HELL_HOUND):
		var hellHoundMenuScene = hellHoundMenu.instantiate()
		print("THE HOUND OF HELL")
		add_child(hellHoundMenuScene)

	if(animal.type == Animal.Type.HUNTER):
		var hunterMenuScene = hunterMenu.instantiate()
		add_child(hunterMenuScene)


func _input(event): #clears menus
	if Input.is_action_just_pressed("clearUI"):
		if(get_child(0) == null):
			return
		get_child(0).queue_free()
