extends CharacterBody3D
class_name Animal 

static func GetScene() -> PackedScene:
	push_error("This method should be overriden by the child class!")
	return null

static func GetCurrencyCost() -> Array[Currency]:
	push_error("This method should be overriden by the child class! or it doesnt support it")
	return []

static func IsAbleToBePurchased() -> bool:
	return false


enum Type {
	NONE,
	LAVA_DEER,
	HELL_HOUND,
	HUNTER,
}

@export var animalConfiguration: AnimalConfiguration

@onready var hurtParticles: GPUParticles3D = %HurtParticles

@onready var autonomousController: AutonomousAnimalController = %AutonomousAnimalController
@onready var playerController: PlayerAnimalController = %PlayerAnimalController
@onready var actionManager: AnimalActionManager = %AnimalActionManager

@onready var health: HealthComponent = %HealthComponent
@onready var targetedPathFinder: TargetedPathFinderComponent = %TargetedPathFinderComponent # Fix me!
@onready var animalDetector: AnimalDetectionComponent = %AnimalDetectionComponent

var currentAction: AnimalAction
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var world: World


func _ready() -> void:
	# if (!is_multiplayer_authority()):
	# 	return

	await get_tree().process_frame

	health.onHealthDecreased.connect(func(amountDecreased: int) -> void:
		#ClientRPC_spawnHurtParticles.rpc(amountDecreased)
		ClientRPC_spawnHurtParticles(amountDecreased)
	)

func _physics_process(delta: float) -> void:
	# if (!is_multiplayer_authority()):
	# 	return

	_handleGravity(delta)
	move_and_slide()

func _handleGravity(delta: float) -> void:
	if (!is_on_floor()):
		velocity.y -= gravity * delta

@rpc("authority", "call_local")
func ClientRPC_spawnHurtParticles(amount: int) -> void:
	hurtParticles.amount = amount
	hurtParticles.emitting = true
