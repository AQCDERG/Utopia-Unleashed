class_name RangeAttackAction
extends AnimalAction
var mainBody: Node3D
var _randomPosition: Vector3
var speed = 8.5
var acceleration = 50
@onready var targetFinder: TargetedPathFinderComponent = %TargetedPathFinderComponent
@onready var attackArea: AnimalDetectionComponent = %AttackArea
@onready var animalDetection: AnimalDetectionComponent = %AnimalDetectionComponent
var target: Node3D

var timer: Timer

signal hasTarget(body: Node3D)

func _ready() -> void: 
	attackArea.onAnimalEntered.connect(stopMovement)
	attackArea.onAnimalExited.connect(startMovement)


func begin(animal: Animal) -> void:
	_log.info("AttackAction begin")
	targetFinder.target = target
	print("TARGET")
	print(target)

func process(animal: Animal, delta: float) -> void:
	var targetPos: Vector3 = targetFinder.incrementalPositionToGetToTarget

	var velocityToTargetDirection: Vector3 = (targetPos - animal.global_transform.origin).normalized() * speed
	
	animal.velocity = animal.velocity.move_toward(velocityToTargetDirection, delta * acceleration)


func stopMovement(body: Node3D) -> void:
	if(targetFinder.target == body):
		await get_tree().create_timer(0.4).timeout
		speed = 0.1
		print("STOP")

func startMovement(body: Node3D) ->void:
	if(targetFinder.target == body):
		speed = 8.5
