class_name AnimalAction 
extends Node

var _log: Log

func _enter_tree() -> void:
  _log = Log.new(get_script())

@warning_ignore("unused_parameter")
func begin(animal: Animal) -> void:
  pass

@warning_ignore("unused_parameter")
func process(animal: Animal, delta: float) -> void:
  pass

@warning_ignore("unused_parameter")
func finish(animal: Animal) -> void:
  pass