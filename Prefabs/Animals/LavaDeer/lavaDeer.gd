class_name LavaDeer
extends Animal

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Animals/LavaDeer/LavaDeer.tscn")
	return _scene


@onready var movingAnimation: AnimationPlayer = %Wandering
@export var twirlingMustache: AnimationPlayer

@export var attaking: AnimationPlayer

@onready var wanderingAction: WanderingAction = %WanderingAction 



func _playMovingAnimation() -> void:
	movingAnimation.play("Moving")

func _playMustacheTwirlAnimation() -> void:
	twirlingMustache.play("mustacheTwirl 2")

func _ready() -> void:
	super()
	actionManager.onActionChanged.connect(func(_previousAction: AnimalAction, newAction: AnimalAction):
		if newAction is WanderingAction:
			_playMovingAnimation()
	)
	actionManager.changeActionTo(wanderingAction)
