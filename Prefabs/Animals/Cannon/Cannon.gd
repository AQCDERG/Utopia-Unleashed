extends Animal
class_name Cannon
static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Animals/Cannon/Cannon.tscn")
	return _scene
signal hasTarget

# Please seperate or merge the animations into the correct animation players.
@onready var movingAnimation: AnimationPlayer = %MovingAnimation
@onready var wanderingAction: WanderingAction = %WanderingAction
@onready var rangeAttackAction: RangeAttackAction = %RangeAttackAction



func _ready() -> void:
	super()
	play_moving_animation()
	actionManager.changeActionTo(wanderingAction)
	actionManager.onActionChanged.connect(func(_previousAction: AnimalAction, newAction: AnimalAction):
		if newAction is WanderingAction:
			play_moving_animation()
	)
	animalDetector.onAnimalEntered.connect(beginAttack)
	animalDetector.onAnimalExited.connect(endAttack)

	
func play_moving_animation() -> void:
	movingAnimation.play("Wandering")

func beginAttack(body: Node3D) -> void:
	if(checkBody(body)):
		rangeAttackAction.target = body
		actionManager.changeActionTo(rangeAttackAction)
		print("DECTECTED")

func endAttack(body: Node3D) -> void:
		if(checkBody(body)):
			actionManager.changeActionTo(wanderingAction)
			print("Slop")

func checkBody(body: Node3D) -> bool:
	print("WHAT")
	if(rangeAttackAction.target == null):
		print("IT SHOULD STOP")
		return true
	print("HUH")
	return false

	#&& actionManager.currentActionType == AnimalActionManager.ActionType.WANDERING


func getTarget() -> Node3D:
	return rangeAttackAction.target
