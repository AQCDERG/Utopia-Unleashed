class_name Hellhound
extends Animal

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Animals/Hellhound/Hellhound.tscn")
	return _scene

# Please seperate or merge the animations into the correct animation players.
@export var movingAnimation: AnimationPlayer
@export var howling: AnimationPlayer
@export var howlAudio: AudioStreamPlayer3D


func play_howl_animation() -> void:
	howling.play("Howl")

func play_attack_animation() -> void:
	howling.play("Attack")

func play_moving_animation() -> void:
	movingAnimation.play("Bip01|Take 001|BaseLayer")