class_name AttackAction
extends AnimalAction

var mainBody: Node3D
var _randomPosition: Vector3
@onready var targetFinder: TargetedPathFinderComponent = %TargetedPathFinderComponent
@onready var attackArea: Area3D = %AttackArea
@onready var animalDetection: AnimalDetectionComponent = %AnimalDetectionComponent
var timer: Timer
signal hasTarget(body: Node3D)

func _ready() -> void: 
	animalDetection.body_entered.connect(_start_targeting_animal)
	animalDetection.body_exited.connect(_stop_targeting_existing_animal)
	attackArea.body_entered.connect(_createAndConfigureTimer)
	attackArea.body_exited.connect(endTimer)

func _start_targeting_animal(body: Node3D) -> void:
	if(body is Animal):
		targetFinder.target = body;
		hasTarget.emit(body)

func _stop_targeting_existing_animal(body: Node3D) -> void:
	if(body is Animal && targetFinder.target == body):
		targetFinder.target = null;

func begin(animal: Animal) -> void:
	_log.info("AttackAction begin")
	print("HIT HIM")

func process(animal: Animal, delta: float) -> void:
	#print("Processing AttackAction")
	const SPEED = 8.5
	const ACCELERATION = 50
	
	# this is not the final position, 
	# but the position that the animal should move to in order to reach the target
	var targetPos: Vector3 = targetFinder.incrementalPositionToGetToTarget

	var velocityToTargetDirection: Vector3 = (targetPos - animal.global_transform.origin).normalized() * SPEED
	
	animal.velocity = animal.velocity.move_toward(velocityToTargetDirection, delta * ACCELERATION)

func attack(body: Node3D):
	print("TRACKER_ANY")
	if(body == null):
		print("NULL")
		return
	if(body is Animal):
		body.health.takeDamage(10)
		print("HIT")
		print(body.name)



	
func endTimer(body: Node3D) -> void:
	if !(body is Animal):
		return
	timer = null

func _createAndConfigureTimer(body: Node3D) -> void:
	if !(body is Animal):
		return
	timer = Timer.new()
	timer.wait_time = 5
	timer.one_shot = false
	timer.timeout.connect(attack.bind(body))
	add_child(timer)
	timer.start()
