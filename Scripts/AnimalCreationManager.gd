class_name AnimalCreationManager
extends Node

signal onAnimalAdded(animal: Animal)
@onready var animalFactory: AnimalFactory = %AnimalFactory

func spawnDeerRandomly() -> void:
	var deer = animalFactory.createAnimal(Animal.Type.LAVA_DEER)
	add_child(deer)
	deer.global_position = Vector3(randi_range(0, 10), 40, randi_range(0, 10))
	onAnimalAdded.emit(deer)

func spawnWolfRandomly() -> void:
	var wolf = animalFactory.createAnimal(Animal.Type.HELL_HOUND)
	add_child(wolf)
	wolf.global_position = Vector3(randi_range(-100, -90), 40, randi_range(-10, 10))
	onAnimalAdded.emit(wolf)

func spawnHunter(building: Building) -> void:
	var hunter = animalFactory.createAnimal(Animal.Type.HUNTER)
	add_child(hunter)
	hunter.global_position = building.position
	onAnimalAdded.emit(hunter)
