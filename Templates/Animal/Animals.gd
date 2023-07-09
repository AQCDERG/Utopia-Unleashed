extends CharacterBody3D
class_name Animal 

@export var damage: int

@export var health: HealthComponent

@export var agent: NavigationAgent3D

var world: World
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


# fix/use later.
# mesh2.mesh.material.set_shader_parameter("hpChange", float(healthLost)/float(startingHealth))

func attackRange() -> void:
	attack.emit()


func chase_enemy(enemyLocation: Vector3) -> void:
	agent.target_position = enemyLocation
	var selfPosition = global_transform.origin
	velocity.x = enemyLocation.x - selfPosition.x
	velocity.z = enemyLocation.z - selfPosition.z
	var lookdir = atan2(velocity.x, velocity.z)
	rotation.y = lerp_angle(rotation.y, lookdir, 0.03)

func retreat(enemyLocation: Vector3) -> void:
	agent.target_position = enemyLocation
	var selfPosition = global_transform.origin
	velocity.x = -(enemyLocation.x - selfPosition.x)
	velocity.z = -(enemyLocation.z - selfPosition.z)
	var lookdir = -atan2(velocity.x, velocity.z)
	rotation.y = -lerp_angle(rotation.y, lookdir, 0.03)
