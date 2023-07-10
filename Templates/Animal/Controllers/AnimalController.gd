class_name AnimalController
extends Node

# MUST BE CHILD OF ANIMAL.

var animal: Animal


func _enter_tree() -> void:
  animal = get_parent().get_parent() # SPAGAETTI CODE
