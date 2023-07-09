extends Node3D

@onready var raycast: RayCast3D = get_parent()
@onready var aycast_owner = get_parent().get_owner()
@export var zypersFMedal: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	global_transform.origin = raycast.get_collision_point()
	global_rotation = Vector3.ZERO
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_transform.origin = raycast.get_collision_point()
