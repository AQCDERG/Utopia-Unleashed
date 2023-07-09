extends Node3D
@onready var ballonAnimation: AnimationPlayer = $AnimationPlayer
@export var newOrigin: Node3D
@export_range(0, 30, 0.05) var angle_speed = 0.02 # The speed at which the object moves around the ellipse
@export var radius_speed = 1  # The speed at which the radius changes
var angle = 0.0  # The current angle around the ellipse
@export_range(0, 30, 0.05) var radius: float = 100.0 # The current radius of the ellipse
@export_range(0, 100, 1) var rotation_speed = 120
var rotationAngle = 0
var x: float
var z: float
func _process(delta):
		# Increase the angle by the angle speed
		angle += angle_speed * PI/12

		# Update the radius based on the radius speed
		radius = 100

		# Calculate the x and z positions of the object using elliptical coordinates
		x = cos(angle) * radius
		z = sin(angle) * radius

		# Set the position of the object
		self.position = Vector3(x + -182.482 , self.position.y, z + -348)
		rotationAngle += rotation_speed * delta

	# Set the rotation of the object
		self.rotation_degrees.y = -rotationAngle + 270
		

	#$Path3D.offset = time * 200.0
func _ready() -> void:
	ballonAnimation.play("armature_balloon|Scene")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	ballonAnimation.play("armature_balloon|Scene")
