class_name LavaDeer
extends Animal

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Animals/Hellhound/Hellhound.tscn")
	return _scene

@export var movingAnimation: AnimationPlayer
@export var twirlingMustache: AnimationPlayer

@export var attaking: AnimationPlayer


func _playMovingAnimation() -> void:
	movingAnimation.play("Moving")

func _playMustacheTwirlAnimation() -> void:
	twirlingMustache.play("mustacheTwirl 2")