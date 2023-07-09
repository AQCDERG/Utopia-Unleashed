extends Animal
var moving: int
var noRepeatHowl: bool
@export var movingAnimation: AnimationPlayer
@export var timer: Timer
@export var sight: RayCast3D
@export var navigation: NavigationRegion3D
@export var agent: NavigationAgent3D
@export var howling: AnimationPlayer
@export var howl: AudioStreamPlayer3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var chase: bool
var enemyX: float
var enemyZ: float
var next_location
var enemy:Vector3
func _ready() -> void:
	#sight.connect("cast_to", self, "_on_raycast_cast_to")
	pass

func _process(delta: float) -> void:

	velocity.y -= gravity * delta #for gravity
	movingAnimation.speed_scale = velocity.length() * 0.1
	if velocity != Vector3.ZERO && chase == false:
		var lookdir = atan2(velocity.x, velocity.z)
		rotation.y = lerp_angle(rotation.y, lookdir, 0.03)
	if(chase == true):
		chase_enemy(enemy)
	move_and_slide()

func _physics_process(delta: float) -> void:
	agent.get_next_path_position()


func chase_enemy(enemyLocation: Vector3) -> void:
	agent.target_position = enemyLocation
	var wolfPosition = global_transform.origin
	velocity.x = enemyLocation.x - wolfPosition.x
	velocity.z = enemyLocation.z - wolfPosition.z
	var lookdir = atan2(velocity.x, velocity.z)
	rotation.y = lerp_angle(rotation.y, lookdir, 0.03)

	print(enemyLocation)
	# var lookdir = atan2(velocity.x, velocity.y)

	# rotation.y = lerp_angle(rotation.y, lookdir, 0.03)
	# movingAnimation.play("Bip01|Take 0we01|BaseLayer")
	# print(enemyLocation)
	# var lookdir = atan2(enemyX, enemyZ)
	# rotation.y = lerp_angle(rotation.y, lookdir, 0.03)
	# velocity.x = enemyX - self.global_position.x
	# velocity.z = enemyZ - self.global_position.z


func _on_timer_timeout() -> void:
	moving_wolf_speed()
	# def _on_raycast_cast_to():
	# if result.collider != null and result.collider.name == "Sheep":
	# 		# Do something if the raycast hits a sheep
	# 		print("Wolf sees a sheep!")

func moving_wolf_speed() -> void:
	if(chase == false):
		print("Chase = false(changed velocity.x and velocity.y)")
		moving = randi_range(1,8)
		if(moving != 1): #1 will be howling
			velocity.x = randi_range(-10,10) 
			velocity.z = randi_range(-10,10)
			while(velocity.x <= 3 and velocity.x >= -3):
				velocity.x = randi_range(-10,10) 
			while(velocity.z <= 3 and velocity.z >= -3):
				velocity.z = randi_range(-10,10)
			movingAnimation.play("Bip01|Take 001|BaseLayer")
			print("MOVE FATSO") # Replace with function body.
		else:
			howling.speed_scale = 3.0/timer.wait_time
			howling.play("Howl")
			
			velocity.x = 0
			velocity.z = 0

		timer.wait_time = randi_range(4, 10)
	else:
		chase_enemy(enemy)
		
	
func _on_area_3d_body_entered(body:Node3D) -> void:
	if(body is Animal):
		enemy = body.global_transform.origin
		print(body)
		print("HELL HOOUND")
		chase = true

func _on_attack_area_body_entered(body:Node3D) -> void:
	if(body is CharacterBody3D && body != self):
		body.health.takeDamage(10)
		howling.play("Attack")
		chase = false
		print("HES DEAD")


func _on_area_3d_body_exited(body:Node3D) -> void:
	if(body is CharacterBody3D && body != self):
		chase = false
		print("You stopped")
