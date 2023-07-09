extends CharacterBody3D


var SPEED = 7.0
const JUMP_VELOCITY = 4.
var zoom = Vector2(0.2, 0.2)
# --- Camera Shake ---


 # Don't go over the limit.
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_a", "move_d", "move_w", "move_s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
		velocity.z = lerp(velocity.z, 0.0, 0.2)

	move_and_slide()
func _input(event):
	if event.is_action_pressed("rotate_q"):
		rotate_y(SPEED/20)
	elif event.is_action_pressed("rotate_e"):
		rotate_y(-SPEED/20)
	elif event.is_action_released("rotate_q"):
		rotate_y(0)
	elif event.is_action_released("rotate_e"):
		rotate_y(0)
	if event.is_action_pressed("move_shift"):
		SPEED *= 3
	elif event.is_action_released("move_shift"):
		SPEED = 5.0;
		
