class_name AnimalActionManager
extends Node
enum ActionType {
  STATIONARY,
  WANDERING,
  HUNTING, 
  ATTACKING,
  FLEEING,
}

var currentActionType: ActionType

signal onActionChanged(previousAction: AnimalAction, newAction: AnimalAction)

var animal: Animal

func _enter_tree() -> void:
  animal = get_parent() # SPAGAETTI CODE

func runCurrentAction(delta: float) -> void:
  if(animal.currentAction != null):
    animal.currentAction.process(animal, delta)

func changeActionTo(action: AnimalAction) -> void:
  var lastAction = animal.currentAction

  _finishLastAction()
  _beginNewAction(action)

  onActionChanged.emit(lastAction, action)

func _finishLastAction() -> void:
  if(animal.currentAction != null):
    animal.currentAction.finish(animal)

func _beginNewAction(action: AnimalAction) -> void:
  animal.currentAction = action
  if(animal.currentAction != null):
    animal.currentAction.begin(animal)

func getCurrentAction() -> ActionType:
  return ActionType.WANDERING
