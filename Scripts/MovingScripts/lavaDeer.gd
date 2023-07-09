extends Animal

@export var timer: Timer
@export var animation: AnimationPlayer
@export var twirlingMustache: AnimationPlayer
@export var attaking: AnimationPlayer
@export var skeleton: Skeleton3D
@export var bloodParticle: GPUParticles3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var moving: bool =  randi_range(1, 2) == 1

func _ready() -> void:
	randomize()
	twirlingMustache.play("mustacheTwirl 2")
	currentHealth = 60
func _process(delta: float) -> void:
	velocity.y -= gravity * delta #for gravity
	animation.speed_scale = velocity.length()
	if(currentHealth <= 0):
		queue_free()
	#skeleton.animate_physical_bones = true
	#skeleton.clear_bones()
	#skeleton.apply_impulse()

	if velocity != Vector3.ZERO:
		var lookdir = atan2(velocity.x, velocity.z)
		rotation.y = lerp_angle(rotation.y, lookdir, 0.03)
	move_and_slide()

func _on_turning_timer_timeout() -> void:
	moving = randi_range(1, 2) == 1
	if(moving):
		velocity.x = randi_range(-5,5) 
		velocity.z = randi_range(-5,5) 
		animation.play("Moving")

	
	# else:
	# 	animation.stop()
	
	timer.wait_time = randi_range(1, 6) # generate a random delay between 1 and 6 seconds



