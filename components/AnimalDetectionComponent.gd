class_name AnimalDetectionComponent 
extends Area3D

signal onAnimalEntered(target: Animal)
signal onAnimalExited(target: Animal)

var isAnyAnimalWithinRange: bool:
  get:
    return animalsWithinRange.size() > 0

var firstAnimalWithinRange: Animal:
  get:
    return animalsWithinRange[0]

var animalsWithinRange: Array[Animal] = []

func _ready() -> void:
  registerAnimalDetectors()

func registerAnimalDetectors() -> void:
  body_entered.connect(func(body) -> void:
    if (body is Animal):
      animalsWithinRange.append(body)
      onAnimalEntered.emit(body)
  )

  body_exited.connect(func(body) -> void:
    if(body is Animal):
      animalsWithinRange.erase(body)
      onAnimalExited.emit(body)
  )
