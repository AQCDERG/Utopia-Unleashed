extends Animal
class_name MystiqueFox
static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Animals/MystiqueFox/MystiqueFox.tscn")
	return _scene

# Please seperate or merge the animations into the correct animation players.
@onready var movingAnimation: AnimationPlayer = %MovingAnimation
@onready var howling: AnimationPlayer = %DyingAnimation
@onready var howlAudio: AudioStreamPlayer3D = %AttackingAnimation
@onready var wanderingAction: WanderingAction = %WanderingAction
@onready var attackAction: AttackAction = %AttackAction


func _ready() -> void:
	super()
	play_moving_animation()
	actionManager.changeActionTo(wanderingAction)
	actionManager.onActionChanged.connect(func(_previousAction: AnimalAction, newAction: AnimalAction):
		if newAction is WanderingAction:
			play_moving_animation()
	)

func play_howl_animation() -> void:
	howling.play("Howl")
	
func play_attack_animation() -> void:
	howling.play("Attack")
	
func play_moving_animation() -> void:
	movingAnimation.play("Wandering")