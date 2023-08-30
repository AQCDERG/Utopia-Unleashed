class_name AnimalFactory
extends Node

var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())

func createAnimal(type: Animal.Type) -> Animal:
	var animal: Animal
	match type:
		Animal.Type.LAVA_DEER:
			animal = LavaDeer.GetScene().instantiate()
		Animal.Type.HELL_HOUND:
			animal = Hellhound.GetScene().instantiate()
		Animal.Type.HUNTER:
			animal = Hunter.GetScene().instantiate()
		Animal.Type.DWARF:
			animal = Dwarf.GetScene().instantiate()
		_:
			_log.error("Unknown animal type: " + Animal.Type.find_key(type))
	return animal
