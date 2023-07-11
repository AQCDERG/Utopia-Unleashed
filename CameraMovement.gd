extends CharacterBody3D


const CAMERA_LOOK_SPEED: float = 100.0;

const MOVE_SPEED: float = 5.0;
const MOVE_UP_DOWN_SPEED: float = 5.0;
const MOVE_UP_DOWN_SPRINT_SPEED: float = 15.0;
const SPRINT_SPEED: float = 15.0;
const ACCELERATION: float = 160/.0;

var currentSpeed = 7.0
var zoom = Vector2(0.2, 0.2)
# --- Camera Shake ---

func _process(delta):
	var input_dir = Input.get_vector("move_a", "move_d", "move_w", "move_s");
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * currentSpeed, delta * ACCELERATION);
		velocity.z = move_toward(velocity.z, direction.z * currentSpeed, delta * ACCELERATION);
	else:
		velocity.x = move_toward(velocity.x, 0.0, delta * ACCELERATION);
		velocity.z = move_toward(velocity.z, 0.0, delta * ACCELERATION);
	# move_and_slide()
	global_position += velocity * delta;
	_handleCameraRotation(delta);
	_handleUpAndDown(delta);

func _handleCameraRotation(delta: float) -> void:
	var amount: float = CAMERA_LOOK_SPEED * delta;
	if Input.is_action_pressed("rotate_q"):
		rotation_degrees.y = rotation_degrees.y + amount;
	elif Input.is_action_pressed("rotate_e"):
		rotation_degrees.y = rotation_degrees.y - amount;

func _unhandled_input(event: InputEvent) -> void:
	_handleSpeed(event);

func _handleSpeed(event: InputEvent) -> void:
	if event.is_action_pressed("move_shift"):
		currentSpeed = SPRINT_SPEED;
	elif event.is_action_released("move_shift"):
		currentSpeed = MOVE_SPEED;

func _handleUpAndDown(delta: float) -> void:

	var moveSpeed = MOVE_UP_DOWN_SPEED;
	if Input.is_action_pressed("move_shift"):
		moveSpeed = MOVE_UP_DOWN_SPRINT_SPEED;
	
	if Input.is_action_pressed("move_up"):
		velocity.y = move_toward(velocity.y, moveSpeed, delta * ACCELERATION);
	elif Input.is_action_pressed("move_down"):
		velocity.y = move_toward(velocity.y, -moveSpeed, delta * ACCELERATION);
	else:
		velocity.y = move_toward(velocity.y, 0.0, delta * ACCELERATION);

# func _input(event):
# 	if event.is_action_pressed("rotate_q"):
# 		rotate_y(SPEED/20)
# 	elif event.is_action_pressed("rotate_e"):
# 		rotate_y(-SPEED/20)
# 	elif event.is_action_released("rotate_q"):
# 		rotate_y(0)
# 	elif event.is_action_released("rotate_e"):
# 		rotate_y(0)
