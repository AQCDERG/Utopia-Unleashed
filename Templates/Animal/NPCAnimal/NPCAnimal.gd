class_name NPCAnimal
extends Animal


var wanderingAction: WanderingAction
var stationaryAction: StationaryAction

@onready var viewArea: Area3D = %ViewArea

var currentAction: NPCAnimalAction
var actionManager: NPCAnimalActionManager = NPCAnimalActionManager.new()

enum Personality {
	AGGRESSIVE,
	PASSIVE,  
	DEFENSIVE 
}

enum Action {
	# HUNTING,
	# FLEEING,
	WANDERING, 
	STATIONARY
}



# func _ready() -> void:
	# actionManager.changeAction(self)

func _process(delta: float) -> void:
	actionManager.runCurrentAction(self)



func pathFindTo(position: Vector3) -> void:
	pass


		# var syncedTimeScale: float = secondAnimation.current_animation_length/actionTimer.wait_time
		# secondAnimation.speed_scale = syncedTimeScale
		# secondAnimation.play("SecondAnimation")
		


class AnimalDetectionComponent extends Area3D:
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
	



class NPCAnimalActionManager:
	func runCurrentAction(animal: NPCAnimal) -> void:
		if(animal.currentAction != null):
			animal.currentAction.process(animal)
	
	func changeAction(animal: NPCAnimal, action: NPCAnimalAction) -> void:
		_finishLastAction(animal)
		_beginNewAction(animal, action)
	
	func _finishLastAction(animal: NPCAnimal) -> void:
		if(animal.currentAction != null):
			animal.currentAction.finish(animal)

	func _beginNewAction(animal: NPCAnimal, action: NPCAnimalAction) -> void:
		animal.currentAction = action
		if(animal.currentAction != null):
			animal.currentAction.begin(animal)


class NPCAnimalAction extends Node:
	func begin(animal: NPCAnimal) -> void:
		pass

	func process(animal: NPCAnimal) -> void:
		pass

	func finish(animal: NPCAnimal) -> void:
		pass

# --- Base Actions --- #

class WanderingAction extends NPCAnimalAction:
	pass

class StationaryAction extends NPCAnimalAction:
	pass

class AttackAction extends NPCAnimalAction:
	pass


# -- Custom Actions -- #

class WolfAttackAction extends WanderingAction:
	pass


# --- Base Animals --- #

# Irrelevant for now
class PassiveNPCAnimal extends NPCAnimal:
	pass

class AggressiveNPCAnimal extends NPCAnimal:
	@onready var attackComponent: AnimalDetectionComponent = %AttackComponent
	var attackAction: AttackAction = AttackAction.new()


	func attackTarget() -> void:
		if(attackComponent.isAnyAnimalWithinRange):
			actionManager.changeAction(self, attackAction)

	pass

class DefensiveNPCAnimal extends NPCAnimal:
	pass

# --- Custom Animals --- #

class Wolf extends AggressiveNPCAnimal:
	var wolfAttackAction: WolfAttackAction = WolfAttackAction.new()

	#func _init() -> void:
	#	attackAction 

	#var attackAction: AttackAction = AttackAction.new()

