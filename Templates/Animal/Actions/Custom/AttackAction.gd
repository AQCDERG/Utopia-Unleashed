class_name AttackAction
extends AnimalAction

var _randomPosition: Vector3
@onready var targetFinder: TargetedPathFinderComponent = %TargetedPathFinderComponent

@onready var attackArea: Area3D = %AttackArea

func _ready() -> void:
	attackArea.body_entered.connect(_start_targeting_animal)
	attackArea.body_exited.connect(_stop_targeting_existing_animal)

func _start_targeting_animal(body: Node3D) -> void:
	if(body is Animal):
		targetFinder.target = body;

func _stop_targeting_existing_animal(body: Node3D) -> void:
	if(body is Animal && targetFinder.target == body):
		targetFinder.target = null;

func begin(animal: Animal) -> void:
	_log.info("AttackAction begin")

func process(animal: Animal, delta: float) -> void:
	print("Processing AttackAction")

	const SPEED = 8.5
	const ACCELERATION = 50
	
	# this is not the final position, 
	# but the position that the animal should move to in order to reach the target
	var targetPos: Vector3 = targetFinder.incrementalPositionToGetToTarget

	var velocityToTargetDirection: Vector3 = (targetPos - animal.global_transform.origin).normalized() * SPEED
	
	animal.velocity = animal.velocity.move_toward(velocityToTargetDirection, delta * ACCELERATION)		
