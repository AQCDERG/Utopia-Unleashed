extends CharacterBody3D
class_name Animal 

signal thisAnimal(Animal: Animal)
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
const hunterMenu := preload("res://Prefabs/AnimalMenus/Hunter/HunterMenu.tscn")
const AnimalName := preload("res://Scripts/AnimalName.gd")

@export var animalConfiguration: AnimalConfiguration
@onready var hurtParticles: GPUParticles3D = %HurtParticles
@export var type: Type
@onready var autonomousController: AutonomousAnimalController = %AutonomousAnimalController
@onready var playerController: PlayerAnimalController = %PlayerAnimalController
@onready var actionManager: AnimalActionManager = %AnimalActionManager
@onready var clickDetection: ClickDetectionComponent = %ClickDetectionComponent
@onready var health: HealthComponent = %HealthComponent
@onready var targetedPathFinder: TargetedPathFinderComponent = %TargetedPathFinderComponent # Fix me!
@onready var pathFinder: PathFinderComponent = %PathFinderComponent # Fix me!
@onready var animalDetector: AnimalDetectionComponent = %AnimalDetectionComponent
@onready var gamerTag: AnimalName = %Name

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

func _process(delta: float) -> void:
	actionManager.runCurrentAction(delta)	

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



