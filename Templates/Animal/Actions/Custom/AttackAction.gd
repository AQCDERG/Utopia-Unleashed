class_name AttackAction
extends AnimalAction

var mainBody: Node3D
var _randomPosition: Vector3
@onready var targetFinder: TargetedPathFinderComponent = %TargetedPathFinderComponent
@onready var animalDetection: AnimalDetectionComponent = %AnimalDetectionComponent
@onready var attackArea: AnimalDetectionComponent = %AttackArea
var timer: Timer
signal hasTarget(body: Node3D)

func _ready() -> void: 
	if(owner.faction == Animal.Faction.DWARF):
		animalDetection.onAnimalEntered.connect(_start_targeting_animal)
		animalDetection.onAnimalExited.connect(_stop_targeting_existing_animal)
		attackArea.onAnimalEntered.connect(_createAndConfigureTimer)
		print(attackArea.position)
		attackArea.onAnimalExited.connect(endTimer)

func _start_targeting_animal(body: Node3D) -> void:
	print(owner.name + " has a new target: " + body.name)
	targetFinder.target = body;
	hasTarget.emit(body)

func _stop_targeting_existing_animal(body: Node3D) -> void:
	if(targetFinder.target == body):
		targetFinder.target = null
		print("NULL")

func begin(animal: Animal) -> void:
	pass

func process(animal: Animal, delta: float) -> void:
	const SPEED = 8.5
	const ACCELERATION = 50
	
	# this is not the final position, 
	# but the position that the animal should move to in order to reach the target
	var targetPos: Vector3 = targetFinder.incrementalPositionToGetToTarget

	var velocityToTargetDirection: Vector3 = (targetPos - animal.global_transform.origin).normalized() * SPEED
	
	animal.velocity = animal.velocity.move_toward(velocityToTargetDirection, delta * ACCELERATION)

func attack(body: Node3D):
	print("TRIED ATTACKING")
	if(body == null):
		print("NILL")
		return
	if(body is Animal):
		body.health.takeDamage(10)
		print(str(owner.name) + " hit " + str(body.name))



	
func endTimer(body: Animal) -> void:
	if(body == targetFinder.target):
		timer = null
		print(" fff")

func _createAndConfigureTimer(body: Node3D) -> void:
	print(owner.name + "TRYING WITH" + body.name)
	if(targetFinder.target == null):
		print(owner.name + "has no target")
		return 
	if(body != targetFinder.target):
		print(targetFinder.target.name + " IS NOT " + body.name)
		return
	print(owner.name + "TRYING TO MAKE CONFIG " + owner.name)
	timer = Timer.new()
	timer.wait_time = 1
	timer.one_shot = false
	timer.timeout.connect(attack.bind(body))
	print("TIMER")
	add_child(timer)
	timer.start()
