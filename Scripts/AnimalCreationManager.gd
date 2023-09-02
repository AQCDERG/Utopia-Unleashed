class_name AnimalCreationManager
extends Node

signal onAnimalAdded(animal: Animal)
signal onControlableAnimalAdded(animal: Animal)
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

func spawnMystiqueFoxRandomly() -> void:
	var fox = animalFactory.createAnimal(Animal.Type.MYSTIQUE_FOX)
	add_child(fox)
	fox.global_position = Vector3(randi_range(-100, -90), 40, randi_range(-10, 10))
	onAnimalAdded.emit(fox)
func spawnDwarf(building: Building) -> void:
	var x: int = building.position.x
	var y: int = building.position.y
	var z: int = building.position.z
	
	var dwarf = animalFactory.createAnimal(Animal.Type.DWARF)
	add_child(dwarf)
	dwarf.global_position = Vector3(randi_range(x - 1, x + 1), y + 10, randi_range(z - 1, z + 1))
	onAnimalAdded.emit(dwarf)

func spawnCannon(building: Building) -> void:
	var x: int = building.position.x
	var y: int = building.position.y
	var z: int = building.position.z
		
	var cannon = animalFactory.createAnimal(Animal.Type.CANNON)
	add_child(cannon)
	cannon.global_position = Vector3(randi_range(x - 1, x + 1), y + 10, randi_range(z - 1, z + 1))
	onAnimalAdded.emit(cannon)

func spawnWolf(building: Building):
	var x: int = building.position.x
	var y: int = building.position.y
	var z: int = building.position.z
	
	var hellHound = animalFactory.createAnimal(Animal.Type.HELL_HOUND)
	add_child(hellHound)
	hellHound.global_position = Vector3(randi_range(x - 1, x + 1), y + 10, randi_range(z - 1, z + 1))
	onAnimalAdded.emit(hellHound)

func spawnHunter(building: Building) -> void:
	var hunter = animalFactory.createAnimal(Animal.Type.HUNTER)
	add_child(hunter)
	hunter.global_position = building.position + Vector3(0,5,0)
	onAnimalAdded.emit(hunter)
	onControlableAnimalAdded.emit(hunter)

