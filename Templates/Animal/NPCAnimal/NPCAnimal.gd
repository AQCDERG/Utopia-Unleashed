class_name NPCAnimal
extends Animal


var wanderingAction: WanderingAction
var stationaryAction: StationaryAction





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



# func _process(delta: float) -> void:
# 	actionManager.runCurrentAction(self)


# class AggressiveNPCAnimal extends NPCAnimal:
# 	@onready var attackComponent: AnimalDetectionComponent = %AttackComponent
# 	var attackAction: AttackAction = AttackAction.new()

# 	func attackTarget() -> void:
# 		if(attackComponent.isAnyAnimalWithinRange):
# 			actionManager.changeAction(self, attackAction)
