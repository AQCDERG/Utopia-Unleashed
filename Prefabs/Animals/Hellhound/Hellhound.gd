class_name Hellhound
extends Animal

static var _scene: PackedScene
static func GetScene() -> PackedScene:
	if _scene == null:
		_scene = load("res://Prefabs/Animals/Hellhound/Hellhound.tscn")
	return _scene

# Please seperate or merge the animations into the correct animation players.
@onready var movingAnimation: AnimationPlayer = %Wandering
@onready var howling: AnimationPlayer = %DyingAnimation
@onready var howlAudio: AudioStreamPlayer3D = %AttackingAnimation
@onready var wanderingAction: WanderingAction = %WanderingAction
@onready var attackAction: AttackAction = %AttackAction


func _ready() -> void:
	super()
	actionManager.onActionChanged.connect(func(_previousAction: AnimalAction, newAction: AnimalAction):
		if newAction is WanderingAction:
			play_moving_animation()
	)
	actionManager.changeActionTo(wanderingAction)
	animalDetector.onAnimalEntered.connect(beginAttack)
	animalDetector.onAnimalExited.connect(endAttack)


func play_howl_animation() -> void:
	howling.play("Howl")
	
func play_attack_animation() -> void:
	howling.play("Attack")
	
func play_moving_animation() -> void:
	movingAnimation.play("Bip01|Take 001|BaseLayer")

#func _on_attack_area_body_entered(body:Node3D) -> void:
#	actionManager.changeActionTo(attackAction)
func beginAttack(body: Node3D) -> void:
	actionManager.changeActionTo(attackAction)

func endAttack(body: Node3D) -> void:
	actionManager.changeActionTo(wanderingAction)