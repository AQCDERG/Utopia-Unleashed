extends RigidBody3D

var speed: float = 20.0
var is_active: bool = false
var direction: Vector3 = Vector3()
var bulletLifeSpan: int = 10
var shootingBody: Node3D
@export var damage: int = 5
@onready var hitRadius: Area3D = %HitRadius
@onready var removeParticle: GPUParticles3D = %HitParticle
@onready var bulletMesh: Node3D = %BulletMesh
@onready var movingSound: AudioStreamPlayer3D = %MovingSound
#@onready var reachTarget: AudioStreamPlayer3D = %ReachTarget

func _physics_process(delta):
	var move_distance = speed * delta
	var move_vector = direction.normalized() * move_distance
		
	self.global_transform.origin += move_vector

func launch(target, body):
	direction = target.position - self.global_transform.origin
	is_active = true
	shootingBody = body

func hitAnimal(body: Node3D):
	if(body == shootingBody):
		return
	if(body is Animal || body is Building):
		body.health.takeDamage(damage)
		removeBullet()


func _on_life_span_timeout() -> void:
	removeBullet() # Replace with function body.

func removeBullet():
	bulletMesh.visible = false
	removeParticle.emitting = true
	var particleLength: int = removeParticle.lifetime
	await get_tree().create_timer(particleLength).timeout
	queue_free()

func _on_hit_radius_body_entered(body:Node3D) -> void:
	hitAnimal(body)
