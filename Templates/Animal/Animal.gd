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
	DWARF,
	MYSTIQUE_FOX,
	CANNON
}

enum Team{
	NOT_CONTROLABLE,
	CONTROLABLE,

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
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity") * 2
var world: World


func _ready() -> void:
	# if (!is_multiplayer_authority()):
	# 	
	health.onDeath.connect(death)


	await get_tree().process_frame

	health.onHealthDecreased.connect(func(amountDecreased: int) -> void:
		#ClientRPC_spawnHurtParticles.rpc(amountDecreased)
		ClientRPC_spawnHurtParticles(amountDecreased)
	)

func death() -> void:
	queue_free()

	
func _process(delta: float) -> void:
	actionManager.runCurrentAction(delta)	

func _physics_process(delta: float) -> void:
	# if (!is_multiplayer_authority()):
	# 	return
	rotateMoveDirection()

	_handleGravity(delta)
	move_and_slide()

func _handleGravity(delta: float) -> void:
	if (!is_on_floor()):
		velocity.y -= gravity * delta

@rpc("authority", "call_local")
func ClientRPC_spawnHurtParticles(amount: int) -> void:
	hurtParticles.amount = amount
	hurtParticles.emitting = true

func rotateMoveDirection() -> void:
	var target: Vector3 = position + velocity
	if(velocity.length() < 0.1):
		return
	if(Vector3.UP.cross(target - global_position).is_zero_approx()):
		return
	const LOOK_IN_CORRECT_DIRECTION: bool = true
	if(velocity != Vector3.ZERO):
		#self.rotation.y = position.y + velocity.y
		#self.rotation.z = position.z + velocity.z
		look_at(target, Vector3(0,1,0), LOOK_IN_CORRECT_DIRECTION)
	#elif(self.rotation.x < 180):
	#	look_at(velocity + Vector3(90,0,0))
	#elif(self.rotation.x < 180):
	#	look_at(velocity +  Vector3(180,0,0))


