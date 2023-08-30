class_name Building
extends StaticBody3D

static func GetScene() -> PackedScene:
	push_error("This method should be overriden by the child class!")
	return null

static func GetCurrencyCost() -> Array[Currency]:
	push_error("This method should be overriden by the child class!")
	return []

enum Type {
  HONOR_GENERATOR = 0,
  LOG_CABIN = 1,
  EVIL_CASTLE = 2,
  HEADQUARTER = 3,
  MANA_DOG = 4,
  LAVA_TOWER = 5,
	WATCH_TOWER = 6
}

enum Level { # unimplemented
	LEVEL_1 = 1,
	LEVEL_2 = 2,
	LEVEL_3 = 3,
	LEVEL_4 = 4,
	LEVEL_5 = 5,
	LEVEL_6 = 6,
}

const CREATION_ANIMATION_NAME = "barraksRise"
const DESTRUCTION_ANIMATION_NAME = "FallingBuilding"

@export var price: int
@export var buildingType: Type

### @export var _maxLevel: Level
@export var _creationTimeSeconds: float 

@onready var _creationStartedParticle: GPUParticles3D = %CreationParticle
@onready var _creationFinishedParticle: GPUParticles3D = %CreationFinishedParticle

@onready var clickDetection: ClickDetectionComponent = %ClickDetectionComponent
@onready var health: HealthComponent = %HealthComponent

@onready var _creationAnimationPlayer: AnimationPlayer = %CreationAnimationPlayer
@onready var _destructionAnimationPlayer: AnimationPlayer = %DestructionAnimationPlayer
@onready var _creationAudio: AudioStreamPlayer3D = %CreationAudio


###var _currentLevel: Level
var _world: World

func _enter_tree() -> void:
	_world = Game.world
	_startCreatingBuilding()

func _ready() -> void:
	# Health component not available until ready.
	health.onDeath.connect(_destroy) 
	_creationAudio.play()
	_creationAnimationPlayer.play("RiseAnimation")

func _startCreatingBuilding() -> void:
	get_tree().create_timer(_creationTimeSeconds).timeout.connect(func():
		buildingCreated_callback()
	)

func buildingCreated_callback() -> void:
	_creationStartedParticle.emitting = false
	_creationFinishedParticle.emitting = true

func _selfDestruct() -> void:
	_refundHalf()
	_destroy()

func _refundHalf() -> void:
	_world.honor.addHonor(price / 2)

func _destroy() -> void:
	_destructionAnimationPlayer.play(DESTRUCTION_ANIMATION_NAME)
	_queue_free_when_destruction_animation_finished()

func _queue_free_when_destruction_animation_finished() -> void:
	_destructionAnimationPlayer.animation_finished.connect(queue_free)
