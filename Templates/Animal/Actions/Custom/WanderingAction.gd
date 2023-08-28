class_name WanderingAction
extends AnimalAction

var pathFinder: PathFinderComponent

var _randomPosition: Vector3

func begin(animal: Animal) -> void:
	pathFinder = animal.pathFinder
	_randomPosition = _getRandomPosition()
	pathFinder.target_position = _randomPosition
	#_log.info("WanderingAction begin with target position: ", pathFinder.target_position)

func process(animal: Animal, delta: float) -> void:
	pathFinder.target_position = _randomPosition # brug!

	# Change animal velocity to reach target position
	const SPEED = 2.5
	const ACCELERATION = 50


	var targetPos: Vector3 = pathFinder.incrementalPositionToGetToTarget - Vector3(0,0.5,0)
	var targetVelocity: Vector3 = (targetPos - animal.global_transform.origin).normalized() * SPEED

	animal.velocity = animal.velocity.move_toward(targetVelocity, delta * ACCELERATION)
	
	if (_is_close_enough_to_target_position(animal)):
		_randomPosition = _getRandomPosition() # Find new position.
		pathFinder.target_position = _randomPosition
	if(_is_close_enough_to_increment_position(animal)):
		pathFinder.incrementalPositionToGetToTarget = pathFinder.get_next_path_position()
		#print("Print Increment " + str(pathFinder.incrementalPositionToGetToTarget));
		#print("nextPosition " + str(pathFinder.get_next_path_position()));
	
func _is_close_enough_to_target_position(ourAnimal: Animal) -> bool:
	const MIN_ACCEPTABLE_DISTANCE = 5

	# if the x and z are close to the target position, then we have reached it
	if (abs(ourAnimal.global_transform.origin.x - _randomPosition.x) < MIN_ACCEPTABLE_DISTANCE and
		abs(ourAnimal.global_transform.origin.z - _randomPosition.z) < MIN_ACCEPTABLE_DISTANCE):
		return true
	return false

func _is_close_enough_to_increment_position(ourAnimal: Animal):
	const MIN_ACCEPTABLE_DISTANCE = 0.1
	# if the x and z are close to the target position, then we have reached it
	if (abs(ourAnimal.global_transform.origin.x - pathFinder.incrementalPositionToGetToTarget.x) < MIN_ACCEPTABLE_DISTANCE and
		abs(ourAnimal.global_transform.origin.z -  pathFinder.incrementalPositionToGetToTarget.z) < MIN_ACCEPTABLE_DISTANCE):
		return true
	return false

func finish(animal: Animal) -> void:
	#_log.info("WanderingAction finish")
	pass

func _getRandomPosition() -> Vector3:
	const MIN: float = 0;
	const MAX: float = 100;
	const HEIGHT: float = 10;

	var randomPosition = Vector3(
	randf_range(MIN, MAX),
	HEIGHT,
	randf_range(MIN, MAX)
	)

	return randomPosition
